import 'package:equatable/equatable.dart';
import 'package:pinpin/common/extension/bloc_extension.dart';
import 'package:injectable/injectable.dart';
import 'package:pinpin/presentation/routers/app_router.dart';
import '../../../../../domain/use_cases/auth_use_case.dart';
import '../../../../bloc/base_bloc/base_bloc.dart';
import '../google_authenticator_contants.dart';
part 'google_authenticator_state.dart';

@injectable
class GoogleAuthenticatorCubit extends BaseBloc<GoogleAuthenticatorState> {
  GoogleAuthenticatorCubit(
    this.authUseCase,
  ) : super(const GoogleAuthenticatorState());
  final AuthUseCase authUseCase;

  void verify(String token) async {
    final result = await authUseCase.checkGoogleAuthenticator(token);
    if (result) {
      push(const MainRoute());
    } else {
      showSnackbar(translationKey: GoogleAuthenticatorScreenContants.error);
      pop('');
    }
  }
}
