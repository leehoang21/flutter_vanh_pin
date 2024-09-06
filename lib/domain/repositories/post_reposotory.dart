import 'package:either_dart/either.dart';
import 'package:flutter_pin/data/models/post_model.dart';

import '../../common/exception/app_error.dart';
import '../../data/models/user_model.dart';

abstract class PostRepository {
  Future<AppError?> create({
    required String content,
    required List<String> images,
    required UserModel? group,
  });

  Future<Either<List<PostModel>, AppError>> get();
}
