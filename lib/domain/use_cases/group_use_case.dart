import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../common/exception/app_error.dart';
import '../../data/models/group_model.dart';
import '../../data/models/user_model.dart';
import '../repositories/group_repository.dart';

@injectable
class GroupUseCase {
  final GroupRepository repository;

  GroupUseCase({
    required this.repository,
  });

  Future<AppError?> create({
    required GroupModel group,
  }) {
    return repository.create(group: group);
  }

  Stream<Either<List<GroupModel>, AppError>> getUnsubscribe(String authorId) {
    return repository.getUnsubscribe(authorId);
  }

  Stream<Either<List<GroupModel>, AppError>> get(String authorId) {
    return repository.get(authorId);
  }

  Stream<Either<GroupModel, AppError>> getDetail(String id) {
    return repository.getDetail(id);
  }

  Future<AppError?> addMembers(UserModel user, String id) {
    return repository.addMembers(user, id);
  }

  Future<AppError?> leave(UserModel user, String id) {
    return repository.leave(user, id);
  }

  Future<AppError?> delete(String id) {
    return repository.delete(id);
  }
}
