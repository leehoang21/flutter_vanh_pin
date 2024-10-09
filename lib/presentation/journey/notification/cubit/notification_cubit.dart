import 'dart:async';
import 'package:injectable/injectable.dart';
import 'package:pinpin/common/service/app_service.dart';
import 'package:pinpin/common/utils/app_utils.dart';
import 'package:pinpin/data/models/friend_model.dart';
import 'package:pinpin/domain/use_cases/friend_use_case.dart';

import '../../../../data/models/user_model.dart';
import '../../../../domain/use_cases/user_use_case.dart';
import '../../../bloc/base_bloc/base_bloc.dart';

part 'notification_state.dart';

@injectable
class NotificationCubit extends BaseBloc<NotificationState> {
  NotificationCubit(this.friendUseCase, this.appService, this.userUseCase)
      : super(NotificationState());
  final FriendUseCase friendUseCase;
  final AppService appService;
  final UserUseCase userUseCase;

  @override
  Future onInit() async {
    appService.getNotification();
    super.onInit();
  }

  acceptAddFriend(UserModel? user) async {
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
}
