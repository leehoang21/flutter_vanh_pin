import 'package:either_dart/either.dart';
import 'package:pinpin/data/models/post_model.dart';

import '../../common/exception/app_error.dart';
import '../../data/models/group_model.dart';

abstract class PostRepository {
  Future<AppError?> create({
    required String content,
    required List<String> images,
    required GroupModel? group,
    PostModel? share,
  });

  Future<AppError?> update({
    required PostModel model,
  });

  Future<AppError?> updateCommentCount(bool isIncrement, String postId);

  Future<AppError?> updateShareCount(String postId);

  Future<AppError?> delete({
    required String postId,
  });

  Stream<Either<Map<int, List<PostModel>>, AppError>> get();
  Stream<Either<List<PostModel>, AppError>> getToGroup(
    List<String> groupIds,
  );
  Stream<Either<List<PostModel>, AppError>> getToUser(String userId);

  Future<AppError?> like({
    required String emoji,
    required String postId,
    required bool isLike,
  });
}
