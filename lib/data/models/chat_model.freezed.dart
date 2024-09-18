// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ChatModel _$ChatModelFromJson(Map<String, dynamic> json) {
  return _ChatModel.fromJson(json);
}

/// @nodoc
mixin _$ChatModel {
  List<UserModel> get members => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  ChatType? get chatType => throw _privateConstructorUsedError;
  String? get chatName => throw _privateConstructorUsedError;
  String? get chatAvatar => throw _privateConstructorUsedError;
  String? get chatContent => throw _privateConstructorUsedError;
  String? get uId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChatModelCopyWith<ChatModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatModelCopyWith<$Res> {
  factory $ChatModelCopyWith(ChatModel value, $Res Function(ChatModel) then) =
      _$ChatModelCopyWithImpl<$Res, ChatModel>;
  @useResult
  $Res call(
      {List<UserModel> members,
      String? status,
      DateTime? updatedAt,
      DateTime? createdAt,
      ChatType? chatType,
      String? chatName,
      String? chatAvatar,
      String? chatContent,
      String? uId});
}

/// @nodoc
class _$ChatModelCopyWithImpl<$Res, $Val extends ChatModel>
    implements $ChatModelCopyWith<$Res> {
  _$ChatModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? members = null,
    Object? status = freezed,
    Object? updatedAt = freezed,
    Object? createdAt = freezed,
    Object? chatType = freezed,
    Object? chatName = freezed,
    Object? chatAvatar = freezed,
    Object? chatContent = freezed,
    Object? uId = freezed,
  }) {
    return _then(_value.copyWith(
      members: null == members
          ? _value.members
          : members // ignore: cast_nullable_to_non_nullable
              as List<UserModel>,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      chatType: freezed == chatType
          ? _value.chatType
          : chatType // ignore: cast_nullable_to_non_nullable
              as ChatType?,
      chatName: freezed == chatName
          ? _value.chatName
          : chatName // ignore: cast_nullable_to_non_nullable
              as String?,
      chatAvatar: freezed == chatAvatar
          ? _value.chatAvatar
          : chatAvatar // ignore: cast_nullable_to_non_nullable
              as String?,
      chatContent: freezed == chatContent
          ? _value.chatContent
          : chatContent // ignore: cast_nullable_to_non_nullable
              as String?,
      uId: freezed == uId
          ? _value.uId
          : uId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChatModelImplCopyWith<$Res>
    implements $ChatModelCopyWith<$Res> {
  factory _$$ChatModelImplCopyWith(
          _$ChatModelImpl value, $Res Function(_$ChatModelImpl) then) =
      __$$ChatModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<UserModel> members,
      String? status,
      DateTime? updatedAt,
      DateTime? createdAt,
      ChatType? chatType,
      String? chatName,
      String? chatAvatar,
      String? chatContent,
      String? uId});
}

/// @nodoc
class __$$ChatModelImplCopyWithImpl<$Res>
    extends _$ChatModelCopyWithImpl<$Res, _$ChatModelImpl>
    implements _$$ChatModelImplCopyWith<$Res> {
  __$$ChatModelImplCopyWithImpl(
      _$ChatModelImpl _value, $Res Function(_$ChatModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? members = null,
    Object? status = freezed,
    Object? updatedAt = freezed,
    Object? createdAt = freezed,
    Object? chatType = freezed,
    Object? chatName = freezed,
    Object? chatAvatar = freezed,
    Object? chatContent = freezed,
    Object? uId = freezed,
  }) {
    return _then(_$ChatModelImpl(
      members: null == members
          ? _value._members
          : members // ignore: cast_nullable_to_non_nullable
              as List<UserModel>,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      chatType: freezed == chatType
          ? _value.chatType
          : chatType // ignore: cast_nullable_to_non_nullable
              as ChatType?,
      chatName: freezed == chatName
          ? _value.chatName
          : chatName // ignore: cast_nullable_to_non_nullable
              as String?,
      chatAvatar: freezed == chatAvatar
          ? _value.chatAvatar
          : chatAvatar // ignore: cast_nullable_to_non_nullable
              as String?,
      chatContent: freezed == chatContent
          ? _value.chatContent
          : chatContent // ignore: cast_nullable_to_non_nullable
              as String?,
      uId: freezed == uId
          ? _value.uId
          : uId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$ChatModelImpl implements _ChatModel {
  const _$ChatModelImpl(
      {final List<UserModel> members = const [],
      this.status,
      this.updatedAt,
      this.createdAt,
      this.chatType,
      this.chatName,
      this.chatAvatar,
      this.chatContent,
      this.uId})
      : _members = members;

  factory _$ChatModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatModelImplFromJson(json);

  final List<UserModel> _members;
  @override
  @JsonKey()
  List<UserModel> get members {
    if (_members is EqualUnmodifiableListView) return _members;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_members);
  }

  @override
  final String? status;
  @override
  final DateTime? updatedAt;
  @override
  final DateTime? createdAt;
  @override
  final ChatType? chatType;
  @override
  final String? chatName;
  @override
  final String? chatAvatar;
  @override
  final String? chatContent;
  @override
  final String? uId;

  @override
  String toString() {
    return 'ChatModel(members: $members, status: $status, updatedAt: $updatedAt, createdAt: $createdAt, chatType: $chatType, chatName: $chatName, chatAvatar: $chatAvatar, chatContent: $chatContent, uId: $uId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatModelImpl &&
            const DeepCollectionEquality().equals(other._members, _members) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.chatType, chatType) ||
                other.chatType == chatType) &&
            (identical(other.chatName, chatName) ||
                other.chatName == chatName) &&
            (identical(other.chatAvatar, chatAvatar) ||
                other.chatAvatar == chatAvatar) &&
            (identical(other.chatContent, chatContent) ||
                other.chatContent == chatContent) &&
            (identical(other.uId, uId) || other.uId == uId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_members),
      status,
      updatedAt,
      createdAt,
      chatType,
      chatName,
      chatAvatar,
      chatContent,
      uId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatModelImplCopyWith<_$ChatModelImpl> get copyWith =>
      __$$ChatModelImplCopyWithImpl<_$ChatModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatModelImplToJson(
      this,
    );
  }
}

abstract class _ChatModel implements ChatModel {
  const factory _ChatModel(
      {final List<UserModel> members,
      final String? status,
      final DateTime? updatedAt,
      final DateTime? createdAt,
      final ChatType? chatType,
      final String? chatName,
      final String? chatAvatar,
      final String? chatContent,
      final String? uId}) = _$ChatModelImpl;

  factory _ChatModel.fromJson(Map<String, dynamic> json) =
      _$ChatModelImpl.fromJson;

  @override
  List<UserModel> get members;
  @override
  String? get status;
  @override
  DateTime? get updatedAt;
  @override
  DateTime? get createdAt;
  @override
  ChatType? get chatType;
  @override
  String? get chatName;
  @override
  String? get chatAvatar;
  @override
  String? get chatContent;
  @override
  String? get uId;
  @override
  @JsonKey(ignore: true)
  _$$ChatModelImplCopyWith<_$ChatModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
