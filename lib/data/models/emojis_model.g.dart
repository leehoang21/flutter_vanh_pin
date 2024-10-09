// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emojis_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EmojisModelImpl _$$EmojisModelImplFromJson(Map<String, dynamic> json) =>
    _$EmojisModelImpl(
      emoji: json['emoji'] as String?,
      author: json['author'] == null
          ? null
          : UserModel.fromJson(json['author'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$EmojisModelImplToJson(_$EmojisModelImpl instance) =>
    <String, dynamic>{
      'emoji': instance.emoji,
      'author': instance.author?.toJson(),
    };
