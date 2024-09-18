import 'package:injectable/injectable.dart';
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
}
