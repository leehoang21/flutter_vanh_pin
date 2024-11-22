import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pie_menu/pie_menu.dart';
import 'package:pinpin/common/configs/default_environment.dart';
import 'package:pinpin/common/configs/local_storage/local_storage.dart';
import 'package:pinpin/data/models/user_model.dart';
import 'package:injectable/injectable.dart';
import '../../data/models/notification_model.dart';
import '../../presentation/bloc/base_bloc/base_bloc.dart';

@singleton
class AppService extends BaseBloc<AppServiceState> {
  AppService(this.localStorage) : super(AppServiceState.initial());
  final PieMenuController pieMenuController = PieMenuController();

  final LocalStorage localStorage;

  Future setUser(UserModel? user) async {
    emit(state.copyWith(
      user: user,
    ));
    //
    final notificationString = await localStorage
            .read('${DefaultEnvironment.notifications}${user?.uId}') ??
        '';
    final List<NotificationModel> notifications =
        NotificationModel.fromList(notificationString);
    //
    final messageString = await localStorage
            .read('${DefaultEnvironment.notificationMessages}${user?.uId}') ??
        '';
    final List<NotificationModel> messages =
        NotificationModel.fromList(messageString);
    //
    emit(state.copyWith(
      notifications: notifications,
      messages: messages,
    ));

    localStorage.write(DefaultEnvironment.user, json.encode(user?.toJson()));
  }

  addNotification(NotificationModel model) {
    if (model.isMessage) {
      emit(
        state.copyWith(
          messages: [
            ...state.messages,
            model,
          ],
          message: model,
        ),
      );
      pieMenuController.openMenu();
    } else {
      emit(
        state.copyWith(
          notifications: [
            ...state.notifications,
            model,
          ],
          notificationCount: state.notificationCount + 1,
        ),
      );
    }
  }

  resetCount() {
    emit(state.copyWith(notificationCount: 0));
  }

  void setCredential(AuthCredential? credential) {
    emit(state.copyWith(credential: credential));
  }

  readNotification(NotificationModel model) async {
    List<NotificationModel> notifications = state.notifications;
    for (var i = 0; i < notifications.length; i++) {
      if (notifications[i].equal(model)) {
        notifications = [
          ...state.notifications.sublist(0, i),
          model.copyWith(
            isRead: true,
          ),
          ...state.notifications.sublist(i + 1),
        ];
      }
    }
    //
    await localStorage.write(
        '${DefaultEnvironment.notifications}${state.user?.uId}',
        NotificationModel.toList(notifications));
    emit(state.copyWith(notifications: notifications));
  }
}

class AppServiceState extends Equatable {
  final UserModel? user;
  final AuthCredential? credential;
  final List<NotificationModel> notifications;
  final List<NotificationModel> messages;
  final int notificationCount;

  final NotificationModel message;

  const AppServiceState(this.user, this.credential, this.notifications,
      this.messages, this.notificationCount, this.message);

  @override
  List<Object?> get props =>
      [user, credential, notifications, messages, notificationCount, message];

  AppServiceState copyWith({
    UserModel? user,
    AuthCredential? credential,
    List<NotificationModel>? notifications,
    List<NotificationModel>? messages,
    int? notificationCount,
    NotificationModel? message,
  }) {
    return AppServiceState(
      user ?? this.user,
      credential ?? this.credential,
      notifications ?? this.notifications,
      messages ?? this.messages,
      notificationCount ?? this.notificationCount,
      message ?? this.message,
    );
  }

  factory AppServiceState.initial() {
    // ignore: prefer_const_literals_to_create_immutables
    return const AppServiceState(null, null, [], [], 0, NotificationModel());
  }
}
