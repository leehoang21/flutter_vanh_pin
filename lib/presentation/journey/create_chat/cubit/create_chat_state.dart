part of 'create_chat_cubit.dart';

@freezed
class CreateChatState with _$CreateChatState {
  const factory CreateChatState(
    List<UserModel>? users,
  ) = _CreateChatState;
}
