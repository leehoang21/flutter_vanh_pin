import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:pinpin/common/service/app_service.dart';
import 'package:pinpin/data/models/chat_model.dart';
import 'package:injectable/injectable.dart';
import 'package:pinpin/data/models/user_model.dart';
import 'package:pinpin/domain/use_cases/chat_use_case.dart';

import '../../../../common/service/key.dart';
import '../../../bloc/base_bloc/base_bloc.dart';

part 'chat_state.dart';

@injectable
class ChatCubit extends BaseBloc<ChatState> {
  ChatCubit(this.useCase, this.appService)
      : super(
          const ChatState(
            datas: [],
          ),
        );
  StreamSubscription? _subscription;
  final ChatUseCase useCase;
  final AppService appService;

  @override
  Future onInit() async {
    get();
    super.onInit();
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }

  void get() {
    _subscription?.cancel();
    _subscription = useCase.get().listen((event) {
      event.fold(
        (value) async {
          //change chat name to datas
          for (var i = 0; i < value.length; i++) {
            if (value[i].chatType == ChatType.single) {
              final members = value[i].members.firstWhere(
                    (element) => element.uId != appService.state.user?.uId,
                    orElse: () => UserModel(
                      userName: value[i].chatName,
                      avatar: value[i].chatAvatar,
                    ),
                  );

              value.insert(
                i,
                value[i].copyWith(
                  members: [members],
                  chatName: members.userName,
                  chatAvatar: members.avatar,
                ),
              );
              value.removeAt(i + 1);
            }
            //decryp data
            KeyApp keyApp = KeyApp();
            final key = await keyApp.getKeyAes(value[i].idKey ?? '');
            final message = keyApp.decrypted(
                value[i].chatContent ?? '', key!.$1.base64, key.$2.base64);
            //
            value.insert(
                i,
                value[i].copyWith(
                  chatContent: message,
                ));
            value.removeAt(i + 1);
            //
          }
          //
          emit(ChatState(datas: value));
        },
        (error) {
          emit(const ChatState(datas: []));
        },
      );
    });
  }
}
