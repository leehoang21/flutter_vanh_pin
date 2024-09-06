// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PostModelImpl _$$PostModelImplFromJson(Map<String, dynamic> json) =>
    _$PostModelImpl(
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      author: UserModel.fromJson(json['author'] as Map<String, dynamic>),
      group: json['group'] == null
          ? null
          : UserModel.fromJson(json['group'] as Map<String, dynamic>),
      time: DateTime.parse(json['time'] as String),
      content: json['content'] as String,
    );

Map<String, dynamic> _$$PostModelImplToJson(_$PostModelImpl instance) =>
    <String, dynamic>{
      'images': instance.images,
      'author': instance.author.toJson(),
      'group': instance.group?.toJson(),
      'time': instance.time.toIso8601String(),
      'content': instance.content,
    };
