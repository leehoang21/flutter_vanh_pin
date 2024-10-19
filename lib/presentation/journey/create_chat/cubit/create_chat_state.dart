part of 'create_chat_cubit.dart';

class CreateChatState extends Equatable {
  final List<UserModel> users;

  const CreateChatState({required this.users});

  CreateChatState copyWith({List<UserModel>? users}) {
    return CreateChatState(
      users: users ?? this.users,
    );
  }

  @override
  List<Object?> get props => [];
}
