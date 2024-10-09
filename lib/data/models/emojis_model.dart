import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'user_model.dart';

part 'emojis_model.freezed.dart';
part 'emojis_model.g.dart';

enum ChatType {
  single,
  group,
}

@freezed
class EmojisModel with _$EmojisModel {
  // ignore: invalid_annotation_target
  @JsonSerializable(
    explicitToJson: true,
  )
  const factory EmojisModel({
    String? emoji,
    UserModel? author,
  }) = _EmojisModel;

  factory EmojisModel.fromJson(Map<String, dynamic> json) =>
      _$EmojisModelFromJson(json);

  factory EmojisModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return EmojisModel.fromJson(data);
  }
}
