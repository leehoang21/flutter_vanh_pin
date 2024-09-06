// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'my_page_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MyPageState {
  UserModel get user => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(UserModel user) loading,
    required TResult Function(UserModel user) loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(UserModel user)? loading,
    TResult? Function(UserModel user)? loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(UserModel user)? loading,
    TResult Function(UserModel user)? loaded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MyPageStateCopyWith<MyPageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MyPageStateCopyWith<$Res> {
  factory $MyPageStateCopyWith(
          MyPageState value, $Res Function(MyPageState) then) =
      _$MyPageStateCopyWithImpl<$Res, MyPageState>;
  @useResult
  $Res call({UserModel user});

  $UserModelCopyWith<$Res> get user;
}

/// @nodoc
class _$MyPageStateCopyWithImpl<$Res, $Val extends MyPageState>
    implements $MyPageStateCopyWith<$Res> {
  _$MyPageStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
  }) {
    return _then(_value.copyWith(
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserModel,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res> get user {
    return $UserModelCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res>
    implements $MyPageStateCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({UserModel user});

  @override
  $UserModelCopyWith<$Res> get user;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$MyPageStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
  }) {
    return _then(_$LoadingImpl(
      null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserModel,
    ));
  }
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl(this.user);

  @override
  final UserModel user;

  @override
  String toString() {
    return 'MyPageState.loading(user: $user)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadingImpl &&
            (identical(other.user, user) || other.user == user));
  }

  @override
  int get hashCode => Object.hash(runtimeType, user);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadingImplCopyWith<_$LoadingImpl> get copyWith =>
      __$$LoadingImplCopyWithImpl<_$LoadingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(UserModel user) loading,
    required TResult Function(UserModel user) loaded,
  }) {
    return loading(user);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(UserModel user)? loading,
    TResult? Function(UserModel user)? loaded,
  }) {
    return loading?.call(user);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(UserModel user)? loading,
    TResult Function(UserModel user)? loaded,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(user);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements MyPageState {
  const factory _Loading(final UserModel user) = _$LoadingImpl;

  @override
  UserModel get user;
  @override
  @JsonKey(ignore: true)
  _$$LoadingImplCopyWith<_$LoadingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadedImplCopyWith<$Res>
    implements $MyPageStateCopyWith<$Res> {
  factory _$$LoadedImplCopyWith(
          _$LoadedImpl value, $Res Function(_$LoadedImpl) then) =
      __$$LoadedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({UserModel user});

  @override
  $UserModelCopyWith<$Res> get user;
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<$Res>
    extends _$MyPageStateCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(
      _$LoadedImpl _value, $Res Function(_$LoadedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
  }) {
    return _then(_$LoadedImpl(
      null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserModel,
    ));
  }
}

/// @nodoc

class _$LoadedImpl implements _Loaded {
  _$LoadedImpl(this.user);

  @override
  final UserModel user;

  @override
  String toString() {
    return 'MyPageState.loaded(user: $user)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedImpl &&
            (identical(other.user, user) || other.user == user));
  }

  @override
  int get hashCode => Object.hash(runtimeType, user);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      __$$LoadedImplCopyWithImpl<_$LoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(UserModel user) loading,
    required TResult Function(UserModel user) loaded,
  }) {
    return loaded(user);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(UserModel user)? loading,
    TResult? Function(UserModel user)? loaded,
  }) {
    return loaded?.call(user);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(UserModel user)? loading,
    TResult Function(UserModel user)? loaded,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(user);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _Loaded implements MyPageState {
  factory _Loaded(final UserModel user) = _$LoadedImpl;

  @override
  UserModel get user;
  @override
  @JsonKey(ignore: true)
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
