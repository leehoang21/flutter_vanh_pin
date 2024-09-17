// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GroupModelImpl _$$GroupModelImplFromJson(Map<String, dynamic> json) =>
    _$GroupModelImpl(
      author: json['author'] == null
          ? null
          : UserModel.fromJson(json['author'] as Map<String, dynamic>),
      admins: (json['admins'] as List<dynamic>?)
          ?.map((e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      members: (json['members'] as List<dynamic>?)
          ?.map((e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      avatar: json['avatar'] as String?,
      uId: json['uId'] as String?,
      name: json['name'] as String?,
      background: json['background'] as String?,
      type: $enumDecodeNullable(_$GroupTypeEnumMap, json['type']),
      time:
          json['time'] == null ? null : DateTime.parse(json['time'] as String),
    );

Map<String, dynamic> _$$GroupModelImplToJson(_$GroupModelImpl instance) =>
    <String, dynamic>{
      'author': instance.author?.toJson(),
      'admins': instance.admins?.map((e) => e.toJson()).toList(),
      'members': instance.members?.map((e) => e.toJson()).toList(),
      'avatar': instance.avatar,
      'uId': instance.uId,
      'name': instance.name,
      'background': instance.background,
      'type': _$GroupTypeEnumMap[instance.type],
      'time': instance.time?.toIso8601String(),
    };

const _$GroupTypeEnumMap = {
  GroupType.public: 'public',
  GroupType.private: 'private',
};
