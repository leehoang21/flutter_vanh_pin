import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pinpin/common/service/app_service.dart';
import 'package:pinpin/common/utils/app_utils.dart';
import 'package:injectable/injectable.dart';
import 'package:pinpin/data/models/friend_model.dart';
import 'package:pinpin/data/models/notification_model.dart';
import 'package:pinpin/domain/repositories/notification_repository.dart';
import '../../common/configs/default_environment.dart';
import '../../common/configs/firebase_config.dart';
import '../../domain/repositories/friend_repository.dart';
import '../../domain/repositories/storage_repository.dart';

@Injectable(as: FriendRepository)
class FriendRepositoryImpl extends FriendRepository {
  final FirebaseConfig config;
  final AppService appService;
  final NotificationRepository notificationRepository;

  final StorageRepository storageRepository;
  FriendRepositoryImpl(
    this.config,
    this.storageRepository,
    this.appService,
    this.notificationRepository,
  ) : super();

  DocumentReference<Map<String, dynamic>> _friends(String id) =>
      config.userDoc.collection(id).doc(DefaultEnvironment.user);

  Future<FriendModel> friendAdd(FriendModel model) async {
    await _friends(model.author?.uId ?? '').update({
      'friends': FieldValue.arrayUnion([model.toJson()]),
    });
    return model;
  }

  @override
  Future<void> deleteFriend(FriendModel model) async {
    try {
      await _friends(appService.state.user?.uId ?? '').update({
        'friends': FieldValue.arrayRemove([model.toJson()]),
      });
    } catch (e) {
      logger(e);
    }
  }

  @override
  Future<bool> addFriend(FriendModel model) async {
    try {
      if (model.status == FriendStatus.pending) {
        notificationRepository.addNotification(
          NotificationModel(
            type: NotificationType.addFriend,
            createdAt: DateTime.now(),
            author: appService.state.user,
            user: model.user,
            data: FriendModel(
              user: model.user,
              author: appService.state.user,
              status: FriendStatus.pending,
            ).toJson(),
          ),
        );
      } else {
        friendAdd(
          FriendModel(
            user: appService.state.user,
            status: FriendStatus.accepted,
            author: model.user,
          ),
        );
        friendAdd(
          FriendModel(
            user: model.user,
            status: FriendStatus.accepted,
            author: appService.state.user,
          ),
        );
        //
        notificationRepository.addNotification(
          NotificationModel(
            type: NotificationType.addFriendSuccess,
            createdAt: DateTime.now(),
            author: appService.state.user,
            user: model.user,
          ),
        );
      }

      return true;
    } catch (e) {
      return false;
    }
  }
}
