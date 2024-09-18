import 'dart:async';
import 'dart:io';
import 'package:chatview/chatview.dart';
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
import '../../../bloc/base_bloc/base_bloc.dart';

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
  final StorageUseCase storageUseCase;

  initState(ChatModel model, List<UserModel> members) {
    data = model;
    this.members = members;
    chatController = ChatController(
      initialMessageList: [],
      scrollController: ScrollController(),
      currentUser: ChatMapper.convertUser(appService.user!),
      otherUsers: model.members.map((e) => ChatMapper.convertUser(e)).toList(),
    );

    init();
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

  Future send(Message message) async {
    if (message.messageType != MessageType.text) {
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
    if (isNullEmpty(data.uId)) await createChat();
    final result = await chatUseCase.sendOrUpdateMessage(
        data: message, chatId: data.uId ?? '');
    if (result != null) {
      showSnackbar(translationKey: result.message);
    }
  }

  createChat() async {
    await chatUseCase.createOrUpdate(data: data);
  }

  init() {
    get();
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
        (value) {
          //lọc dữ liệu chưa có để thêm vào
          final list = value.where((element) {
            return !chatController.initialMessageList
                .any((e) => e.id == element.id);
          }).toList();
          chatController.loadMoreData(list);
          for (var element in chatController.initialMessageList) {
            element.setStatus = MessageStatus.delivered;
          }
        },
        (error) {
          showSnackbar(translationKey: error.message);
        },
      );
    });
  }
}
