// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'friend_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FriendModel _$FriendModelFromJson(Map<String, dynamic> json) {
  return _FriendModel.fromJson(json);
}

/// @nodoc
mixin _$FriendModel {
  UserModel? get user => throw _privateConstructorUsedError;
  FriendStatus get status => throw _privateConstructorUsedError;
  String? get uId => throw _privateConstructorUsedError;
  UserModel? get author => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FriendModelCopyWith<FriendModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FriendModelCopyWith<$Res> {
  factory $FriendModelCopyWith(
          FriendModel value, $Res Function(FriendModel) then) =
      _$FriendModelCopyWithImpl<$Res, FriendModel>;
  @useResult
  $Res call(
      {UserModel? user, FriendStatus status, String? uId, UserModel? author});

  $UserModelCopyWith<$Res>? get user;
  $UserModelCopyWith<$Res>? get author;
}

/// @nodoc
class _$FriendModelCopyWithImpl<$Res, $Val extends FriendModel>
    implements $FriendModelCopyWith<$Res> {
  _$FriendModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = freezed,
    Object? status = null,
    Object? uId = freezed,
    Object? author = freezed,
  }) {
    return _then(_value.copyWith(
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserModel?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as FriendStatus,
      uId: freezed == uId
          ? _value.uId
          : uId // ignore: cast_nullable_to_non_nullable
              as String?,
      author: freezed == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as UserModel?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res>? get user {
    if (_value.user == null) {
      return null;
    }

    return $UserModelCopyWith<$Res>(_value.user!, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res>? get author {
    if (_value.author == null) {
      return null;
    }

    return $UserModelCopyWith<$Res>(_value.author!, (value) {
      return _then(_value.copyWith(author: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$FriendModelImplCopyWith<$Res>
    implements $FriendModelCopyWith<$Res> {
  factory _$$FriendModelImplCopyWith(
          _$FriendModelImpl value, $Res Function(_$FriendModelImpl) then) =
      __$$FriendModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {UserModel? user, FriendStatus status, String? uId, UserModel? author});

  @override
  $UserModelCopyWith<$Res>? get user;
  @override
  $UserModelCopyWith<$Res>? get author;
}

/// @nodoc
class __$$FriendModelImplCopyWithImpl<$Res>
    extends _$FriendModelCopyWithImpl<$Res, _$FriendModelImpl>
    implements _$$FriendModelImplCopyWith<$Res> {
  __$$FriendModelImplCopyWithImpl(
      _$FriendModelImpl _value, $Res Function(_$FriendModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = freezed,
    Object? status = null,
    Object? uId = freezed,
    Object? author = freezed,
  }) {
    return _then(_$FriendModelImpl(
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserModel?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as FriendStatus,
      uId: freezed == uId
          ? _value.uId
          : uId // ignore: cast_nullable_to_non_nullable
              as String?,
      author: freezed == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as UserModel?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$FriendModelImpl implements _FriendModel {
  const _$FriendModelImpl(
      {this.user, this.status = FriendStatus.pending, this.uId, this.author});

  factory _$FriendModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$FriendModelImplFromJson(json);

  @override
  final UserModel? user;
  @override
  @JsonKey()
  final FriendStatus status;
  @override
  final String? uId;
  @override
  final UserModel? author;

  @override
  String toString() {
    return 'FriendModel(user: $user, status: $status, uId: $uId, author: $author)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FriendModelImpl &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.uId, uId) || other.uId == uId) &&
            (identical(other.author, author) || other.author == author));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, user, status, uId, author);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FriendModelImplCopyWith<_$FriendModelImpl> get copyWith =>
      __$$FriendModelImplCopyWithImpl<_$FriendModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FriendModelImplToJson(
      this,
    );
  }
}

abstract class _FriendModel implements FriendModel {
  const factory _FriendModel(
      {final UserModel? user,
      final FriendStatus status,
      final String? uId,
      final UserModel? author}) = _$FriendModelImpl;

  factory _FriendModel.fromJson(Map<String, dynamic> json) =
      _$FriendModelImpl.fromJson;

  @override
  UserModel? get user;
  @override
  FriendStatus get status;
  @override
  String? get uId;
  @override
  UserModel? get author;
  @override
  @JsonKey(ignore: true)
  _$$FriendModelImplCopyWith<_$FriendModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
