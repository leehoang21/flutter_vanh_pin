// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'emojis_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

EmojisModel _$EmojisModelFromJson(Map<String, dynamic> json) {
  return _EmojisModel.fromJson(json);
}

/// @nodoc
mixin _$EmojisModel {
  String? get emoji => throw _privateConstructorUsedError;
  UserModel? get author => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EmojisModelCopyWith<EmojisModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmojisModelCopyWith<$Res> {
  factory $EmojisModelCopyWith(
          EmojisModel value, $Res Function(EmojisModel) then) =
      _$EmojisModelCopyWithImpl<$Res, EmojisModel>;
  @useResult
  $Res call({String? emoji, UserModel? author});

  $UserModelCopyWith<$Res>? get author;
}

/// @nodoc
class _$EmojisModelCopyWithImpl<$Res, $Val extends EmojisModel>
    implements $EmojisModelCopyWith<$Res> {
  _$EmojisModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? emoji = freezed,
    Object? author = freezed,
  }) {
    return _then(_value.copyWith(
      emoji: freezed == emoji
          ? _value.emoji
          : emoji // ignore: cast_nullable_to_non_nullable
              as String?,
      author: freezed == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as UserModel?,
    ) as $Val);
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
abstract class _$$EmojisModelImplCopyWith<$Res>
    implements $EmojisModelCopyWith<$Res> {
  factory _$$EmojisModelImplCopyWith(
          _$EmojisModelImpl value, $Res Function(_$EmojisModelImpl) then) =
      __$$EmojisModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? emoji, UserModel? author});

  @override
  $UserModelCopyWith<$Res>? get author;
}

/// @nodoc
class __$$EmojisModelImplCopyWithImpl<$Res>
    extends _$EmojisModelCopyWithImpl<$Res, _$EmojisModelImpl>
    implements _$$EmojisModelImplCopyWith<$Res> {
  __$$EmojisModelImplCopyWithImpl(
      _$EmojisModelImpl _value, $Res Function(_$EmojisModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? emoji = freezed,
    Object? author = freezed,
  }) {
    return _then(_$EmojisModelImpl(
      emoji: freezed == emoji
          ? _value.emoji
          : emoji // ignore: cast_nullable_to_non_nullable
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
class _$EmojisModelImpl implements _EmojisModel {
  const _$EmojisModelImpl({this.emoji, this.author});

  factory _$EmojisModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$EmojisModelImplFromJson(json);

  @override
  final String? emoji;
  @override
  final UserModel? author;

  @override
  String toString() {
    return 'EmojisModel(emoji: $emoji, author: $author)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmojisModelImpl &&
            (identical(other.emoji, emoji) || other.emoji == emoji) &&
            (identical(other.author, author) || other.author == author));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, emoji, author);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EmojisModelImplCopyWith<_$EmojisModelImpl> get copyWith =>
      __$$EmojisModelImplCopyWithImpl<_$EmojisModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EmojisModelImplToJson(
      this,
    );
  }
}

abstract class _EmojisModel implements EmojisModel {
  const factory _EmojisModel({final String? emoji, final UserModel? author}) =
      _$EmojisModelImpl;

  factory _EmojisModel.fromJson(Map<String, dynamic> json) =
      _$EmojisModelImpl.fromJson;

  @override
  String? get emoji;
  @override
  UserModel? get author;
  @override
  @JsonKey(ignore: true)
  _$$EmojisModelImplCopyWith<_$EmojisModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
