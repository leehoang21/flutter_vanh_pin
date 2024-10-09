import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:pinpin/common/extension/bloc_extension.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:pinpin/domain/use_cases/user_use_case.dart';
import '../../../../../common/configs/default_environment.dart';
import '../../../../../data/models/user_model.dart';
import '../../../../../domain/use_cases/storage_use_case.dart';
import '../../../bloc/base_bloc/base_bloc.dart';

part 'edit_profile_state.dart';

@injectable
class EditProfileCubit extends BaseBloc<EditProfileState> {
  final StorageUseCase pickImageUseCase;
  final UserUseCase userUseCase;

  EditProfileCubit({
    required this.pickImageUseCase,
    required this.userUseCase,
  }) : super(
          const EditProfileState(),
        );

  @override
  initState(List params) {
    emit(state.copyWith(avatar: params[0] as String?));
  }

  Future addAvatar(XFile? image) async {
    try {
      if (image == null) return;

      emit(
        state.copyWith(avatar: image.path),
      );
    } catch (e) {
      showSnackbar(translationKey: e.toString());
    }
  }

  Future<void> edit({
    required String userName,
    required String phoneNumber,
    required String liveIn,
    required String education,
    required String job,
  }) async {
    showLoading();
    //login
    UserModel user = UserModel(
      userName: userName,
      phoneNumber: phoneNumber,
      address: liveIn,
      education: education,
      job: job,
    );

    if (state.avatar != null) {
      File? avatar = File(state.avatar ?? '');
      const String storagePath = DefaultEnvironment.avatar;
      final result = await pickImageUseCase.put(
        imageToUpload: avatar,
        imagePathStorage: storagePath,
      );

      result.fold((url) {
        user = user.copyWith(
          avatar: url,
        );
      }, (error) => showSnackbar(translationKey: error.toString()));
    }
    final error = await userUseCase.update(user);
    if (error != null) {
      showSnackbar(translationKey: error.message);
      return;
    }
    hideLoading();
    pop('');
  }
}
