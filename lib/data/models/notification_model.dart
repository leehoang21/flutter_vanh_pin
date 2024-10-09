import 'dart:convert';

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
        return content;
      case NotificationType.login:
        return content;
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
    String? content,
    String? token,
    DateTime? time,
    @Default(false) bool isRead,
    Map<String, dynamic>? data,
  }) = _NotificationModel;

  const NotificationModel._();

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
        time == model.time &&
        isRead == model.isRead &&
        data == model.data;
  }
}
