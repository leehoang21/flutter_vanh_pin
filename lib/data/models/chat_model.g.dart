// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatModelImpl _$$ChatModelImplFromJson(Map<String, dynamic> json) =>
    _$ChatModelImpl(
      members: (json['members'] as List<dynamic>?)
              ?.map((e) => UserModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      memberIds: (json['memberIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      status: json['status'] as String?,
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      chatType: $enumDecodeNullable(_$ChatTypeEnumMap, json['chatType']),
      chatName: json['chatName'] as String?,
      chatAvatar: json['chatAvatar'] as String?,
      chatContent: json['chatContent'] as String?,
      uId: json['uId'] as String?,
    );

Map<String, dynamic> _$$ChatModelImplToJson(_$ChatModelImpl instance) =>
    <String, dynamic>{
      'members': instance.members.map((e) => e.toJson()).toList(),
      'memberIds': instance.memberIds,
      'status': instance.status,
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'chatType': _$ChatTypeEnumMap[instance.chatType],
      'chatName': instance.chatName,
      'chatAvatar': instance.chatAvatar,
      'chatContent': instance.chatContent,
      'uId': instance.uId,
    };

const _$ChatTypeEnumMap = {
  ChatType.single: 'single',
  ChatType.group: 'group',
};
