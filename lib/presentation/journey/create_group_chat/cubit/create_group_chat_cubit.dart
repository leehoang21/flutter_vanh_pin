import 'dart:io';
import 'package:pinpin/common/extension/bloc_extension.dart';

import 'package:pinpin/data/models/chat_model.dart';

import 'package:pinpin/domain/use_cases/chat_use_case.dart';

import 'package:injectable/injectable.dart';

import '../../../../common/configs/default_environment.dart';
import '../../../../domain/use_cases/storage_use_case.dart';
import '../../../bloc/base_bloc/base_bloc.dart';

@injectable
class CreateGroupChatCubit extends BaseBloc<String> {
  CreateGroupChatCubit(
    this.storageUseCase,
    this.usecase,
  ) : super('');
  final StorageUseCase storageUseCase;
  final ChatUseCase usecase;

  createGroup(
    String name,
    File? avatar,
  ) async {
    showLoading();
    late final String avatarUrl;
    //avatar
    if (avatar != null) {
      final String storagePath =
          '${DefaultEnvironment.images}/${DateTime.now().millisecondsSinceEpoch}';
      final result = await storageUseCase.put(
        imageToUpload: avatar,
        imagePathStorage: storagePath,
      );
      result.fold(
        (url) {
          avatarUrl = url;
        },
        (error) => showSnackbar(translationKey: error.toString()),
      );
    } else {
      avatarUrl = '';
    }
    //

    final model = ChatModel(
      createdAt: DateTime.now(),
      members: [],
      updatedAt: DateTime.now(),
      chatAvatar: avatarUrl,
      chatContent: '',
      chatName: name,
      chatType: ChatType.group,
    );
    final error = await usecase.createOrUpdate(data: model);
    if (error != null) {
      showSnackbar(translationKey: error.toString());
    } else {
      pop('');
    }
    hideLoading();
  }
}
