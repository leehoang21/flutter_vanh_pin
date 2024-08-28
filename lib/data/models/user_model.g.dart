// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      phoneNumber: json['phoneNumber'] as String?,
      userName: json['userName'] as String?,
      email: json['email'] as String?,
      avatar: json['avatar'] as String?,
      uId: json['uId'] as String?,
      facebook: json['facebook'] as String?,
      google: json['google'] as String?,
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'phoneNumber': instance.phoneNumber,
      'userName': instance.userName,
      'email': instance.email,
      'avatar': instance.avatar,
      'uId': instance.uId,
      'facebook': instance.facebook,
      'google': instance.google,
    };
