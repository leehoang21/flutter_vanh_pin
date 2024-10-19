import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../common/exception/app_error.dart';
import '../../data/models/notification_model.dart';
import '../repositories/notification_repository.dart';

@injectable
class NotificationUseCase {
  final NotificationRepository repository;

  NotificationUseCase({required this.repository});

  Stream<List<NotificationModel>> get() {
    return repository.get();
  }

  Future<void> read(String? id) {
    return repository.read(id);
  }

  Future<NotificationModel> addNotification(NotificationModel model) {
    return repository.addNotification(model);
  }

  Stream<Either<List<NotificationModel>, AppError>> listen(
      DateTime time, NotificationType type, String content) {
    return repository.listen(time, type, content);
  }

  Stream<Either<List<NotificationModel>, AppError>> listenChat() {
    return repository.listenChat();
  }
}
