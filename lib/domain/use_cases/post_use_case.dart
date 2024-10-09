import 'package:either_dart/either.dart';
import 'package:pinpin/data/models/group_model.dart';
import 'package:pinpin/domain/repositories/post_reposotory.dart';
import 'package:injectable/injectable.dart';

import '../../common/exception/app_error.dart';
import '../../data/models/post_model.dart';

@injectable
class PostUseCase {
  final PostRepository repository;

  PostUseCase({
    required this.repository,
  });

  Future<AppError?> create({
    required String content,
    required List<String> images,
    GroupModel? group,
    PostModel? share,
  }) {
    return repository.create(
        content: content, images: images, group: group, share: share);
  }

  Stream<Either<Map<int, List<PostModel>>, AppError>> get() {
    return repository.get();
  }

  Stream<Either<List<PostModel>, AppError>> getToGroup(
    List<String> groupIds,
  ) {
    return repository.getToGroup(groupIds);
  }

  Stream<Either<List<PostModel>, AppError>> getToUser(String userId) {
    return repository.getToUser(userId);
  }

  Future<AppError?> update({
    required PostModel model,
  }) {
    return repository.update(model: model);
  }

  Future<AppError?> updateShareCount(String postId) {
    return repository.updateShareCount(postId);
  }

  Future<AppError?> delete({
    required String postId,
  }) {
    return repository.delete(postId: postId);
  }

  Future<AppError?> like({
    required String emoji,
    required String postId,
    required bool isLike,
  }) {
    return repository.like(emoji: emoji, postId: postId, isLike: isLike);
  }
}
