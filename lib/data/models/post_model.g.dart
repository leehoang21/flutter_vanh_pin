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
          : GroupModel.fromJson(json['group'] as Map<String, dynamic>),
      time: DateTime.parse(json['time'] as String),
      content: json['content'] as String,
      emojis: (json['emojis'] as List<dynamic>?)
              ?.map((e) => EmojisModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      commentCount: (json['commentCount'] as num?)?.toInt() ?? 0,
      shareCount: (json['shareCount'] as num?)?.toInt() ?? 0,
      share: json['share'] == null
          ? null
          : PostModel.fromJson(json['share'] as Map<String, dynamic>),
      uId: json['uId'] as String?,
    );

Map<String, dynamic> _$$PostModelImplToJson(_$PostModelImpl instance) =>
    <String, dynamic>{
      'images': instance.images,
      'author': instance.author.toJson(),
      'group': instance.group?.toJson(),
      'time': instance.time.toIso8601String(),
      'content': instance.content,
      'emojis': instance.emojis?.map((e) => e.toJson()).toList(),
      'commentCount': instance.commentCount,
      'shareCount': instance.shareCount,
      'share': instance.share?.toJson(),
      'uId': instance.uId,
    };
