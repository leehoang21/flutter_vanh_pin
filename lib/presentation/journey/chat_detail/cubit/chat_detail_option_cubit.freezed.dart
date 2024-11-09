// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_detail_option_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ChatDetailOptionState {
  List<(bool, UserModel)> get users => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ChatDetailOptionStateCopyWith<ChatDetailOptionState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatDetailOptionStateCopyWith<$Res> {
  factory $ChatDetailOptionStateCopyWith(ChatDetailOptionState value,
          $Res Function(ChatDetailOptionState) then) =
      _$ChatDetailOptionStateCopyWithImpl<$Res, ChatDetailOptionState>;
  @useResult
  $Res call({List<(bool, UserModel)> users});
}

/// @nodoc
class _$ChatDetailOptionStateCopyWithImpl<$Res,
        $Val extends ChatDetailOptionState>
    implements $ChatDetailOptionStateCopyWith<$Res> {
  _$ChatDetailOptionStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? users = null,
  }) {
    return _then(_value.copyWith(
      users: null == users
          ? _value.users
          : users // ignore: cast_nullable_to_non_nullable
              as List<(bool, UserModel)>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChatDetailOptionStateImplCopyWith<$Res>
    implements $ChatDetailOptionStateCopyWith<$Res> {
  factory _$$ChatDetailOptionStateImplCopyWith(
          _$ChatDetailOptionStateImpl value,
          $Res Function(_$ChatDetailOptionStateImpl) then) =
      __$$ChatDetailOptionStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<(bool, UserModel)> users});
}

/// @nodoc
class __$$ChatDetailOptionStateImplCopyWithImpl<$Res>
    extends _$ChatDetailOptionStateCopyWithImpl<$Res,
        _$ChatDetailOptionStateImpl>
    implements _$$ChatDetailOptionStateImplCopyWith<$Res> {
  __$$ChatDetailOptionStateImplCopyWithImpl(_$ChatDetailOptionStateImpl _value,
      $Res Function(_$ChatDetailOptionStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? users = null,
  }) {
    return _then(_$ChatDetailOptionStateImpl(
      null == users
          ? _value._users
          : users // ignore: cast_nullable_to_non_nullable
              as List<(bool, UserModel)>,
    ));
  }
}

/// @nodoc

class _$ChatDetailOptionStateImpl implements _ChatDetailOptionState {
  const _$ChatDetailOptionStateImpl(final List<(bool, UserModel)> users)
      : _users = users;

  final List<(bool, UserModel)> _users;
  @override
  List<(bool, UserModel)> get users {
    if (_users is EqualUnmodifiableListView) return _users;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_users);
  }

  @override
  String toString() {
    return 'ChatDetailOptionState(users: $users)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatDetailOptionStateImpl &&
            const DeepCollectionEquality().equals(other._users, _users));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_users));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatDetailOptionStateImplCopyWith<_$ChatDetailOptionStateImpl>
      get copyWith => __$$ChatDetailOptionStateImplCopyWithImpl<
          _$ChatDetailOptionStateImpl>(this, _$identity);
}

abstract class _ChatDetailOptionState implements ChatDetailOptionState {
  const factory _ChatDetailOptionState(final List<(bool, UserModel)> users) =
      _$ChatDetailOptionStateImpl;

  @override
  List<(bool, UserModel)> get users;
  @override
  @JsonKey(ignore: true)
  _$$ChatDetailOptionStateImplCopyWith<_$ChatDetailOptionStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
