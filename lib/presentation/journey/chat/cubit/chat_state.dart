part of 'chat_cubit.dart';

class ChatState extends Equatable {
  final List<ChatModel> datas;

  const ChatState({required this.datas});

  ChatState copyWith({List<ChatModel>? datas}) {
    return ChatState(datas: datas ?? this.datas);
  }

  @override
  List<Object?> get props => datas;
}
