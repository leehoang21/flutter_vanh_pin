import 'package:injectable/injectable.dart';
import '../../common/exception/app_error.dart';
import '../../data/models/user_model.dart';
import '../repositories/user_repository.dart';

@injectable
class UserUseCase {
  final UserRepository repository;

  UserUseCase({
    required this.repository,
  });

  Future<List<UserModel>> getAll() {
    return repository.getAll();
  }

  Future<AppError?> update(UserModel data) {
    return repository.update(data);
  }

  Future<UserModel?> get({
    String? id,
  }) {
    return repository.get(id: id);
  }
}
