import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:pinpin/common/extension/bloc_extension.dart';
import 'package:pinpin/common/service/app_service.dart';
import 'package:pinpin/common/utils/app_utils.dart';
import 'package:pinpin/data/mapper/chat_detail_mapper.dart';
import 'package:pinpin/data/models/chat_model.dart';
import 'package:pinpin/data/models/user_model.dart';
import 'package:pinpin/domain/use_cases/chat_use_case.dart';
import 'package:pinpin/domain/use_cases/storage_use_case.dart';

import '../../../../common/configs/default_environment.dart';
import '../../../../common/service/key.dart';
import '../../../bloc/base_bloc/base_bloc.dart';
import '../../../widgets/chat_view/chatview.dart';

part 'chat_detail_cubit.freezed.dart';
part 'chat_detail_state.dart';

@injectable
class ChatDetailCubit extends BaseBloc<ChatDetailState> {
  ChatDetailCubit(this.appService, this.chatUseCase, this.storageUseCase)
      : super(
          const ChatDetailState(),
        );

  late ChatController chatController;
  ChatModel data = const ChatModel();
  late List<UserModel> members;
  final AppService appService;
  final ChatUseCase chatUseCase;
  StreamSubscription? _subscription;
  StreamSubscription? _chatSubscription;
  final StorageUseCase storageUseCase;

  @override
  initState(List<dynamic> params) {
    data = params[0] as ChatModel;
    members = params[1] as List<UserModel>;
    chatController = ChatController(
      initialMessageList: [],
      scrollController: ScrollController(),
      currentUser: ChatMapper.convertUser(appService.state.user!),
      otherUsers: data.members.map((e) => ChatMapper.convertUser(e)).toList(),
    );
    get();
  }

  void onSendTap(
    String message,
    ReplyMessage replyMessage,
    MessageType messageType,
  ) async {
    final data = Message(
      id: DateTime.now().toString(),
      createdAt: DateTime.now(),
      message: message,
      sentBy: chatController.currentUser.id,
      replyMessage: replyMessage,
      messageType: messageType,
    );
    chatController.addMessage(data);
    await send(data);
  }

  @override
  close() async {
    super.close();
    _subscription?.cancel();
    _chatSubscription?.cancel();
  }

  onRely(Message message) {}

  Future send(Message message) async {
    if (message.messageType == MessageType.image) {
      File? avatar = File(message.message);
      String storagePath =
          '${DefaultEnvironment.chat}/${DateTime.now().toIso8601String()}';

      final result = await storageUseCase.put(
        imageToUpload: avatar,
        imagePathStorage: storagePath,
      );

      result.fold((url) {
        message = message.copyWith(
          message: url,
        );
      }, (error) => showSnackbar(translationKey: error.toString()));
    }
    if (isNullEmpty(data.uId)) {
      final result = await chatUseCase.createOrUpdate(data: data);
      result.fold(
        (value) {
          data = value;
        },
        (error) {
          showSnackbar(translationKey: error.message);
        },
      );
    }
    message = message.copyWith(
      status: MessageStatus.read,
    );
    final result = await chatUseCase.sendOrUpdateMessage(
        data: message, chatId: data.uId ?? '', idKey: data.idKey!);
    if (result != null) {
      showSnackbar(translationKey: result.message);
    }
  }

  Future delete(String id) async {
    final result =
        await chatUseCase.deleteMessage(id: id, chatId: data.uId ?? '');
    chatController.initialMessageList.removeWhere(
      (element) => element.id == id,
    );

    if (result != null) {
      showSnackbar(translationKey: result.message);
    }
  }

  get() async {
    if (members.isNotEmpty) {
      final result = await chatUseCase.isExitMessage(members: members);
      data = data.copyWith(uId: result);
      if (isNullEmpty(result)) return;
    }

    _subscription?.cancel();
    _subscription = chatUseCase
        .getMessages(
      chatId: data.uId ?? '',
    )
        .listen((event) {
      event.fold(
        (value) async {
          //decryp data
          for (int i = 0; i < value.length; i++) {
            KeyApp keyApp = KeyApp();
            final key = await keyApp.getKeyAes(data.idKey!);
            final message = keyApp.decrypted(
                value[i].message, key!.$1.base64, key.$2.base64);
            //
            value.insert(
                i,
                value[i].copyWith(
                  message: message,
                ));
            value.removeAt(i + 1);
          }
          //
          if (chatController.initialMessageList.isEmpty) {
            for (final i in value) {
              i.setStatus = MessageStatus.read;
            }
            chatController.loadMoreData(value);
          } else {
            chatController.initialMessageList.clear();
            chatController.loadMoreData(value);
          }
        },
        (error) {
          showSnackbar(translationKey: error.message);
        },
      );
    });
  }
}
