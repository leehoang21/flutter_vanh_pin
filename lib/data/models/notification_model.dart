import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pinpin/common/extension/string_extension.dart';
import 'package:pinpin/data/models/user_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_model.freezed.dart';
part 'notification_model.g.dart';

enum NotificationType {
  addFriend,
  message,
  comment,
  addFriendSuccess,
  addGroupSuccess,
  key,
  keyChat,
  login,
}

extension NotificationTypeExtension on NotificationType {
  String get title {
    switch (this) {
      case NotificationType.addFriend:
        return 'Add friend';
      case NotificationType.message:
        return 'Message';
      case NotificationType.comment:
        return 'Comment';
      case NotificationType.addFriendSuccess:
        return 'Your friend has accepted';
      case NotificationType.addGroupSuccess:
        return 'You have been approved';
      case NotificationType.key:
        return 'key';
      case NotificationType.login:
        return 'login';
      case NotificationType.keyChat:
        return 'keyChat';
    }
  }

  String content(String content, UserModel? author) {
    switch (this) {
      case NotificationType.addFriend:
        return 'You have a friend request from ${author?.userName}';
      case NotificationType.message:
        return 'You have a message from ${author?.userName}';
      case NotificationType.comment:
        return 'You have a comment from ${author?.userName}';
      case NotificationType.addFriendSuccess:
        return '${author?.userName} has accepted your friend request';
      case NotificationType.addGroupSuccess:
        return 'You have been approved by ${author?.userName}';
      case NotificationType.key:
        return 'Device $content has been granted access to your account!';
      case NotificationType.login:
        return 'The device $content is logged into your account, is this you?';
      case NotificationType.keyChat:
        return '';
    }
  }

  bool get checkRead {
    switch (this) {
      case NotificationType.addFriend:
      case NotificationType.login:
        return true;
      case NotificationType.message:
      case NotificationType.comment:
      case NotificationType.addFriendSuccess:
      case NotificationType.addGroupSuccess:
      case NotificationType.key:
      case NotificationType.keyChat:
        return false;
    }
  }

  String get titleAction {
    switch (this) {
      case NotificationType.addFriend:
      case NotificationType.login:
        return 'Accept'.tr;
      case NotificationType.message:
      case NotificationType.comment:
      case NotificationType.addFriendSuccess:
      case NotificationType.addGroupSuccess:
      case NotificationType.key:
      case NotificationType.keyChat:
        return '';
    }
  }
}

@freezed
class NotificationModel with _$NotificationModel {
  // ignore: invalid_annotation_target
  @JsonSerializable(explicitToJson: true)
  const factory NotificationModel({
    UserModel? author,
    NotificationType? type,
    UserModel? user,
    String? content,
    String? token,
    @Default(false) bool isRead,
    DateTime? createdAt,
    Map<String, dynamic>? data,
    String? id,
  }) = _NotificationModel;

  const NotificationModel._();

  factory NotificationModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return NotificationModel.fromJson(data).copyWith(id: doc.id);
  }

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  factory NotificationModel.fromString(String data) {
    final js = json.decode(data);
    return _$NotificationModelFromJson(js);
  }

  String get notification => type?.content(content ?? '', author) ?? '';

  @override
  String toString() {
    final data = toJson();
    return json.encode(data);
  }

  bool equal(NotificationModel model) {
    return author == model.author &&
        type == model.type &&
        content == model.content &&
        token == model.token &&
        createdAt == model.createdAt &&
        isRead == model.isRead &&
        data == model.data;
  }
}
