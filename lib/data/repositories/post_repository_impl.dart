import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:pinpin/common/service/app_service.dart';
import 'package:pinpin/common/utils/app_utils.dart';
import 'package:pinpin/data/models/group_model.dart';
import 'package:pinpin/data/models/post_model.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import '../../common/configs/default_environment.dart';
import '../../common/configs/firebase_config.dart';
import '../../common/exception/app_error.dart';
import '../../domain/repositories/post_reposotory.dart';

@Injectable(as: PostRepository)
class PostRepositoryImpl extends PostRepository {
  final FirebaseConfig config;
  final AppService appService;
  PostRepositoryImpl(
    this.config,
    this.appService,
  );

  CollectionReference<Map<String, dynamic>> get _doc =>
      config.userDoc.collection(DefaultEnvironment.post);

  @override
  Future<AppError?> create({
    required String content,
    required List<String> images,
    required GroupModel? group,
  }) async {
    if (config.auth.currentUser == null) return null;
    try {
      final param = PostModel(
          author: appService.user!,
          content: content,
          time: DateTime.now(),
          images: images,
          group: group);
      _doc.add(param.toJson());
    } catch (e) {
      return AppError(message: e.toString());
    }
    return null;
  }

  @override
  Stream<Either<Map<int, List<PostModel>>, AppError>> get() {
    final post = _doc
        .where('group', isEqualTo: null)
        .orderBy('time', descending: true)
        .snapshots()
        .map<Either<Map<int, List<PostModel>>, AppError>>((event) {
      try {
        final list =
            event.docs.map((e) => PostModel.fromJson(e.data())).toList();
        return Left({
          1: list,
        });
      } catch (e) {
        return Right(AppError(message: e.toString()));
      }
    });

    final postGroupPublic = _doc
        .where('group', isNotEqualTo: null)
        .where('group.type', isEqualTo: 'public')
        .orderBy('group')
        .orderBy('time', descending: true)
        .snapshots()
        .map<Either<Map<int, List<PostModel>>, AppError>>((event) {
      try {
        final list =
            event.docs.map((e) => PostModel.fromJson(e.data())).toList();
        return Left({
          2: list,
        });
      } catch (e) {
        return Right(AppError(message: e.toString()));
      }
    });

    final postGroupPrivate = _doc
        .where('group', isNotEqualTo: null)
        .where('group.type', isEqualTo: 'private')
        .where('group.members', arrayContains: appService.user!.uId)
        .orderBy('group')
        .orderBy('time', descending: true)
        .snapshots()
        .map<Either<Map<int, List<PostModel>>, AppError>>((event) {
      try {
        final list =
            event.docs.map((e) => PostModel.fromJson(e.data())).toList();
        return Left({3: list});
      } catch (e) {
        return Right(AppError(message: e.toString()));
      }
    });

    return MergeStream<Either<Map<int, List<PostModel>>, AppError>>([
      post,
      postGroupPublic,
      postGroupPrivate,
    ]);
  }

  @override
  Stream<Either<List<PostModel>, AppError>> getToGroup(List<String> groupIds) {
    if (isNullEmptyList(groupIds)) {
      return const Stream.empty();
    }
    final result = _doc
        .where('group.uId', whereIn: groupIds)
        .orderBy('time', descending: true)
        .snapshots()
        .map<Either<List<PostModel>, AppError>>((event) {
      try {
        final list =
            event.docs.map((e) => PostModel.fromJson(e.data())).toList();
        return Left(list);
      } catch (e) {
        return Right(AppError(message: e.toString()));
      }
    });
    return result;
  }

  @override
  Stream<Either<List<PostModel>, AppError>> getToUser(String userId) {
    final result = _doc
        .where('author.uId', isEqualTo: userId)
        .orderBy('time', descending: true)
        .snapshots()
        .map<Either<List<PostModel>, AppError>>((event) {
      try {
        final list =
            event.docs.map((e) => PostModel.fromJson(e.data())).toList();
        return Left(list);
      } catch (e) {
        return Right(AppError(message: e.toString()));
      }
    });
    return result;
  }
}
