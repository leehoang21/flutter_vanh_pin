import 'package:pinpin/common/extension/bloc_extension.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:pinpin/domain/use_cases/auth_use_case.dart';
import 'package:pinpin/presentation/routers/app_router.dart';

import '../../../../domain/use_cases/post_use_case.dart';
import '../../../bloc/base_bloc/base_bloc.dart';

part 'settings_cubit.freezed.dart';
part 'settings_state.dart';

@injectable
class SettingsCubit extends BaseBloc<SettingsState> {
  final PostUseCase postUseCase;
  final AuthUseCase authUseCase;
  SettingsCubit(this.postUseCase, this.authUseCase)
      : super(const SettingsState());

  void logout() async {
    await authUseCase.signOut();
    pushAndRemoveUntil(const LoginRoute(), predicate: (route) => false);
  }
}
