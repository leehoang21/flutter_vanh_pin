// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'group_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$GroupState {
  List<PostModel> get posts => throw _privateConstructorUsedError;
  List<GroupModel> get groups => throw _privateConstructorUsedError;
  List<GroupModel> get myGroups => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GroupStateCopyWith<GroupState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupStateCopyWith<$Res> {
  factory $GroupStateCopyWith(
          GroupState value, $Res Function(GroupState) then) =
      _$GroupStateCopyWithImpl<$Res, GroupState>;
  @useResult
  $Res call(
      {List<PostModel> posts,
      List<GroupModel> groups,
      List<GroupModel> myGroups});
}

/// @nodoc
class _$GroupStateCopyWithImpl<$Res, $Val extends GroupState>
    implements $GroupStateCopyWith<$Res> {
  _$GroupStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? posts = null,
    Object? groups = null,
    Object? myGroups = null,
  }) {
    return _then(_value.copyWith(
      posts: null == posts
          ? _value.posts
          : posts // ignore: cast_nullable_to_non_nullable
              as List<PostModel>,
      groups: null == groups
          ? _value.groups
          : groups // ignore: cast_nullable_to_non_nullable
              as List<GroupModel>,
      myGroups: null == myGroups
          ? _value.myGroups
          : myGroups // ignore: cast_nullable_to_non_nullable
              as List<GroupModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LoadedImplCopyWith<$Res>
    implements $GroupStateCopyWith<$Res> {
  factory _$$LoadedImplCopyWith(
          _$LoadedImpl value, $Res Function(_$LoadedImpl) then) =
      __$$LoadedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<PostModel> posts,
      List<GroupModel> groups,
      List<GroupModel> myGroups});
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<$Res>
    extends _$GroupStateCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(
      _$LoadedImpl _value, $Res Function(_$LoadedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? posts = null,
    Object? groups = null,
    Object? myGroups = null,
  }) {
    return _then(_$LoadedImpl(
      posts: null == posts
          ? _value._posts
          : posts // ignore: cast_nullable_to_non_nullable
              as List<PostModel>,
      groups: null == groups
          ? _value._groups
          : groups // ignore: cast_nullable_to_non_nullable
              as List<GroupModel>,
      myGroups: null == myGroups
          ? _value._myGroups
          : myGroups // ignore: cast_nullable_to_non_nullable
              as List<GroupModel>,
    ));
  }
}

/// @nodoc

class _$LoadedImpl implements _Loaded {
  const _$LoadedImpl(
      {required final List<PostModel> posts,
      required final List<GroupModel> groups,
      required final List<GroupModel> myGroups})
      : _posts = posts,
        _groups = groups,
        _myGroups = myGroups;

  final List<PostModel> _posts;
  @override
  List<PostModel> get posts {
    if (_posts is EqualUnmodifiableListView) return _posts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_posts);
  }

  final List<GroupModel> _groups;
  @override
  List<GroupModel> get groups {
    if (_groups is EqualUnmodifiableListView) return _groups;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_groups);
  }

  final List<GroupModel> _myGroups;
  @override
  List<GroupModel> get myGroups {
    if (_myGroups is EqualUnmodifiableListView) return _myGroups;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_myGroups);
  }

  @override
  String toString() {
    return 'GroupState(posts: $posts, groups: $groups, myGroups: $myGroups)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedImpl &&
            const DeepCollectionEquality().equals(other._posts, _posts) &&
            const DeepCollectionEquality().equals(other._groups, _groups) &&
            const DeepCollectionEquality().equals(other._myGroups, _myGroups));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_posts),
      const DeepCollectionEquality().hash(_groups),
      const DeepCollectionEquality().hash(_myGroups));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      __$$LoadedImplCopyWithImpl<_$LoadedImpl>(this, _$identity);
}

abstract class _Loaded implements GroupState {
  const factory _Loaded(
      {required final List<PostModel> posts,
      required final List<GroupModel> groups,
      required final List<GroupModel> myGroups}) = _$LoadedImpl;

  @override
  List<PostModel> get posts;
  @override
  List<GroupModel> get groups;
  @override
  List<GroupModel> get myGroups;
  @override
  @JsonKey(ignore: true)
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
