import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:pinpin/common/extension/bloc_extension.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import '../../../../../common/configs/default_environment.dart';
import '../../../../../data/models/user_model.dart';
import '../../../../../domain/use_cases/auth_use_case.dart';
import '../../../../../domain/use_cases/storage_use_case.dart';
import '../../../../bloc/base_bloc/base_bloc.dart';
import '../../../../routers/app_router.dart';

part 'register_state.dart';

@injectable
class RegisterCubit extends BaseBloc<RegisterState> {
  final StorageUseCase pickImageUseCase;
  final AuthUseCase authUseCase;

  RegisterCubit({
    required this.pickImageUseCase,
    required this.authUseCase,
  }) : super(
          const RegisterState(
            userModel: UserModel(
              phoneNumber: '',
              uId: '',
            ),
          ),
        );

  @override
  void initState(List<dynamic> params) async {
    emit(
      state.copyWith(
        userModel: UserModel(
          phoneNumber: params[0] as String?,
          uId: null,
        ),
      ),
    );
  }

  Future addAvatar(XFile? image) async {
    try {
      if (image == null) return;

      emit(
        state.copyWith(avatar: File(image.path)),
      );
    } catch (e) {
      showSnackbar(translationKey: e.toString());
    }
  }

  Future<void> register(
      {required String email,
      required String userName,
      required String phoneNumber,
      required String password}) async {
    showLoading();
    //login
    UserModel user = state.userModel;
    File? avatar = state.avatar;
    const String storagePath = DefaultEnvironment.avatar;
    if (avatar != null) {
      final result = await pickImageUseCase.put(
        imageToUpload: avatar,
        imagePathStorage: storagePath,
      );

      result.fold((url) {
        user = user.copyWith(
          avatar: url,
        );
        emit(state.copyWith(userModel: user));
      }, (error) => showSnackbar(translationKey: error.toString()));
    }

    user = user.copyWith(
      email: email,
      userName: userName,
      phoneNumber: phoneNumber,
    );
    emit(
      state.copyWith(
        userModel: user,
      ),
    );

    final error = await authUseCase.register(
      user: state.userModel,
      password: password,
    );
    if (error != null) {
      showSnackbar(translationKey: error.message);
      return;
    }
    hideLoading();
    replace(
      const MainRoute(),
    );
  }

  void showSnackbar({required String translationKey}) {}
}
