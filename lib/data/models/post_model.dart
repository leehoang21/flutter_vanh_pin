import 'package:freezed_annotation/freezed_annotation.dart';

import 'user_model.dart';

part 'post_model.freezed.dart';
part 'post_model.g.dart';

@freezed
class PostModel with _$PostModel {
  // ignore: invalid_annotation_target
  @JsonSerializable(explicitToJson: true)
  const factory PostModel({
    @Default([]) List<String> images,
    required UserModel author,
    UserModel? group,
    required DateTime time,
    required String content,
  }) = _PostModel;

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);
}
