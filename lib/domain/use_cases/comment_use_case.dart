import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../common/exception/app_error.dart';
import '../../data/models/comment_model.dart';
import '../repositories/comment_reposotory.dart';

@injectable
class CommentUseCase {
  final CommentRepository repository;

  CommentUseCase({
    required this.repository,
  });

  Future<AppError?> create({
    required CommentModel model,
  }) {
    return repository.create(model: model);
  }

  Stream<Either<List<CommentModel>, AppError>> get(String postId) {
    return repository.get(postId);
  }
}
