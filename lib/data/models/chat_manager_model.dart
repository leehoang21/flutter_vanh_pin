import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'user_model.dart';

part 'chat_manager_model.freezed.dart';
part 'chat_manager_model.g.dart';

enum ContentType {
  text,
  image,
}

@freezed
class ChatManagerModel with _$ChatManagerModel {
  // ignore: invalid_annotation_target
  @JsonSerializable(explicitToJson: true)
  const factory ChatManagerModel({
    String? status,
    DateTime? updatedAt,
    DateTime? createdAt,
    ContentType? type,
    String? content,
    UserModel? author,
    String? uId,
    String? chatId,
  }) = _ChatManagerModel;

  factory ChatManagerModel.fromJson(Map<String, dynamic> json) =>
      _$ChatManagerModelFromJson(json);

  factory ChatManagerModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ChatManagerModel.fromJson(data).copyWith(uId: doc.id);
  }
}
