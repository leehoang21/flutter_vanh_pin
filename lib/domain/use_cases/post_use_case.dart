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
  }) {
    return repository.create(content: content, images: images, group: group);
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
}
