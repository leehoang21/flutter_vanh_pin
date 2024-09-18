// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_chat_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CreateChatState {
  List<UserModel>? get users => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CreateChatStateCopyWith<CreateChatState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateChatStateCopyWith<$Res> {
  factory $CreateChatStateCopyWith(
          CreateChatState value, $Res Function(CreateChatState) then) =
      _$CreateChatStateCopyWithImpl<$Res, CreateChatState>;
  @useResult
  $Res call({List<UserModel>? users});
}

/// @nodoc
class _$CreateChatStateCopyWithImpl<$Res, $Val extends CreateChatState>
    implements $CreateChatStateCopyWith<$Res> {
  _$CreateChatStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? users = freezed,
  }) {
    return _then(_value.copyWith(
      users: freezed == users
          ? _value.users
          : users // ignore: cast_nullable_to_non_nullable
              as List<UserModel>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CreateChatStateImplCopyWith<$Res>
    implements $CreateChatStateCopyWith<$Res> {
  factory _$$CreateChatStateImplCopyWith(_$CreateChatStateImpl value,
          $Res Function(_$CreateChatStateImpl) then) =
      __$$CreateChatStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<UserModel>? users});
}

/// @nodoc
class __$$CreateChatStateImplCopyWithImpl<$Res>
    extends _$CreateChatStateCopyWithImpl<$Res, _$CreateChatStateImpl>
    implements _$$CreateChatStateImplCopyWith<$Res> {
  __$$CreateChatStateImplCopyWithImpl(
      _$CreateChatStateImpl _value, $Res Function(_$CreateChatStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? users = freezed,
  }) {
    return _then(_$CreateChatStateImpl(
      freezed == users
          ? _value._users
          : users // ignore: cast_nullable_to_non_nullable
              as List<UserModel>?,
    ));
  }
}

/// @nodoc

class _$CreateChatStateImpl implements _CreateChatState {
  const _$CreateChatStateImpl(final List<UserModel>? users) : _users = users;

  final List<UserModel>? _users;
  @override
  List<UserModel>? get users {
    final value = _users;
    if (value == null) return null;
    if (_users is EqualUnmodifiableListView) return _users;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'CreateChatState(users: $users)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateChatStateImpl &&
            const DeepCollectionEquality().equals(other._users, _users));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_users));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateChatStateImplCopyWith<_$CreateChatStateImpl> get copyWith =>
      __$$CreateChatStateImplCopyWithImpl<_$CreateChatStateImpl>(
          this, _$identity);
}

abstract class _CreateChatState implements CreateChatState {
  const factory _CreateChatState(final List<UserModel>? users) =
      _$CreateChatStateImpl;

  @override
  List<UserModel>? get users;
  @override
  @JsonKey(ignore: true)
  _$$CreateChatStateImplCopyWith<_$CreateChatStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
