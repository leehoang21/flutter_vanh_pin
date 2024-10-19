part of 'detail_group_cubit.dart';

class GroupDetailState extends Equatable {
  final List<PostModel> posts;
  final GroupModel model;

  const GroupDetailState(this.posts, this.model);

  GroupDetailState copyWith({
    List<PostModel>? posts,
    GroupModel? model,
  }) {
    return GroupDetailState(
      posts ?? this.posts,
      model ?? this.model,
    );
  }

  @override
  List<Object?> get props => [posts, model];
}
