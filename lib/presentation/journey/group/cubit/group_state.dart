part of 'group_cubit.dart';

@freezed
class GroupState with _$GroupState {
  const factory GroupState({
    required List<PostModel> posts,
    required List<GroupModel> groups,
    required List<GroupModel> myGroups,
  }) = _Loaded;
}
