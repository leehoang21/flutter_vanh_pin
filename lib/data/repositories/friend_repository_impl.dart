import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pinpin/common/configs/notification_config/notification_config.dart';
import 'package:pinpin/common/service/app_service.dart';
import 'package:pinpin/common/utils/app_utils.dart';
import 'package:injectable/injectable.dart';
import 'package:pinpin/data/models/friend_model.dart';
import 'package:pinpin/data/models/notification_model.dart';
import '../../common/configs/default_environment.dart';
import '../../common/configs/firebase_config.dart';
import '../../domain/repositories/friend_repository.dart';
import '../../domain/repositories/storage_repository.dart';

@Injectable(as: FriendRepository)
class FriendRepositoryImpl extends FriendRepository {
  final FirebaseConfig config;
  final AppService appService;
  final NotificationConfig notificationConfig;

  final StorageRepository storageRepository;
  FriendRepositoryImpl(
    this.config,
    this.storageRepository,
    this.appService,
    this.notificationConfig,
  ) : super();

  CollectionReference<Map<String, dynamic>> get _friends =>
      config.userDoc.collection(DefaultEnvironment.friend);

  @override
  Future<List<FriendModel>> get(FriendStatus status) async {
    try {
      final result = await _friends
          .where('author.uId', isEqualTo: config.auth.currentUser?.uid)
          .get();
      final list =
          result.docs.map((e) => FriendModel.fromJson(e.data())).toList();
      if (status == FriendStatus.all) return list;
      return list.where((element) => element.status == status).toList();
    } catch (e) {
      return [];
    }
  }

  Future<FriendModel> friendAdd(FriendModel model) async {
    final result = await _friends.add(
      model.toJson(),
    );
    await _friends.doc(result.id).update(
      {
        'uId': result.id,
      },
    );
    return model.copyWith(uId: result.id);
  }

  @override
  Future<void> deleteFriend(String? id, String? authorId) async {
    try {
      if (isNullEmpty(id) || isNullEmpty(authorId)) return;
      final result = await _friends
          .where('user.uId', isEqualTo: id)
          .where('author.uId', isEqualTo: authorId)
          .where('status', isEqualTo: 'pending')
          .get();
      for (final doc in result.docs) {
        await doc.reference.delete();
      }
    } catch (e) {
      logger(e);
    }
  }

  @override
  Future<bool> addFriend(FriendModel model) async {
    try {
      if (model.status == FriendStatus.pending) {
        final result = await friendAdd(model.copyWith(
          author: appService.state.user,
        ));
        final List<String> tokens =
            await notificationConfig.getToken(model.user?.uId ?? '3');
        for (final token in tokens) {
          notificationConfig.sendMessenger(
            NotificationModel(
              type: NotificationType.addFriend,
              time: DateTime.now(),
              author: appService.state.user,
              token: token,
              data: FriendModel(
                user: model.user,
                uId: result.uId,
                author: appService.state.user,
                status: FriendStatus.pending,
              ).toJson(),
            ),
          );
        }
      } else {
        deleteFriend(appService.state.user?.uId, model.user?.uId);
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
        final List<String> tokens =
            await notificationConfig.getToken(model.user?.uId ?? '3');
        for (final token in tokens) {
          notificationConfig.sendMessenger(
            NotificationModel(
              type: NotificationType.addFriendSuccess,
              time: DateTime.now(),
              author: appService.state.user,
              token: token,
            ),
          );
        }
      }

      return true;
    } catch (e) {
      return false;
    }
  }
}
