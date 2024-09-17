import 'package:either_dart/either.dart';
import 'package:pinpin/data/models/group_model.dart';

import '../../common/exception/app_error.dart';

abstract class GroupRepository {
  Future<AppError?> create({
    required GroupModel group,
  });

  Stream<Either<List<GroupModel>, AppError>> getUnsubscribe(String authorId);
  Stream<Either<List<GroupModel>, AppError>> get(String authorId);
}
