part of 'notification_cubit.dart';

class NotificationData {
  final UserModel author;
  final DateTime time;
  final String title;

  NotificationData(
      {required this.author, required this.time, required this.title});
}

@freezed
class NotificationState with _$NotificationState {
  const factory NotificationState.loading() = _Loading;

  const factory NotificationState.loaded(List<NotificationData> datas) =
      _Loaded;
}
