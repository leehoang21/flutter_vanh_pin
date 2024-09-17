// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_group_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CreateGroupState {
  File? get avatar => throw _privateConstructorUsedError;
  File? get background => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CreateGroupStateCopyWith<CreateGroupState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateGroupStateCopyWith<$Res> {
  factory $CreateGroupStateCopyWith(
          CreateGroupState value, $Res Function(CreateGroupState) then) =
      _$CreateGroupStateCopyWithImpl<$Res, CreateGroupState>;
  @useResult
  $Res call({File? avatar, File? background});
}

/// @nodoc
class _$CreateGroupStateCopyWithImpl<$Res, $Val extends CreateGroupState>
    implements $CreateGroupStateCopyWith<$Res> {
  _$CreateGroupStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? avatar = freezed,
    Object? background = freezed,
  }) {
    return _then(_value.copyWith(
      avatar: freezed == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as File?,
      background: freezed == background
          ? _value.background
          : background // ignore: cast_nullable_to_non_nullable
              as File?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CreateGroupStateImplCopyWith<$Res>
    implements $CreateGroupStateCopyWith<$Res> {
  factory _$$CreateGroupStateImplCopyWith(_$CreateGroupStateImpl value,
          $Res Function(_$CreateGroupStateImpl) then) =
      __$$CreateGroupStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({File? avatar, File? background});
}

/// @nodoc
class __$$CreateGroupStateImplCopyWithImpl<$Res>
    extends _$CreateGroupStateCopyWithImpl<$Res, _$CreateGroupStateImpl>
    implements _$$CreateGroupStateImplCopyWith<$Res> {
  __$$CreateGroupStateImplCopyWithImpl(_$CreateGroupStateImpl _value,
      $Res Function(_$CreateGroupStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? avatar = freezed,
    Object? background = freezed,
  }) {
    return _then(_$CreateGroupStateImpl(
      freezed == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as File?,
      freezed == background
          ? _value.background
          : background // ignore: cast_nullable_to_non_nullable
              as File?,
    ));
  }
}

/// @nodoc

class _$CreateGroupStateImpl implements _CreateGroupState {
  _$CreateGroupStateImpl(this.avatar, this.background);

  @override
  final File? avatar;
  @override
  final File? background;

  @override
  String toString() {
    return 'CreateGroupState(avatar: $avatar, background: $background)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateGroupStateImpl &&
            (identical(other.avatar, avatar) || other.avatar == avatar) &&
            (identical(other.background, background) ||
                other.background == background));
  }

  @override
  int get hashCode => Object.hash(runtimeType, avatar, background);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateGroupStateImplCopyWith<_$CreateGroupStateImpl> get copyWith =>
      __$$CreateGroupStateImplCopyWithImpl<_$CreateGroupStateImpl>(
          this, _$identity);
}

abstract class _CreateGroupState implements CreateGroupState {
  factory _CreateGroupState(final File? avatar, final File? background) =
      _$CreateGroupStateImpl;

  @override
  File? get avatar;
  @override
  File? get background;
  @override
  @JsonKey(ignore: true)
  _$$CreateGroupStateImplCopyWith<_$CreateGroupStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
