import 'package:either_dart/either.dart';
import 'package:pinpin/data/models/user_model.dart';

import '../../common/exception/app_error.dart';

abstract class AuthRepository {
  Future<AppError?> signOut();
  Future<AppError?> register({
    required UserModel user,
    required String password,
  });
  Future<AppError?> loginWithPassword({
    required String email,
    required String pass,
  });
  Future<AppError?> updatePassword({
    required String email,
    required String password,
    required String newPass,
    required String oldPass,
  });
  Future<Either<UserModel, AppError>> loginWithGoogle();
  Future<AppError?> loginWithBiometric();
  Future<Either<UserModel, AppError>> loginWithToken(String token);
  Future<String?> getJWT();
  Future<bool> checkGoogleAuthenticator(String token);
  Future<void> logout();
  Future<String?> registerGoogleAuthenticator(bool isAuthenticator);
  Future<AppError?> changePassword(String pass);
}
