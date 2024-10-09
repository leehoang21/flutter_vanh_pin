import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pinpin/data/models/emojis_model.dart';

import 'user_model.dart';

part 'comment_model.freezed.dart';
part 'comment_model.g.dart';

@freezed
class CommentModel with _$CommentModel {
  // ignore: invalid_annotation_target
  @JsonSerializable(explicitToJson: true)
  const factory CommentModel({
    required UserModel author,
    required DateTime time,
    required String content,
    @Default([]) List<EmojisModel> emojis,
    required String postId,
  }) = _CommentModel;

  factory CommentModel.fromJson(Map<String, dynamic> json) =>
      _$CommentModelFromJson(json);
}
