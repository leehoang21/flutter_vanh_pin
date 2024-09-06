import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_pin/data/models/user_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'group_model.freezed.dart';
part 'group_model.g.dart';

enum GroupType { private, public }

@freezed
class GroupModel with _$GroupModel {
  const factory GroupModel({
    UserModel? author,
    List<UserModel>? admins,
    List<UserModel>? members,
    String? avatar,
    String? uId,
    String? background,
    GroupType? type,
  }) = _GroupModel;

  factory GroupModel.fromJson(Map<String, dynamic> json) =>
      _$GroupModelFromJson(json);

  factory GroupModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return GroupModel.fromJson(data).copyWith(uId: doc.id);
  }
}
