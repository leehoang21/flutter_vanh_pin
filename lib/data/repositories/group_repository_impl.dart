import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:pinpin/common/configs/notification_config/notification_config.dart';
import 'package:pinpin/common/enums/app_enums.dart';
import 'package:pinpin/common/service/app_service.dart';
import 'package:pinpin/common/service/key.dart';
import 'package:pinpin/data/models/group_model.dart';
import 'package:pinpin/data/models/notification_model.dart';
import 'package:pinpin/data/models/user_model.dart';
import 'package:pinpin/domain/repositories/user_repository.dart';
import 'package:injectable/injectable.dart';
import '../../common/configs/default_environment.dart';
import '../../common/configs/firebase_config.dart';
import '../../common/exception/app_error.dart';
import '../../domain/repositories/group_repository.dart';

@Injectable(as: GroupRepository)
class GroupRepositoryImpl extends GroupRepository {
  final FirebaseConfig config;
  final AppService appService;
  final UserRepository userRepository;
  final NotificationConfig notificationConfig;
  GroupRepositoryImpl(
    this.config,
    this.appService,
    this.userRepository,
    this.notificationConfig,
  );

  CollectionReference<Map<String, dynamic>> get _doc =>
      config.userDoc.collection(DefaultEnvironment.group);

  @override
  Future<AppError?> create({
    required GroupModel group,
  }) async {
    if (config.auth.currentUser == null) return null;
    try {
      final param = group
          .copyWith(
            author: UserModel(
              uId: appService.state.user!.uId,
              userName: appService.state.user!.userName,
              avatar: appService.state.user!.avatar,
            ),
          )
          .toJson();
      final result = await _doc.add(param);
      final user = await userRepository.get();
      userRepository.update(user!.copyWith(
        groupIds: [...user.groupIds, result.id],
      ));
      //
      if (group.type == GroupType.private) {
        final KeyApp keyApp = KeyApp();
        final key = keyApp.gennerateKey;
        await keyApp.setKeyAes(key.$1.base64, key.$2.base64, result.id);
      }

      await _doc.doc(result.id).update({'uId': result.id});
    } catch (e) {
      return AppError(message: e.toString());
    }
    return null;
  }

  @override
  Stream<Either<List<GroupModel>, AppError>> get(String authorId) {
    final result = _doc
        .where('memberIds', arrayContains: authorId)
        .snapshots()
        .map<Either<List<GroupModel>, AppError>>((event) {
      try {
        final list =
            event.docs.map((e) => GroupModel.fromJson(e.data())).toList();
        return Left(list);
      } catch (e) {
        return Right(AppError(message: e.toString()));
      }
    });
    return result;
  }

  @override
  Stream<Either<List<GroupModel>, AppError>> getUnsubscribe(String authorId) {
    final result =
        _doc.snapshots().map<Either<List<GroupModel>, AppError>>((event) {
      try {
        final list =
            event.docs.map((e) => GroupModel.fromJson(e.data())).toList();

        return Left(list
            .where((element) => !element.memberIds!.contains(authorId))
            .toList());
      } catch (e) {
        return Right(AppError(message: e.toString()));
      }
    });
    return result;
  }

  @override
  Stream<Either<GroupModel, AppError>> getDetail(String id) {
    final result = _doc
        .where('memberIds', arrayContains: id)
        .snapshots()
        .map<Either<GroupModel, AppError>>((event) {
      try {
        final list =
            event.docs.map((e) => GroupModel.fromJson(e.data())).toList();
        if (list.isEmpty) return Right(AppError(message: 'Group not found'));
        return Left(list.first);
      } catch (e) {
        return Right(AppError(message: e.toString()));
      }
    });
    return result;
  }

  @override
  Future<AppError?> joinGroup(
      UserModel user, String id, GroupType type, String content) async {
    try {
      switch (type) {
        case GroupType.public:
          await _doc.doc(id).update({
            'members': FieldValue.arrayUnion([user.toJson()]),
            'memberIds': FieldValue.arrayUnion([user.uId]),
          });
          return null;

        default:
          await notificationConfig.sendMessenger(
            NotificationModel(
              type: NotificationType.joinGroup,
              createdAt: DateTime.now(),
              author: appService.state.user,
              user: user,
              token: null,
              content: type.name,
              id: id,
            ),
          );
          break;
      }
    } catch (e) {
      return AppError(message: e.toString());
    }
    return null;
  }

  @override
  Future<AppError?> addMembers(
      UserModel user, String id, GroupType type) async {
    try {
      await _doc.doc(id).update({
        'members': FieldValue.arrayUnion([user.toJson()]),
        'memberIds': FieldValue.arrayUnion([user.uId]),
      });
      String token = '';
      if (type == GroupType.private) {
        final KeyApp keyApp = KeyApp();
        final key = await keyApp.getKeyAes(id);
        token = '${key!.$1.base64},,,${key.$2.base64}';
      }
      await notificationConfig.sendMessenger(
        NotificationModel(
          type: NotificationType.addGroupSuccess,
          createdAt: DateTime.now(),
          author: appService.state.user,
          user: user,
          token: token,
          content: '',
          id: id,
        ),
      );
    } catch (e) {
      return AppError(message: e.toString());
    }
    return null;
  }

  @override
  Future<AppError?> removeMembers(
      UserModel user, String id, GroupType type) async {
    try {
      await _doc.doc(id).update({
        'members': FieldValue.arrayRemove([user.toJson()]),
        'memberIds': FieldValue.arrayRemove([user.uId]),
      });

      await notificationConfig.sendMessenger(
        NotificationModel(
          type: NotificationType.removeGroupSuccess,
          createdAt: DateTime.now(),
          author: appService.state.user,
          user: user,
          token: '',
          content: '',
          id: id,
        ),
      );
    } catch (e) {
      return AppError(message: e.toString());
    }
    return null;
  }

  @override
  Future<AppError?> delete(String id) async {
    try {
      await _doc.doc(id).delete();
      return null;
    } catch (e) {
      return AppError(message: e.toString());
    }
  }

  @override
  Future<AppError?> leave(UserModel user, String id) async {
    try {
      await _doc.doc(id).update({
        'members': FieldValue.arrayRemove([user.toJson()]),
        'memberIds': FieldValue.arrayRemove([user.uId]),
      });
      return null;
    } catch (e) {
      return AppError(message: e.toString());
    }
  }

  @override
  Future<AppError?> update(String avatar, String background, String id) async {
    try {
      final param = <String, String>{};
      if (avatar.isNotEmpty) param.addEntries([MapEntry('avatar', avatar)]);
      if (background.isNotEmpty) {
        param.addEntries([MapEntry('background', background)]);
      }
      await _doc.doc(id).update(param);
      return null;
    } catch (e) {
      return AppError(message: e.toString());
    }
  }
}
