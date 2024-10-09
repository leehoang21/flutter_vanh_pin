import 'package:either_dart/either.dart';
import '../../common/exception/app_error.dart';
import '../../data/models/comment_model.dart';

abstract class CommentRepository {
  Future<AppError?> create({required CommentModel model});

  Stream<Either<List<CommentModel>, AppError>> get(String postId);
}
