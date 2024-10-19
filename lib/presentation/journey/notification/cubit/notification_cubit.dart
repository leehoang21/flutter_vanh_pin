import 'dart:async';
import 'package:crypton/crypton.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:pinpin/common/service/app_service.dart';
import 'package:pinpin/common/utils/app_utils.dart';
import 'package:pinpin/data/models/friend_model.dart';
import 'package:pinpin/domain/use_cases/friend_use_case.dart';
import 'package:pinpin/domain/use_cases/notification_use_case.dart';

import '../../../../common/service/key.dart';
import '../../../../data/models/notification_model.dart';
import '../../../../data/models/user_model.dart';
import '../../../../domain/use_cases/user_use_case.dart';
import '../../../bloc/base_bloc/base_bloc.dart';

part 'notification_state.dart';
part 'notification_cubit.freezed.dart';

@injectable
class NotificationCubit extends BaseBloc<NotificationState> {
  NotificationCubit(
    this.friendUseCase,
    this.appService,
    this.userUseCase,
    this.notificationUseCase,
  ) : super(const NotificationState());
  final FriendUseCase friendUseCase;
  final AppService appService;
  final UserUseCase userUseCase;
  final NotificationUseCase notificationUseCase;
  StreamSubscription? notificationSubscription;

  @override
  Future onInit() async {
    get();
    super.onInit();
  }

  get() {
    notificationSubscription?.cancel();
    notificationSubscription = notificationUseCase.get().listen((event) {
      final notifications = event
          .where((element) =>
              element.type != NotificationType.message &&
              element.type != NotificationType.keyChat)
          .toList();
      emit(state.copyWith(notifications: notifications));
    });
  }

  read(String? id) async {
    await notificationUseCase.read(id);
  }

  action(NotificationModel notification) async {
    read(notification.id);
    if (notification.type == NotificationType.addFriend) {
      await _acceptAddFriend(notification.author);
    } else if (notification.type == NotificationType.login) {
      await _sendKey(notification.token ?? '', notification.content ?? '');
    }
  }

  _acceptAddFriend(UserModel? user) async {
    if (user == null) return;
    await friendUseCase.addFriend(FriendModel(
      user: user,
      status: FriendStatus.accepted,
      author: appService.state.user,
    ));

    try {
      final user0 = await userUseCase.get();
      if (user0 != null) {
        appService.setUser(user0);
      }
    } catch (e) {
      logger(e);
    }
  }

  _sendKey(String key, String device) async {
    final publicKey = RSAPublicKey.fromString(key);
    final KeyApp keyApp = KeyApp();
    final key0 = await keyApp.getKeyAes(appService.state.user!.uId!);
    final privateKey = publicKey.encrypt(
      '${key0!.$1.base64},,,${key0.$2.base64}',
    );
    //
    notificationUseCase.addNotification(NotificationModel(
      type: NotificationType.key,
      createdAt: DateTime.now(),
      author: appService.state.user,
      token: privateKey,
      content: device,
    ));
  }
}
