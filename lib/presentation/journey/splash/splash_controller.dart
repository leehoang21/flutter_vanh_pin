import 'package:injectable/injectable.dart';
import 'package:pinpin/common/configs/default_environment.dart';
import 'package:pinpin/common/configs/local_storage/local_storage.dart';
import 'package:pinpin/domain/use_cases/auth_use_case.dart';

import '../../../common/di/di.dart';
import '../../../common/service/app_service.dart';
import '../../../common/service/key.dart';
import '../../../common/service/notification_message_service.dart';
import '../../../domain/use_cases/notification_use_case.dart';

@injectable
class SplashController {
  final AuthUseCase _authUseCase;
  final LocalStorage _localStorage;

  SplashController(this._localStorage, {required AuthUseCase authUseCase})
      : _authUseCase = authUseCase;

  Future<bool> login() async {
    final token = await _localStorage.read(DefaultEnvironment.token);
    if (token != null) {
      final result = await _authUseCase.loginWithToken(token);
      return result.fold(
        (l) async {
          final i = NotificationMessageService(
            await getIt.getAsync<NotificationUseCase>(),
            await getIt.getAsync<KeyService>(),
            getIt.get<AppService>(),
          );
          getIt.registerSingleton<NotificationMessageService>(i);

          return true;
        },
        (r) => false,
      );
    }
    return false;
  }
}
