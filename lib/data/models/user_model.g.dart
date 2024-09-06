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
      google: json['google'] as String?,
      background: json['background'] as String?,
      address: json['address'] as String?,
      education: json['education'] as String?,
      job: json['job'] as String?,
      birthday: json['birthday'] == null
          ? null
          : DateTime.parse(json['birthday'] as String),
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'phoneNumber': instance.phoneNumber,
      'userName': instance.userName,
      'email': instance.email,
      'avatar': instance.avatar,
      'uId': instance.uId,
      'google': instance.google,
      'background': instance.background,
      'address': instance.address,
      'education': instance.education,
      'job': instance.job,
      'birthday': instance.birthday?.toIso8601String(),
    };
