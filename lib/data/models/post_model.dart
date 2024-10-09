import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pinpin/data/models/group_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'emojis_model.dart';
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
    GroupModel? group,
    required DateTime time,
    required String content,
    @Default([]) List<EmojisModel>? emojis,
    @Default(0) int commentCount,
    @Default(0) int shareCount,
    PostModel? share,
    String? uId,
  }) = _PostModel;

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);

  factory PostModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return PostModel.fromJson(data).copyWith(uId: doc.id);
  }
}
