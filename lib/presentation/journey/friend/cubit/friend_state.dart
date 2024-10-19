part of 'friend_cubit.dart';

class FriendState extends Equatable {
  final List<UserModel> users;

  const FriendState(this.users);

  FriendState copyWith({
    List<UserModel>? users,
  }) {
    return FriendState(
      users ?? this.users,
    );
  }

  @override
  List<Object?> get props => [users];
}
