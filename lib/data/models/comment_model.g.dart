// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CommentModelImpl _$$CommentModelImplFromJson(Map<String, dynamic> json) =>
    _$CommentModelImpl(
      author: UserModel.fromJson(json['author'] as Map<String, dynamic>),
      time: DateTime.parse(json['time'] as String),
      content: json['content'] as String,
      emojis: (json['emojis'] as List<dynamic>?)
              ?.map((e) => EmojisModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      postId: json['postId'] as String,
    );

Map<String, dynamic> _$$CommentModelImplToJson(_$CommentModelImpl instance) =>
    <String, dynamic>{
      'author': instance.author.toJson(),
      'time': instance.time.toIso8601String(),
      'content': instance.content,
      'emojis': instance.emojis.map((e) => e.toJson()).toList(),
      'postId': instance.postId,
    };
