// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_manager_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatManagerModelImpl _$$ChatManagerModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ChatManagerModelImpl(
      status: json['status'] as String?,
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      type: $enumDecodeNullable(_$ContentTypeEnumMap, json['type']),
      content: json['content'] as String?,
      author: json['author'] == null
          ? null
          : UserModel.fromJson(json['author'] as Map<String, dynamic>),
      uId: json['uId'] as String?,
      chatId: json['chatId'] as String?,
    );

Map<String, dynamic> _$$ChatManagerModelImplToJson(
        _$ChatManagerModelImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'type': _$ContentTypeEnumMap[instance.type],
      'content': instance.content,
      'author': instance.author?.toJson(),
      'uId': instance.uId,
      'chatId': instance.chatId,
    };

const _$ContentTypeEnumMap = {
  ContentType.text: 'text',
  ContentType.image: 'image',
};
