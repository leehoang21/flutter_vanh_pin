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
      content: json['content'] as String?,
      token: json['token'] as String?,
      time:
          json['time'] == null ? null : DateTime.parse(json['time'] as String),
      isRead: json['isRead'] as bool? ?? false,
      data: json['data'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$NotificationModelImplToJson(
        _$NotificationModelImpl instance) =>
    <String, dynamic>{
      'author': instance.author?.toJson(),
      'type': _$NotificationTypeEnumMap[instance.type],
      'content': instance.content,
      'token': instance.token,
      'time': instance.time?.toIso8601String(),
      'isRead': instance.isRead,
      'data': instance.data,
    };

const _$NotificationTypeEnumMap = {
  NotificationType.addFriend: 'addFriend',
  NotificationType.message: 'message',
  NotificationType.comment: 'comment',
  NotificationType.addFriendSuccess: 'addFriendSuccess',
  NotificationType.addGroupSuccess: 'addGroupSuccess',
  NotificationType.key: 'key',
  NotificationType.login: 'login',
};
