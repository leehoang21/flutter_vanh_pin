// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NotificationModelImpl _$$NotificationModelImplFromJson(
        Map<String, dynamic> json) =>
    _$NotificationModelImpl(
      author: json['author'] == null
          ? null
          : UserModel.fromJson(json['author'] as Map<String, dynamic>),
      type: $enumDecodeNullable(_$NotificationTypeEnumMap, json['type']),
      user: json['user'] == null
          ? null
          : UserModel.fromJson(json['user'] as Map<String, dynamic>),
      content: json['content'] as String?,
      token: json['token'] as String?,
      isRead: json['isRead'] as bool? ?? false,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      data: json['data'] as Map<String, dynamic>?,
      id: json['id'] as String?,
    );

Map<String, dynamic> _$$NotificationModelImplToJson(
        _$NotificationModelImpl instance) =>
    <String, dynamic>{
      'author': instance.author?.toJson(),
      'type': _$NotificationTypeEnumMap[instance.type],
      'user': instance.user?.toJson(),
      'content': instance.content,
      'token': instance.token,
      'isRead': instance.isRead,
      'createdAt': instance.createdAt?.toIso8601String(),
      'data': instance.data,
      'id': instance.id,
    };

const _$NotificationTypeEnumMap = {
  NotificationType.addFriend: 'addFriend',
  NotificationType.message: 'message',
  NotificationType.comment: 'comment',
  NotificationType.addFriendSuccess: 'addFriendSuccess',
  NotificationType.addGroupSuccess: 'addGroupSuccess',
  NotificationType.key: 'key',
  NotificationType.keyChat: 'keyChat',
  NotificationType.login: 'login',
};
