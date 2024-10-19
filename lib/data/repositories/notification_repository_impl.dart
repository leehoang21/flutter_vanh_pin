import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:pinpin/common/service/app_service.dart';
import 'package:pinpin/common/utils/app_utils.dart';
import 'package:injectable/injectable.dart';
import 'package:pinpin/data/models/notification_model.dart';
import '../../common/configs/default_environment.dart';
import '../../common/configs/firebase_config.dart';
import '../../common/exception/app_error.dart';
import '../../domain/repositories/notification_repository.dart';
import '../../domain/repositories/storage_repository.dart';

@Injectable(as: NotificationRepository)
class NotificationRepositoryImpl extends NotificationRepository {
  final FirebaseConfig config;
  final AppService appService;
  final StorageRepository storageRepository;
  NotificationRepositoryImpl(
    this.config,
    this.storageRepository,
    this.appService,
  ) : super();

  CollectionReference<Map<String, dynamic>> get _notifications => config.userDoc
      .collection(DefaultEnvironment.customer)
      .doc(appService.state.user?.uId)
      .collection(DefaultEnvironment.notification);

  @override
  Stream<List<NotificationModel>> get() {
    try {
      final result =
          _notifications.orderBy('createdAt', descending: true).snapshots();
      return result.map((event) {
        try {
          return event.docs
              .map((e) => NotificationModel.fromDocument(e))
              .toList();
        } catch (e) {
          return [];
        }
      });
    } catch (e) {
      return const Stream.empty();
    }
  }

  @override
  Future<void> read(String? id) async {
    try {
      await _notifications.doc(id).update(
        {
          'isRead': true,
        },
      );
    } catch (e) {
      logger(e);
    }
  }

  @override
  Future<NotificationModel> addNotification(NotificationModel model) async {
    try {
      late final CollectionReference<Map<String, dynamic>> notifications;
      logger(model.user?.uId);
      if (model.user != null) {
        notifications = config.userDoc
            .collection(DefaultEnvironment.customer)
            .doc(model.user?.uId)
            .collection(DefaultEnvironment.notification);
      } else {
        notifications = _notifications;
      }
      final result = await notifications.add(model
          .copyWith(
            createdAt: DateTime.now(),
          )
          .toJson());
      await _notifications.doc(result.id).update(
        {
          'id': result.id,
        },
      );
      return model.copyWith(id: result.id);
    } catch (e) {
      logger(e);
      return model;
    }
  }

  @override
  Stream<Either<List<NotificationModel>, AppError>> listen(
      DateTime time, NotificationType type, String content) {
    try {
      final result = _notifications
          .where('type', isEqualTo: type.name)
          .where('content', isEqualTo: content)
          .snapshots();
      return result.map((event) {
        try {
          return Left(event.docs
              .map((e) => NotificationModel.fromDocument(e))
              .toList());
        } catch (e) {
          return Right(AppError(message: e.toString()));
        }
      });
    } catch (e) {
      logger(e);
      return const Stream.empty();
    }
  }

  @override
  Stream<Either<List<NotificationModel>, AppError>> listenChat() {
    try {
      logger(NotificationType.keyChat.name);
      final result = _notifications
          .where('type', isEqualTo: NotificationType.keyChat.name)
          .snapshots();
      return result.map((event) {
        try {
          return Left(event.docs
              .map((e) => NotificationModel.fromJson(e.data()))
              .toList());
        } catch (e) {
          return Right(AppError(message: e.toString()));
        }
      });
    } catch (e) {
      logger(e);
      return const Stream.empty();
    }
  }
}
