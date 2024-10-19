import '../../common/exception/app_error.dart';
import '../../data/models/user_model.dart';

abstract class UserRepository {
  Future<AppError?> create(UserModel data);
  Future<AppError?> update(UserModel data);
  Future<UserModel?> get({
    String? id,
  });
  Future<List<String>> getPublicKey({
    String? uId,
  });
  Future<void> addPublicKey();
  Future<bool> exits();
  Future<List<UserModel>> getAll();
}
