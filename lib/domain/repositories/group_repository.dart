import 'package:either_dart/either.dart';
import 'package:pinpin/data/models/group_model.dart';
import 'package:pinpin/data/models/user_model.dart';

import '../../common/exception/app_error.dart';

abstract class GroupRepository {
  Future<AppError?> create({
    required GroupModel group,
  });

  Stream<Either<List<GroupModel>, AppError>> getUnsubscribe(String authorId);
  Stream<Either<List<GroupModel>, AppError>> get(String authorId);
  Stream<Either<GroupModel, AppError>> getDetail(String id);
  Future<AppError?> addMembers(UserModel user, String id);
  Future<AppError?> leave(UserModel user, String id);
  Future<AppError?> delete(String id);
}
