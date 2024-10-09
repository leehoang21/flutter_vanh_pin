part of 'comment_cubit.dart';

@freezed
class CommentState with _$CommentState {
  const factory CommentState(List<CommentModel> comments) = _Loaded;
}
