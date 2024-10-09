import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'user_model.dart';

part 'chat_model.freezed.dart';
part 'chat_model.g.dart';

enum ChatType {
  single,
  group,
}

@freezed
class ChatModel with _$ChatModel {
  // ignore: invalid_annotation_target
  @JsonSerializable(
    explicitToJson: true,
  )
  const factory ChatModel({
    @Default([]) List<UserModel> members,
    @Default([]) List<String> memberIds,
    String? status,
    DateTime? updatedAt,
    DateTime? createdAt,
    ChatType? chatType,
    String? chatName,
    String? chatAvatar,
    String? chatContent,
    String? uId,
  }) = _ChatModel;

  factory ChatModel.fromJson(Map<String, dynamic> json) =>
      _$ChatModelFromJson(json);

  factory ChatModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return ChatModel.fromJson(data).copyWith(uId: doc.id);
  }
}
