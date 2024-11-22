import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pinpin/common/extension/string_extension.dart';
import 'package:pinpin/common/utils/app_utils.dart';
import 'package:pinpin/data/models/user_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_model.freezed.dart';
part 'notification_model.g.dart';

enum NotificationType {
  addFriend,
  comment,
  addFriendSuccess,
  joinGroup,
  addGroupSuccess,
  removeGroupSuccess,
  accessAccount,
  login,
  //
  message,
  addGroupChatSuccess,
  removeGroupChatSuccess,
  keyChat,
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
      case NotificationType.joinGroup:
        return 'Join group';
      case NotificationType.addGroupSuccess:
        return 'You have been approved';

      case NotificationType.accessAccount:
        return 'accessAccount';
      case NotificationType.login:
        return 'login';
      case NotificationType.addGroupChatSuccess:
        return 'addGroupChatSuccess';
      case NotificationType.removeGroupChatSuccess:
        return 'removeGroupChatSuccess';
      case NotificationType.removeGroupSuccess:
        return 'removeGroupSuccess';
      case NotificationType.keyChat:
        return 'keyChat';
    }
  }

  String message(String content) {
    switch (this) {
      case NotificationType.addFriend:
        return 'You have a new friend request';
      case NotificationType.message:
        return content;
      case NotificationType.comment:
        return 'You have a new comment';
      case NotificationType.addFriendSuccess:
        return '';
      case NotificationType.joinGroup:
        return 'You have a request to join the group';
      case NotificationType.addGroupSuccess:
        return '';
      case NotificationType.accessAccount:
        return '';
      case NotificationType.login:
        return '';
      case NotificationType.addGroupChatSuccess:
        return '';
      case NotificationType.removeGroupChatSuccess:
        return '';
      case NotificationType.removeGroupSuccess:
        return '';
      case NotificationType.keyChat:
        return '';
    }
  }

  String content(String content, UserModel? author) {
    switch (this) {
      case NotificationType.addFriend:
        return 'You have a friend request from ${author?.userName}';
      case NotificationType.message:
        return content;
      case NotificationType.comment:
        return content;
      case NotificationType.addFriendSuccess:
        return '${author?.userName} has accepted your friend request';
      case NotificationType.joinGroup:
        return '${author?.userName} has requested to join the group';
      case NotificationType.addGroupSuccess:
        return 'You have been approved by ${author?.userName}';
      case NotificationType.accessAccount:
        return 'Device $content has been granted access to your account!';
      case NotificationType.login:
        return 'The device $content is logged into your account, is this you?';
      case NotificationType.removeGroupSuccess:
        return 'You have been removed from the group by ${author?.userName}';
      case NotificationType.addGroupChatSuccess:
        return 'You have been added to the group by ${author?.userName}';
      case NotificationType.removeGroupChatSuccess:
        return 'You have been removed from the group by ${author?.userName}';
      case NotificationType.keyChat:
        return '';
    }
  }

  bool get checkRead {
    switch (this) {
      case NotificationType.addFriend:
      case NotificationType.login:
      case NotificationType.joinGroup:
        return true;
      case NotificationType.message:
      case NotificationType.comment:
      case NotificationType.addFriendSuccess:
      case NotificationType.addGroupSuccess:
      case NotificationType.accessAccount:
      case NotificationType.keyChat:
      case NotificationType.removeGroupSuccess:
      case NotificationType.addGroupChatSuccess:
      case NotificationType.removeGroupChatSuccess:
        return false;
    }
  }

  String get titleAction {
    switch (this) {
      case NotificationType.addFriend:
      case NotificationType.login:
      case NotificationType.joinGroup:
        return 'Accept'.tr;
      case NotificationType.message:
      case NotificationType.comment:
      case NotificationType.addFriendSuccess:
      case NotificationType.addGroupSuccess:
      case NotificationType.removeGroupSuccess:
      case NotificationType.accessAccount:
      case NotificationType.addGroupChatSuccess:
      case NotificationType.removeGroupChatSuccess:
      case NotificationType.keyChat:
        return '';
    }
  }

  bool get isMessage {
    switch (this) {
      case NotificationType.addFriend:
      case NotificationType.login:
      case NotificationType.addFriendSuccess:
      case NotificationType.addGroupSuccess:
      case NotificationType.accessAccount:
      case NotificationType.comment:
      case NotificationType.joinGroup:
        return false;
      case NotificationType.message:
      case NotificationType.removeGroupSuccess:
      case NotificationType.addGroupChatSuccess:
      case NotificationType.removeGroupChatSuccess:
      case NotificationType.keyChat:
        return true;
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
    DateTime? createdAt,
    @Default(false) bool isRead,
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
    if (isNullEmpty(data)) return const NotificationModel();
    final js = json.decode(data);
    return _$NotificationModelFromJson(js);
  }

  static List<NotificationModel> fromList(String data) {
    if (isNullEmpty(data)) return [];
    final js = json.decode(data);
    return (js as List).map((e) => NotificationModel.fromJson(e)).toList();
  }

  static String toList(List<NotificationModel> data) {
    return json.encode(data);
  }

  String get notification => type?.content(content ?? '', author) ?? '';
  String get title => type?.title ?? '';
  bool get isMessage => type?.isMessage ?? false;
  String get message => type?.message(content ?? '') ?? '';

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
        isRead == model.isRead;
  }
}
