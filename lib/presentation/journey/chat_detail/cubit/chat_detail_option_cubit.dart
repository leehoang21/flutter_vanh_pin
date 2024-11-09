import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:pinpin/common/extension/bloc_extension.dart';
import 'package:pinpin/data/models/chat_model.dart';
import 'package:pinpin/data/models/user_model.dart';
import 'package:pinpin/domain/use_cases/chat_use_case.dart';
import '../../../bloc/base_bloc/base_bloc.dart';

part 'chat_detail_option_cubit.freezed.dart';
part 'chat_detail_option_state.dart';

@injectable
class ChatDetailOptionCubit extends BaseBloc<ChatDetailOptionState> {
  ChatDetailOptionCubit(this.chatUseCase)
      : super(const ChatDetailOptionState([]));

  final ChatUseCase chatUseCase;
  ChatModel data = const ChatModel();

  @override
  initState(List<dynamic> params) {
    data = params[0] as ChatModel;
  }

  addMember(List<UserModel> members) async {
    final result =
        await chatUseCase.addMember(memers: members, chatId: data.uId ?? '');
    if (result != null) {
      showSnackbar(translationKey: result.toString());
    }
  }

  removeMember(List<UserModel> members) async {
    final result =
        await chatUseCase.removeMember(memers: members, chatId: data.uId ?? '');
    if (result != null) {
      showSnackbar(translationKey: result.toString());
    }
  }

  delete() async {
    final result = await chatUseCase.delete(id: data.uId ?? '');
    if (result != null) {
      showSnackbar(translationKey: result.toString());
    }
  }
}
