import 'dart:async';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:pinpin/common/configs/biometric/biometric_config.dart';
import 'package:pinpin/common/configs/local_storage/local_storage.dart';
import 'package:pinpin/common/configs/notification_config/notification_config.dart';
import 'package:pinpin/common/exception/app_error.dart';
import 'package:pinpin/common/extension/bloc_extension.dart';
import 'package:injectable/injectable.dart';
import 'package:pinpin/common/service/app_service.dart';
import 'package:pinpin/common/utils/app_utils.dart';
import 'package:pinpin/domain/use_cases/user_use_case.dart';
import '../../../../../common/enums/login_type.dart';
import '../../../../../common/service/key.dart';
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
    this.notificationConfig,
    this.keyService,
    this.userUseCase,
    this.localStorage,
    this.biometricConfig,
  ) : super(const LoginState());
  final AuthUseCase authUseCase;
  AppService appService;
  NotificationConfig notificationConfig;
  StreamSubscription? loginSubscription;
  final UserUseCase userUseCase;
  final LocalStorage localStorage;
  final KeyService keyService;
  final BiometricConfig biometricConfig;

  @override
  onInit() async {
    showLoading();
    await canAuthBiometric();
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
      case LoginType.biometric:
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
      if (key != null) {
        if (appService.state.user?.isAuthenticator == true) {
          pushAndRemoveUntil(
            const GoogleAuthenticatorRoute(),
            predicate: (route) => false,
          );
        } else {
          pushAndRemoveUntil(
            const MainRoute(),
            predicate: (route) => false,
          );
        }
      } else {
        final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
        final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        final time = DateTime.now();
        emit(state.copyWith(
          isNewDevice: true,
        ));
        //
        final token = await notificationConfig.getTokenFirebase();
        notificationConfig.sendMessenger(NotificationModel(
          type: NotificationType.login,
          createdAt: time,
          author: appService.state.user,
          content: '${androidInfo.brand} ${androidInfo.device}',
          token: token,
          id: keyService.publicKey.toString(),
        ));
        listenLoginNewDivice(
            time, '${androidInfo.brand} ${androidInfo.device}');
      }
    } else {
      showSnackbar(translationKey: result.message);
    }

    hideLoading();
  }

  Future canAuthBiometric() async {
    final result = await biometricConfig.canAuthenticateBiometric;
    emit(state.copyWith(canAuthBiometric: result));
  }

  listenLoginNewDivice(DateTime time, String content) {
    loginSubscription = appService.stream.listen((event) async {
      try {
        //
        for (final item in event.notifications) {
          if (item.type != NotificationType.accessAccount) {
            continue;
          }
          final List<String> privateKey = (item.token ?? '').split(',,,');
          if (privateKey.length < 2) {
            continue;
          }
          final key = privateKey[0];
          final iv = privateKey[1];

          final KeyApp keyApp = KeyApp();
          keyApp.setKeyAes(key, iv, appService.state.user?.uId ?? "");
          //
          final user = await userUseCase.get();
          appService.setUser(user);
          notificationConfig.sendToken();
          loginSubscription?.cancel();
          pushAndRemoveUntil(
            const SplashRoute(),
            predicate: (route) => false,
          );
        }
      } catch (e) {
        logger(e);
      }
    });
  }
}
