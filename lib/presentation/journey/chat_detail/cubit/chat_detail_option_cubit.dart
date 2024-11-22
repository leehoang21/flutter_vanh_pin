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
    List<UserModel> members = params[1] as List<UserModel>;
    emit(ChatDetailOptionState(_get(members)));
  }

  List<(bool, UserModel)> _get(List<UserModel> users) =>
      users.map((e) => (false, e)).toList();

  addMember(List<UserModel> members) async {
    final result = await chatUseCase.addMember(memers: members, model: data);
    pop('');
    if (result != null) {
      showSnackbar(translationKey: result.toString());
    } else {
      data = data.copyWith(members: [...data.members, ...members]);
    }
  }

  removeMember(List<UserModel> members) async {
    final result = await chatUseCase.removeMember(memers: members, model: data);
    pop('');
    if (result != null) {
      showSnackbar(translationKey: result.toString());
    } else {
      data = data.copyWith(
          members: data.members
              .where((element) => !members.contains(element))
              .toList());
    }
  }

  delete() async {
    showLoading();
    final result = await chatUseCase.delete(id: data.uId ?? '');
    hideLoading();
    if (result != null) {
      showSnackbar(translationKey: result.toString());
    } else {
      await pop('');
      await pop('');
    }
  }

  changeUser(bool value, UserModel user) {
    final users = state.users.map((e) => e).toList();
    final index = users.indexWhere((element) => element.$2.uId == user.uId);
    if (index != -1) {
      users.insert(index, (value, user));
      users.removeAt(index + 1);
    } else {
      users.add((value, user));
    }
    emit(ChatDetailOptionState(users));
  }
}
