import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:pinpin/common/configs/default_environment.dart';
import 'package:pinpin/common/configs/local_storage/local_storage.dart';
import 'package:pinpin/data/models/notification_model.dart';
import 'package:pinpin/data/models/user_model.dart';
import 'package:injectable/injectable.dart';
import '../../presentation/bloc/base_bloc/base_bloc.dart';

@singleton
class AppService extends BaseBloc<AppServiceState> {
  AppService(this.localStorage) : super(AppServiceState.initial());

  final LocalStorage localStorage;

  void setUser(UserModel? user) {
    emit(AppServiceState(state.notifications, user: user));
    localStorage.write(DefaultEnvironment.user, json.encode(user?.toJson()));
  }

  void addNotification(NotificationModel notification) {
    final notifications = state.notifications;

    emit(state.copyWith(notifications: [
      ...notifications,
      notification,
    ]));
    saveNotification();
  }

  deleteNotification(NotificationModel notification) {
    final notifications = state.notifications;
    emit(state.copyWith(
      notifications:
          notifications.where((e) => !e.equal(notification)).toList(),
    ));
    saveNotification();
  }

  saveNotification() {
    localStorage.write('${DefaultEnvironment.notification}-${state.user?.uId}',
        json.encode(state.notifications.map((e) => e.toJson()).toList()));
  }

  getNotification() async {
    final data = await localStorage.read(DefaultEnvironment.notification);
    if (data != null) {
      final List<dynamic> list = json.decode(data);
      final List<NotificationModel> notifications = list
          .map((e) => NotificationModel.fromJson(e as Map<String, dynamic>))
          .toList();
      emit(state.copyWith(notifications: notifications));
    }
  }

  void read(NotificationModel notification) {
    final notifications = state.notifications;
    for (int i = 0; i < notifications.length; i++) {
      if (notifications[i].equal(notification)) {
        notifications[i] = notification.copyWith(
          isRead: true,
        );
      }
    }
    saveNotification();
  }
}

class AppServiceState extends Equatable {
  final UserModel? user;
  final List<NotificationModel> notifications;
  // ignore: prefer_const_constructors_in_immutables
  AppServiceState(this.notifications, {this.user});

  @override
  List<Object?> get props => [user, notifications];

  AppServiceState copyWith({
    UserModel? user,
    List<NotificationModel>? notifications,
  }) {
    return AppServiceState(
      notifications ?? this.notifications,
      user: user ?? this.user,
    );
  }

  factory AppServiceState.initial() {
    // ignore: prefer_const_literals_to_create_immutables
    return AppServiceState([], user: null);
  }
}
