part of 'create_group_cubit.dart';

@freezed
class CreateGroupState with _$CreateGroupState {
  factory CreateGroupState(
    File? avatar,
    File? background,
  ) = _CreateGroupState;
}
