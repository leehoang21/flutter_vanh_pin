part of 'edit_profile_cubit.dart';

class EditProfileState extends Equatable {
  final String? avatar;
  const EditProfileState({
    this.avatar,
  });

  EditProfileState copyWith({
    String? avatar,
  }) {
    return EditProfileState(
      avatar: avatar ?? this.avatar,
    );
  }

  @override
  List<Object?> get props => [avatar];
}
