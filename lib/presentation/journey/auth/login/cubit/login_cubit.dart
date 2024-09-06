import 'package:equatable/equatable.dart';
import 'package:flutter_pin/common/exception/app_error.dart';
import 'package:flutter_pin/common/extension/bloc_extension.dart';
import 'package:injectable/injectable.dart';

import '../../../../../common/enums/login_type.dart';
import '../../../../../domain/use_cases/auth_use_case.dart';
import '../../../../bloc/base_bloc/base_bloc.dart';
import '../../../../routers/app_router.dart';
part 'login_state.dart';

@injectable
class LoginCubit extends BaseBloc<LoginState> {
  LoginCubit(
    this.authUseCase,
  ) : super(const LoginState());
  final AuthUseCase authUseCase;

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
      pushAndRemoveUntil(
        const MainRoute(),
        predicate: (route) => false,
      );
    } else {
      showSnackbar(translationKey: result.message);
    }

    hideLoading();
  }
}
