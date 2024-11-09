part of 'chat_detail_option_cubit.dart';

@freezed
class ChatDetailOptionState with _$ChatDetailOptionState {
  const factory ChatDetailOptionState(List<(bool, UserModel)> users) =
      _ChatDetailOptionState;
}
