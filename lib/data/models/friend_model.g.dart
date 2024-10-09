// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FriendModelImpl _$$FriendModelImplFromJson(Map<String, dynamic> json) =>
    _$FriendModelImpl(
      user: json['user'] == null
          ? null
          : UserModel.fromJson(json['user'] as Map<String, dynamic>),
      status: $enumDecodeNullable(_$FriendStatusEnumMap, json['status']) ??
          FriendStatus.pending,
      uId: json['uId'] as String?,
      author: json['author'] == null
          ? null
          : UserModel.fromJson(json['author'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$FriendModelImplToJson(_$FriendModelImpl instance) =>
    <String, dynamic>{
      'user': instance.user?.toJson(),
      'status': _$FriendStatusEnumMap[instance.status]!,
      'uId': instance.uId,
      'author': instance.author?.toJson(),
    };

const _$FriendStatusEnumMap = {
  FriendStatus.pending: 'pending',
  FriendStatus.accepted: 'accepted',
  FriendStatus.all: 'all',
};
