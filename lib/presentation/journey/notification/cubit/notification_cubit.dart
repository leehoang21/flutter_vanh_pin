import 'dart:async';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:pinpin/common/configs/notification_config/notification_config.dart';
import 'package:pinpin/common/enums/app_enums.dart';
import 'package:pinpin/common/service/app_service.dart';
import 'package:pinpin/common/utils/app_utils.dart';
import 'package:pinpin/data/models/friend_model.dart';
import 'package:pinpin/domain/use_cases/friend_use_case.dart';
import 'package:pinpin/domain/use_cases/group_use_case.dart';
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
    this.notificationConfig,
    this.groupUseCase,
  ) : super(const NotificationState());
  final FriendUseCase friendUseCase;
  final AppService appService;
  final UserUseCase userUseCase;
  final NotificationConfig notificationConfig;
  final GroupUseCase groupUseCase;
  StreamSubscription? notificationSubscription;

  @override
  Future onInit() async {
    super.onInit();
  }

  action(NotificationModel notification) async {
    try {
      await appService.readNotification(notification);
      if (notification.type == NotificationType.addFriend) {
        await _acceptAddFriend(notification.author);
      } else if (notification.type == NotificationType.login) {
        await _sendKey(notification.user!, notification.content ?? '',
            notification.token ?? '', notification.id ?? '');
      } else if (notification.type == NotificationType.joinGroup) {
        await _addGroup(notification);
      }
    } on Exception catch (_) {}
  }

  _acceptAddFriend(UserModel? user) async {
    if (user == null) return;
    await friendUseCase.addFriend(FriendModel(
      user: user,
      status: FriendStatus.accepted,
      author: appService.state.user,
    ));

    try {
      appService.setUser(
        appService.state.user!.copyWith(
          friends: [
            ...appService.state.user!.friends,
            FriendModel(
              user: user,
              status: FriendStatus.accepted,
              author: appService.state.user,
            ),
          ],
        ),
      );
      final user0 = await userUseCase.get();
      if (user0 != null) {
        appService.setUser(user0);
      }
    } catch (e) {
      logger(e);
    }
  }

  _addGroup(NotificationModel notification) async {
    return groupUseCase.addMembers(
        notification.author!,
        notification.id!,
        notification.content == GroupType.public.name
            ? GroupType.public
            : GroupType.private);
  }

  _sendKey(
      UserModel user, String device, String token, String publicKey) async {
    final KeyApp keyApp = KeyApp();
    final key0 = await keyApp.getKeyAes(appService.state.user!.uId!);
    //
    notificationConfig.sendMessenger(
      NotificationModel(
        type: NotificationType.accessAccount,
        createdAt: DateTime.now(),
        author: appService.state.user,
        user: user,
        token: '${key0!.$1.base64},,,${key0.$2.base64}',
        content: device,
        id: user.uId,
      ),
      token: token,
      publicKey: publicKey,
    );
  }
}
