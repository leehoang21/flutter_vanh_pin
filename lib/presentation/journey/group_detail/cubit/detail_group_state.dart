part of 'detail_group_cubit.dart';

@freezed
class GroupDetailState with _$GroupDetailState {
  const factory GroupDetailState(List<PostModel> posts) = _Loaded;
}
