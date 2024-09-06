import 'dart:async';
import 'dart:io';
import 'package:flutter_pin/common/extension/bloc_extension.dart';
import 'package:flutter_pin/domain/use_cases/post_use_case.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../common/configs/default_environment.dart';
import '../../../../domain/use_cases/storage_use_case.dart';
import '../../../bloc/base_bloc/base_bloc.dart';

part 'create_post_cubit.freezed.dart';
part 'create_post_state.dart';

@injectable
class CreatePostCubit extends BaseBloc<CreatePostState> {
  CreatePostCubit(this.storageUseCase, this.usecase)
      : super(CreatePostState([]));
  final StorageUseCase storageUseCase;
  final PostUseCase usecase;

  @override
  Future onInit() async {
    super.onInit();
  }

  void pickImage(List<File> images) {
    emit(state.copyWith(images: state.images + images));
  }

  createPost(String content) async {
    showLoading();
    final List<String> imagePaths = [];
    for (final image in state.images) {
      final String storagePath =
          '${DefaultEnvironment.images}/${DateTime.now().millisecondsSinceEpoch}.jpeg';
      final result = await storageUseCase.put(
        imageToUpload: image,
        imagePathStorage: storagePath,
      );
      result.fold(
        (url) => imagePaths.add(url),
        (error) => showSnackbar(translationKey: error.toString()),
      );
    }
    final error =
        await usecase.create(content: content, images: imagePaths, group: null);
    if (error != null) {
      showSnackbar(translationKey: error.toString());
    }
    hideLoading();
    pop('');
  }
}
