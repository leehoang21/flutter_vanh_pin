// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'group_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GroupModel _$GroupModelFromJson(Map<String, dynamic> json) {
  return _GroupModel.fromJson(json);
}

/// @nodoc
mixin _$GroupModel {
  UserModel? get author => throw _privateConstructorUsedError;
  List<UserModel>? get admins => throw _privateConstructorUsedError;
  List<UserModel>? get members => throw _privateConstructorUsedError;
  String? get avatar => throw _privateConstructorUsedError;
  String? get uId => throw _privateConstructorUsedError;
  String? get background => throw _privateConstructorUsedError;
  GroupType? get type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GroupModelCopyWith<GroupModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupModelCopyWith<$Res> {
  factory $GroupModelCopyWith(
          GroupModel value, $Res Function(GroupModel) then) =
      _$GroupModelCopyWithImpl<$Res, GroupModel>;
  @useResult
  $Res call(
      {UserModel? author,
      List<UserModel>? admins,
      List<UserModel>? members,
      String? avatar,
      String? uId,
      String? background,
      GroupType? type});

  $UserModelCopyWith<$Res>? get author;
}

/// @nodoc
class _$GroupModelCopyWithImpl<$Res, $Val extends GroupModel>
    implements $GroupModelCopyWith<$Res> {
  _$GroupModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? author = freezed,
    Object? admins = freezed,
    Object? members = freezed,
    Object? avatar = freezed,
    Object? uId = freezed,
    Object? background = freezed,
    Object? type = freezed,
  }) {
    return _then(_value.copyWith(
      author: freezed == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as UserModel?,
      admins: freezed == admins
          ? _value.admins
          : admins // ignore: cast_nullable_to_non_nullable
              as List<UserModel>?,
      members: freezed == members
          ? _value.members
          : members // ignore: cast_nullable_to_non_nullable
              as List<UserModel>?,
      avatar: freezed == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String?,
      uId: freezed == uId
          ? _value.uId
          : uId // ignore: cast_nullable_to_non_nullable
              as String?,
      background: freezed == background
          ? _value.background
          : background // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as GroupType?,
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
abstract class _$$GroupModelImplCopyWith<$Res>
    implements $GroupModelCopyWith<$Res> {
  factory _$$GroupModelImplCopyWith(
          _$GroupModelImpl value, $Res Function(_$GroupModelImpl) then) =
      __$$GroupModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {UserModel? author,
      List<UserModel>? admins,
      List<UserModel>? members,
      String? avatar,
      String? uId,
      String? background,
      GroupType? type});

  @override
  $UserModelCopyWith<$Res>? get author;
}

/// @nodoc
class __$$GroupModelImplCopyWithImpl<$Res>
    extends _$GroupModelCopyWithImpl<$Res, _$GroupModelImpl>
    implements _$$GroupModelImplCopyWith<$Res> {
  __$$GroupModelImplCopyWithImpl(
      _$GroupModelImpl _value, $Res Function(_$GroupModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? author = freezed,
    Object? admins = freezed,
    Object? members = freezed,
    Object? avatar = freezed,
    Object? uId = freezed,
    Object? background = freezed,
    Object? type = freezed,
  }) {
    return _then(_$GroupModelImpl(
      author: freezed == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as UserModel?,
      admins: freezed == admins
          ? _value._admins
          : admins // ignore: cast_nullable_to_non_nullable
              as List<UserModel>?,
      members: freezed == members
          ? _value._members
          : members // ignore: cast_nullable_to_non_nullable
              as List<UserModel>?,
      avatar: freezed == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String?,
      uId: freezed == uId
          ? _value.uId
          : uId // ignore: cast_nullable_to_non_nullable
              as String?,
      background: freezed == background
          ? _value.background
          : background // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as GroupType?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GroupModelImpl implements _GroupModel {
  const _$GroupModelImpl(
      {this.author,
      final List<UserModel>? admins,
      final List<UserModel>? members,
      this.avatar,
      this.uId,
      this.background,
      this.type})
      : _admins = admins,
        _members = members;

  factory _$GroupModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$GroupModelImplFromJson(json);

  @override
  final UserModel? author;
  final List<UserModel>? _admins;
  @override
  List<UserModel>? get admins {
    final value = _admins;
    if (value == null) return null;
    if (_admins is EqualUnmodifiableListView) return _admins;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<UserModel>? _members;
  @override
  List<UserModel>? get members {
    final value = _members;
    if (value == null) return null;
    if (_members is EqualUnmodifiableListView) return _members;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? avatar;
  @override
  final String? uId;
  @override
  final String? background;
  @override
  final GroupType? type;

  @override
  String toString() {
    return 'GroupModel(author: $author, admins: $admins, members: $members, avatar: $avatar, uId: $uId, background: $background, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroupModelImpl &&
            (identical(other.author, author) || other.author == author) &&
            const DeepCollectionEquality().equals(other._admins, _admins) &&
            const DeepCollectionEquality().equals(other._members, _members) &&
            (identical(other.avatar, avatar) || other.avatar == avatar) &&
            (identical(other.uId, uId) || other.uId == uId) &&
            (identical(other.background, background) ||
                other.background == background) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      author,
      const DeepCollectionEquality().hash(_admins),
      const DeepCollectionEquality().hash(_members),
      avatar,
      uId,
      background,
      type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GroupModelImplCopyWith<_$GroupModelImpl> get copyWith =>
      __$$GroupModelImplCopyWithImpl<_$GroupModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GroupModelImplToJson(
      this,
    );
  }
}

abstract class _GroupModel implements GroupModel {
  const factory _GroupModel(
      {final UserModel? author,
      final List<UserModel>? admins,
      final List<UserModel>? members,
      final String? avatar,
      final String? uId,
      final String? background,
      final GroupType? type}) = _$GroupModelImpl;

  factory _GroupModel.fromJson(Map<String, dynamic> json) =
      _$GroupModelImpl.fromJson;

  @override
  UserModel? get author;
  @override
  List<UserModel>? get admins;
  @override
  List<UserModel>? get members;
  @override
  String? get avatar;
  @override
  String? get uId;
  @override
  String? get background;
  @override
  GroupType? get type;
  @override
  @JsonKey(ignore: true)
  _$$GroupModelImplCopyWith<_$GroupModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
