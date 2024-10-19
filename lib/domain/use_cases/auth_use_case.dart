import 'package:either_dart/either.dart';
import 'package:pinpin/common/configs/default_environment.dart';
import 'package:pinpin/common/configs/local_storage/local_storage.dart';
import 'package:pinpin/common/configs/notification_config/notification_config.dart';
import 'package:pinpin/common/service/app_service.dart';
import 'package:injectable/injectable.dart';
import 'package:pinpin/domain/repositories/notification_repository.dart';
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
  final LocalStorage localStorage;
  final NotificationRepository notificationRepository;
  final NotificationConfig notificationConfig;
  AuthUseCase(
    this.notificationRepository,
    this.notificationConfig, {
    required this.repository,
    required this.userRepository,
    required this.appService,
    required this.localStorage,
  });

  Future<AppError?> signOut() async {
    appService.setUser(null);
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
      notificationConfig.sendToken();
      appService.setUser(user);
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
      //save token
      final token = await repository.getJWT();
      if (token != null) {
        localStorage.write(DefaultEnvironment.token, token);
      }
      //
      await login(
          loginType: LoginType.password, email: user.email, password: password);
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

  Future<Either<UserModel, AppError>> loginWithToken(String token) async {
    final result = await repository.loginWithToken(token);
    return await result.fold(
      (user) async {
        final user = await userRepository.get();
        if (user != null) {
          appService.setUser(user);

          notificationConfig.sendToken();
          return Left(user);
        }
        return Right(AppError(message: StringConstants.userNotExists));
      },
      (error) {
        return Right(error);
      },
    );
  }

  Future<void> logout() async {
    await repository.logout();
    localStorage.delete(DefaultEnvironment.token);
    return Future.value();
  }

  Future<String?> getJWT() => repository.getJWT();
}
