import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'friend_model.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  // ignore: invalid_annotation_target
  @JsonSerializable(explicitToJson: true)
  const factory UserModel({
    String? phoneNumber,
    String? userName,
    String? email,
    String? avatar,
    String? uId,
    String? google,
    String? background,
    String? address,
    String? education,
    String? job,
    DateTime? birthday,
    @Default([]) List<String> devices,
    @Default(<FriendModel>[]) List<FriendModel> friends,
    @Default(<String>[]) List<String> groupIds,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  factory UserModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserModel.fromJson(data);
  }
}
