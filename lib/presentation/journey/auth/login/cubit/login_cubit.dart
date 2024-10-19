import 'dart:async';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:pinpin/common/configs/local_storage/local_storage.dart';
import 'package:pinpin/common/exception/app_error.dart';
import 'package:pinpin/common/extension/bloc_extension.dart';
import 'package:injectable/injectable.dart';
import 'package:pinpin/common/service/app_service.dart';
import 'package:pinpin/common/utils/app_utils.dart';
import 'package:pinpin/domain/use_cases/notification_use_case.dart';
import 'package:pinpin/domain/use_cases/user_use_case.dart';

import '../../../../../common/configs/default_environment.dart';
import '../../../../../common/di/di.dart';
import '../../../../../common/enums/login_type.dart';
import '../../../../../common/service/key.dart';
import '../../../../../common/service/notification_message_service.dart';
import '../../../../../data/models/notification_model.dart';
import '../../../../../domain/use_cases/auth_use_case.dart';
import '../../../../bloc/base_bloc/base_bloc.dart';
import '../../../../routers/app_router.dart';
part 'login_state.dart';

@injectable
class LoginCubit extends BaseBloc<LoginState> {
  LoginCubit(
    this.authUseCase,
    this.appService,
    this.notificationUseCase,
    this.keyService,
    this.userUseCase,
    this.localStorage,
  ) : super(const LoginState());
  final AuthUseCase authUseCase;
  AppService appService;
  NotificationUseCase notificationUseCase;
  StreamSubscription? loginSubscription;
  final UserUseCase userUseCase;
  final LocalStorage localStorage;
  final KeyService keyService;

  @override
  onInit() async {
    showLoading();
    super.onInit();
    hideLoading();
  }

  login(
    LoginType loginType, {
    String? email,
    String? password,
  }) async {
    showLoading();
    late final AppError? result;
    switch (loginType) {
      case LoginType.google:
        result = await authUseCase.login(
          loginType: loginType,
        );
        break;
      case LoginType.password:
        result = await authUseCase.login(
          loginType: loginType,
          email: email,
          password: password,
        );
        break;
      default:
    }

    if (result == null) {
      //
      final KeyApp keyApp = KeyApp();
      final key = await keyApp.getKeyAes(appService.state.user!.uId!);
      //
      final i = NotificationMessageService(
        await getIt.getAsync<NotificationUseCase>(),
        await getIt.getAsync<KeyService>(),
        getIt.get<AppService>(),
      );
      getIt.registerSingleton<NotificationMessageService>(i);
      //
      if (key != null) {
        pushAndRemoveUntil(
          const MainRoute(),
          predicate: (route) => false,
        );
      } else {
        final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
        final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        final time = DateTime.now();
        emit(state.copyWith(
          isNewDevice: true,
        ));
        notificationUseCase.addNotification(
          NotificationModel(
            type: NotificationType.login,
            createdAt: time,
            author: appService.state.user,
            content: '${androidInfo.brand} ${androidInfo.device}',
            token: keyService.publicKey.toString(),
          ),
        );
        listenLoginNewDivice(
            time, '${androidInfo.brand} ${androidInfo.device}');
      }
    } else {
      showSnackbar(translationKey: result.message);
    }

    hideLoading();
  }

  listenLoginNewDivice(DateTime time, String content) {
    loginSubscription = notificationUseCase
        .listen(time, NotificationType.key, content)
        .listen((event) {
      event.fold(
        (value) async {
          try {
            //
            for (final item in value) {
              final List<String> privateKey =
                  keyService.decrypteRsa(item.token ?? '').split(',,,');
              final key = privateKey[0];
              final iv = privateKey[1];

              final KeyApp keyApp = KeyApp();
              keyApp.setKeyAes(key, iv, appService.state.user?.uId ?? "");
              userUseCase.addPublicKey();
              //save token
              final token = await authUseCase.getJWT();
              if (token != null) {
                localStorage.write(DefaultEnvironment.token, token);
              }
              //
              logger(privateKey);
              //
              pushAndRemoveUntil(
                const MainRoute(),
                predicate: (route) => false,
              );
            }
          } catch (e) {
            logger(e);
          }
        },
        (error) {
          showSnackbar(translationKey: error.message);
        },
      );
    });
  }
}
