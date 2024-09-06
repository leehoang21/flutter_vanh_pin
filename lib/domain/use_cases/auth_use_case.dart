import 'package:flutter_pin/common/service/app_service.dart';
import 'package:injectable/injectable.dart';

import '../../common/constants/string_constants.dart';
import '../../common/enums/login_type.dart';
import '../../common/exception/app_error.dart';
import '../../common/utils/app_utils.dart';
import '../../data/models/user_model.dart';
import '../repositories/auth_repository.dart';
import '../repositories/user_repository.dart';

@injectable
class AuthUseCase {
  final AuthRepository repository;
  final UserRepository userRepository;
  final AppService appService;
  AuthUseCase({
    required this.repository,
    required this.userRepository,
    required this.appService,
  });

  Future<AppError?> signOut() async {
    appService.user = null;
    return repository.signOut();
  }

  Future<AppError?> login({
    required LoginType loginType,
    String? email,
    String? password,
  }) async {
    late final AppError? error;
    switch (loginType) {
      case LoginType.password:
        error = await repository.loginWithPassword(
          email: email!,
          pass: password!,
        );
      case LoginType.google:
        final result = await repository.loginWithGoogle();
        error = result.fold<AppError?>(
          (user) {
            userRepository.create(user);
            return null;
          },
          (error) {
            return error;
          },
        );

      default:
        return AppError(message: StringConstants.loginTypeNotSupport);
    }
    if (error != null) {
      return error;
    }
    final user = await userRepository.get();
    if (user != null) {
      appService.user = user;
      return null;
    }
    return AppError(message: StringConstants.userNotExists);
  }

  Future<AppError?> register({
    required UserModel user,
    String? password,
  }) async {
    if (!isNullEmpty(user.email) || !isNullEmpty(password)) {
      final AppError? result = await repository.register(
        user: user,
        password: password ?? "",
      );
      if (result != null) {
        return result;
      }
      await userRepository.create(user);
      appService.user = user;
      return null;
    } else {
      return AppError(message: StringConstants.msgErrorUnknown);
    }
  }

  Future<AppError?> updatePassword({
    required String email,
    required String password,
    required String newPass,
    required String oldPass,
  }) async {
    final result = await repository.updatePassword(
      email: email,
      password: password,
      newPass: newPass,
      oldPass: oldPass,
    );
    return result;
  }
}
