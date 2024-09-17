import 'dart:async';
import 'dart:io';
import 'package:pinpin/common/enums/app_enums.dart';
import 'package:pinpin/common/extension/bloc_extension.dart';
import 'package:pinpin/common/service/app_service.dart';
import 'package:pinpin/data/models/group_model.dart';
import 'package:pinpin/domain/use_cases/group_use_case.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../../../common/configs/default_environment.dart';
import '../../../../common/constants/string_constants.dart';
import '../../../../domain/use_cases/storage_use_case.dart';
import '../../../bloc/base_bloc/base_bloc.dart';

part 'create_group_cubit.freezed.dart';
part 'create_group_state.dart';

@injectable
class CreateGroupCubit extends BaseBloc<CreateGroupState> {
  CreateGroupCubit(this.storageUseCase, this.usecase, this.appService)
      : super(CreateGroupState(null, null));
  final StorageUseCase storageUseCase;
  final GroupUseCase usecase;
  final AppService appService;

  @override
  Future onInit() async {
    super.onInit();
  }

  void pickAvatar(File image) {
    emit(state.copyWith(avatar: image));
  }

  void pickBackground(File image) {
    emit(state.copyWith(background: image));
  }

  createGroup(String content, GroupType type) async {
    showLoading();
    late final String avatar;
    late final String background;
    //avatar
    if (state.avatar != null) {
      final String storagePath =
          '${DefaultEnvironment.images}/${DateTime.now().millisecondsSinceEpoch}';
      final result = await storageUseCase.put(
        imageToUpload: state.avatar!,
        imagePathStorage: storagePath,
      );
      result.fold(
        (url) {
          avatar = url;
        },
        (error) => showSnackbar(translationKey: error.toString()),
      );
    } else {
      avatar = StringConstants.imageDefault;
    }
    //background
    if (state.background != null) {
      final String storagePath =
          '${DefaultEnvironment.images}/${DateTime.now().millisecondsSinceEpoch}';
      final result = await storageUseCase.put(
        imageToUpload: state.background!,
        imagePathStorage: storagePath,
      );
      result.fold(
        (url) {
          background = url;
        },
        (error) => showSnackbar(translationKey: error.toString()),
      );
    } else {
      background = StringConstants.imageDefault;
    }
    //
    final model = GroupModel(
      time: DateTime.now(),
      author: appService.user,
      name: content,
      type: type,
      avatar: avatar,
      background: background,
    );
    final error = await usecase.create(group: model);
    if (error != null) {
      showSnackbar(translationKey: error.toString());
    } else {
      pop('');
    }
    hideLoading();
  }
}
