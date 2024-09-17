import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../common/exception/app_error.dart';
import '../../data/models/group_model.dart';
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
}
