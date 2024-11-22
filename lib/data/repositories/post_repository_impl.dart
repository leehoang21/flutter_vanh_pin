import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:pinpin/common/configs/notification_config/notification_config.dart';
import 'package:pinpin/common/enums/app_enums.dart';
import 'package:pinpin/common/service/app_service.dart';
import 'package:pinpin/common/utils/app_utils.dart';
import 'package:pinpin/data/models/emojis_model.dart';
import 'package:pinpin/data/models/group_model.dart';
import 'package:pinpin/data/models/post_model.dart';
import 'package:injectable/injectable.dart';
import 'package:pinpin/data/models/user_model.dart';
import '../../common/configs/default_environment.dart';
import '../../common/configs/firebase_config.dart';
import '../../common/exception/app_error.dart';
import '../../common/service/key.dart';
import '../../domain/repositories/post_reposotory.dart';

@Injectable(as: PostRepository)
class PostRepositoryImpl extends PostRepository {
  final FirebaseConfig config;
  final AppService appService;
  final NotificationConfig notificationConfig;
  PostRepositoryImpl(
    this.config,
    this.appService,
    this.notificationConfig,
  );

  CollectionReference<Map<String, dynamic>> get _doc =>
      config.userDoc.collection(DefaultEnvironment.post);

  @override
  Future<AppError?> create({
    required String content,
    required List<String> images,
    required GroupModel? group,
    PostModel? share,
  }) async {
    if (config.auth.currentUser == null) return null;
    try {
      String content0 = content;
      List<String> images0 = images;
      if (group?.type == GroupType.private) {
        KeyApp keyApp = KeyApp();
        final key = await keyApp.getKeyAes(group?.uId ?? '');
        content0 = keyApp.encrypted(content, key!.$1.base64, key.$2.base64);
        images0 = images
            .map((e) => keyApp.encrypted(e, key.$1.base64, key.$2.base64))
            .toList();
      }

      final param = PostModel(
        uId: '',
        author: UserModel(
          uId: appService.state.user!.uId,
          userName: appService.state.user!.userName,
          avatar: appService.state.user!.avatar,
        ),
        content: content0,
        time: DateTime.now(),
        images: images0,
        share: share,
        group: GroupModel(
            type: group?.type,
            uId: group?.uId,
            name: group?.name,
            background: group?.background,
            author: UserModel(
              uId: group?.author?.uId,
              userName: group?.author?.userName,
              avatar: group?.author?.avatar,
            )),
      );
      _doc.add(param.toJson());
    } catch (e) {
      return AppError(message: e.toString());
    }
    return null;
  }

  @override
  Stream<Either<List<Future<PostModel>>, AppError>> get() {
    final post = _doc
        .orderBy('time', descending: true)
        .snapshots()
        .map<Either<List<Future<PostModel>>, AppError>>((event) {
      try {
        final list = event.docs.map(
          (e) async {
            var model = PostModel.fromDocument(e);
            if (model.group?.type == GroupType.private) {
              KeyApp keyApp = KeyApp();
              final key = await keyApp.getKeyAes(model.group!.uId!);
              final images = model.images
                  .map(
                      (e) => keyApp.decrypted(e, key!.$1.base64, key.$2.base64))
                  .toList();
              model = model.copyWith(
                content: keyApp.decrypted(
                    model.content, key!.$1.base64, key.$2.base64),
                share: model.share?.copyWith(
                  content: keyApp.decrypted(
                    model.share!.content,
                    key.$1.base64,
                    key.$2.base64,
                  ),
                  share: null,
                ),
                images: images,
              );
            }
            return model;
          },
        ).toList();
        return Left(list);
      } catch (e) {
        return Right(AppError(message: e.toString()));
      }
    });

    return post;
  }

  @override
  Stream<Either<List<Future<PostModel>>, AppError>> getToGroup(
      List<String> groupIds) {
    if (isNullEmptyList(groupIds)) {
      return const Stream.empty();
    }
    final result = _doc
        .where('group.uId', whereIn: groupIds)
        .orderBy('time', descending: true)
        .snapshots()
        .map<Either<List<Future<PostModel>>, AppError>>((event) {
      try {
        final list = event.docs.map(
          (e) async {
            var model = PostModel.fromDocument(e);
            if (model.group?.type == GroupType.private) {
              KeyApp keyApp = KeyApp();
              final key = await keyApp.getKeyAes(model.group!.uId!);
              final images = model.images
                  .map(
                      (e) => keyApp.decrypted(e, key!.$1.base64, key.$2.base64))
                  .toList();
              model = model.copyWith(
                content: keyApp.decrypted(
                    model.content, key!.$1.base64, key.$2.base64),
                share: model.share?.copyWith(
                  content: keyApp.decrypted(
                    model.share!.content,
                    key.$1.base64,
                    key.$2.base64,
                  ),
                  share: null,
                ),
                images: images,
              );
            }
            return model;
          },
        ).toList();
        return Left(list);
      } catch (e) {
        return Right(AppError(message: e.toString()));
      }
    });
    return result;
  }

  @override
  Stream<Either<List<Future<PostModel>>, AppError>> getToUser(String userId) {
    if (userId != appService.state.user!.uId) {
      final result = _doc
          .where('author.uId', isEqualTo: userId)
          .where('group.type', isNotEqualTo: 'private')
          .orderBy('group.type', descending: true)
          .orderBy('time', descending: true)
          .snapshots()
          .map<Either<List<Future<PostModel>>, AppError>>((event) {
        try {
          final list = event.docs.map(
            (e) async {
              var model = PostModel.fromDocument(e);
              return model;
            },
          ).toList();
          return Left(list);
        } catch (e) {
          return Right(AppError(message: e.toString()));
        }
      });
      return result;
    }
    //
    final result = _doc
        .where('author.uId', isEqualTo: userId)
        .orderBy('time', descending: true)
        .snapshots()
        .map<Either<List<Future<PostModel>>, AppError>>((event) {
      try {
        final list = event.docs.map(
          (e) async {
            var model = PostModel.fromDocument(e);

            if (model.group?.type == GroupType.private) {
              KeyApp keyApp = KeyApp();
              final key = await keyApp.getKeyAes(model.group!.uId!);
              model = model.copyWith(
                content: keyApp.decrypted(
                    model.content, key!.$1.base64, key.$2.base64),
                share: model.share?.copyWith(
                  content: keyApp.decrypted(
                    model.share!.content,
                    key.$1.base64,
                    key.$2.base64,
                  ),
                  share: null,
                ),
                images: model.images
                    .map((e) =>
                        keyApp.decrypted(e, key.$1.base64, key.$2.base64))
                    .toList(),
              );
            }
            return model;
          },
        ).toList();
        return Left(list);
      } catch (e) {
        return Right(AppError(message: e.toString()));
      }
    });
    return result;
  }

  @override
  Future<AppError?> like({
    required String emoji,
    required String postId,
    required bool isLike,
  }) async {
    try {
      final param = EmojisModel(
        emoji: emoji,
        author: appService.state.user!,
      );
      if (isLike) {
        await _doc.doc(postId).update({
          'emojis': FieldValue.arrayRemove([param.toJson()])
        });
      } else {
        await _doc.doc(postId).update({
          'emojis': FieldValue.arrayUnion([param.toJson()])
        });
      }
    } catch (e) {
      return AppError(message: e.toString());
    }
    return null;
  }

  @override
  Future<AppError?> delete({required String postId}) async {
    try {
      await _doc.doc(postId).delete();
    } catch (e) {
      return AppError(message: e.toString());
    }
    return null;
  }

  @override
  Future<AppError?> update({
    required PostModel model,
  }) async {
    try {
      await _doc.doc(model.uId).update(model.toJson());
    } catch (e) {
      return AppError(message: e.toString());
    }
    return null;
  }

  @override
  Future<AppError?> updateCommentCount(bool isIncrement, String postId) async {
    try {
      final param = isIncrement ? 1 : -1;
      await _doc
          .doc(postId)
          .update({'commentCount': FieldValue.increment(param)});
    } catch (e) {
      return AppError(message: e.toString());
    }
    return null;
  }

  @override
  Future<AppError?> updateShareCount(String postId) async {
    try {
      await _doc.doc(postId).update({'shareCount': FieldValue.increment(1)});
    } catch (e) {
      return AppError(message: e.toString());
    }
    return null;
  }
}
