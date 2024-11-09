import 'package:pinpin/common/configs/biometric/biometric_config.dart';
import 'package:pinpin/common/configs/firebase_config.dart';
import 'package:pinpin/common/extension/bloc_extension.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:pinpin/domain/use_cases/auth_use_case.dart';
import 'package:pinpin/presentation/routers/app_router.dart';
import '../../../../common/enums/login_type.dart';
import '../../../../common/exception/app_error.dart';
import '../../../../domain/use_cases/post_use_case.dart';
import '../../../bloc/base_bloc/base_bloc.dart';

part 'settings_cubit.freezed.dart';
part 'settings_state.dart';

@injectable
class SettingsCubit extends BaseBloc<SettingsState> {
  final PostUseCase postUseCase;
  final AuthUseCase authUseCase;
  final BiometricConfig biometricConfig;
  final FirebaseConfig firebaseConfig;
  SettingsCubit(this.postUseCase, this.authUseCase, this.biometricConfig,
      this.firebaseConfig)
      : super(const SettingsState(isRegisterBiometric: false));

  Future<String?> registerGoogleAuthenticator(bool isAuthenticator) async {
    return authUseCase.registerGoogleAuthenticator(isAuthenticator);
  }

  void logout() async {
    await authUseCase.signOut();
    pushAndRemoveUntil(const LoginRoute(), predicate: (route) => false);
  }

  Future registerBiometric() async {
    final error = await biometricConfig.registerBiometric();
    if (error != null) {
      emit(const SettingsState(isRegisterBiometric: false));
      showSnackbar(translationKey: error.toString());
    } else {
      emit(const SettingsState(isRegisterBiometric: true));
    }
  }

  void unRegisterBiometric() async {
    final error = await biometricConfig.unRegisterBiometric();
    if (error != null) {
      emit(const SettingsState(isRegisterBiometric: true));
      showSnackbar(translationKey: error.toString());
    } else {
      emit(const SettingsState(isRegisterBiometric: false));
    }
  }

  @override
  onInit() {
    checkRegisterBiometric();
    super.onInit();
  }

  void checkRegisterBiometric() async {
    final isRegisterBiometric =
        await biometricConfig.isRegisterBiometricThisAccount;
    emit(SettingsState(isRegisterBiometric: isRegisterBiometric));
  }

  Future<AppError?> login(
    LoginType loginType, {
    String? email,
    String? password,
  }) async {
    showLoading();

    switch (loginType) {
      case LoginType.google:
        final result = await authUseCase.loginWithGoogle();
        result.fold(
          (user) async {
            pop('');

            return null;
          },
          (error) async {
            return error;
          },
        );
      case LoginType.password:
        final result = await authUseCase.loginWithPassword(
          email: email!,
          pass: password!,
        );
        if (result != null) {
          return result;
        } else {
          pop('');

          return null;
        }

      default:
    }

    hideLoading();
    return null;
  }
}
