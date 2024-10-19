import 'package:either_dart/either.dart';
import 'package:pinpin/common/exception/app_error.dart';

import '../../data/models/notification_model.dart';

abstract class NotificationRepository {
  Stream<List<NotificationModel>> get();
  Future<void> read(String? id);
  Future<NotificationModel> addNotification(NotificationModel model);
  Stream<Either<List<NotificationModel>, AppError>> listen(
      DateTime time, NotificationType type, String content);
  Stream<Either<List<NotificationModel>, AppError>> listenChat();
}
