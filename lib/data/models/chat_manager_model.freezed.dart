// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_manager_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ChatManagerModel _$ChatManagerModelFromJson(Map<String, dynamic> json) {
  return _ChatManagerModel.fromJson(json);
}

/// @nodoc
mixin _$ChatManagerModel {
  String? get status => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  ContentType? get type => throw _privateConstructorUsedError;
  String? get content => throw _privateConstructorUsedError;
  UserModel? get author => throw _privateConstructorUsedError;
  String? get uId => throw _privateConstructorUsedError;
  String? get chatId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChatManagerModelCopyWith<ChatManagerModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatManagerModelCopyWith<$Res> {
  factory $ChatManagerModelCopyWith(
          ChatManagerModel value, $Res Function(ChatManagerModel) then) =
      _$ChatManagerModelCopyWithImpl<$Res, ChatManagerModel>;
  @useResult
  $Res call(
      {String? status,
      DateTime? updatedAt,
      DateTime? createdAt,
      ContentType? type,
      String? content,
      UserModel? author,
      String? uId,
      String? chatId});

  $UserModelCopyWith<$Res>? get author;
}

/// @nodoc
class _$ChatManagerModelCopyWithImpl<$Res, $Val extends ChatManagerModel>
    implements $ChatManagerModelCopyWith<$Res> {
  _$ChatManagerModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = freezed,
    Object? updatedAt = freezed,
    Object? createdAt = freezed,
    Object? type = freezed,
    Object? content = freezed,
    Object? author = freezed,
    Object? uId = freezed,
    Object? chatId = freezed,
  }) {
    return _then(_value.copyWith(
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
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ContentType?,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      author: freezed == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as UserModel?,
      uId: freezed == uId
          ? _value.uId
          : uId // ignore: cast_nullable_to_non_nullable
              as String?,
      chatId: freezed == chatId
          ? _value.chatId
          : chatId // ignore: cast_nullable_to_non_nullable
              as String?,
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
abstract class _$$ChatManagerModelImplCopyWith<$Res>
    implements $ChatManagerModelCopyWith<$Res> {
  factory _$$ChatManagerModelImplCopyWith(_$ChatManagerModelImpl value,
          $Res Function(_$ChatManagerModelImpl) then) =
      __$$ChatManagerModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? status,
      DateTime? updatedAt,
      DateTime? createdAt,
      ContentType? type,
      String? content,
      UserModel? author,
      String? uId,
      String? chatId});

  @override
  $UserModelCopyWith<$Res>? get author;
}

/// @nodoc
class __$$ChatManagerModelImplCopyWithImpl<$Res>
    extends _$ChatManagerModelCopyWithImpl<$Res, _$ChatManagerModelImpl>
    implements _$$ChatManagerModelImplCopyWith<$Res> {
  __$$ChatManagerModelImplCopyWithImpl(_$ChatManagerModelImpl _value,
      $Res Function(_$ChatManagerModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = freezed,
    Object? updatedAt = freezed,
    Object? createdAt = freezed,
    Object? type = freezed,
    Object? content = freezed,
    Object? author = freezed,
    Object? uId = freezed,
    Object? chatId = freezed,
  }) {
    return _then(_$ChatManagerModelImpl(
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
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ContentType?,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      author: freezed == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as UserModel?,
      uId: freezed == uId
          ? _value.uId
          : uId // ignore: cast_nullable_to_non_nullable
              as String?,
      chatId: freezed == chatId
          ? _value.chatId
          : chatId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$ChatManagerModelImpl implements _ChatManagerModel {
  const _$ChatManagerModelImpl(
      {this.status,
      this.updatedAt,
      this.createdAt,
      this.type,
      this.content,
      this.author,
      this.uId,
      this.chatId});

  factory _$ChatManagerModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatManagerModelImplFromJson(json);

  @override
  final String? status;
  @override
  final DateTime? updatedAt;
  @override
  final DateTime? createdAt;
  @override
  final ContentType? type;
  @override
  final String? content;
  @override
  final UserModel? author;
  @override
  final String? uId;
  @override
  final String? chatId;

  @override
  String toString() {
    return 'ChatManagerModel(status: $status, updatedAt: $updatedAt, createdAt: $createdAt, type: $type, content: $content, author: $author, uId: $uId, chatId: $chatId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatManagerModelImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.author, author) || other.author == author) &&
            (identical(other.uId, uId) || other.uId == uId) &&
            (identical(other.chatId, chatId) || other.chatId == chatId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, status, updatedAt, createdAt,
      type, content, author, uId, chatId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatManagerModelImplCopyWith<_$ChatManagerModelImpl> get copyWith =>
      __$$ChatManagerModelImplCopyWithImpl<_$ChatManagerModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatManagerModelImplToJson(
      this,
    );
  }
}

abstract class _ChatManagerModel implements ChatManagerModel {
  const factory _ChatManagerModel(
      {final String? status,
      final DateTime? updatedAt,
      final DateTime? createdAt,
      final ContentType? type,
      final String? content,
      final UserModel? author,
      final String? uId,
      final String? chatId}) = _$ChatManagerModelImpl;

  factory _ChatManagerModel.fromJson(Map<String, dynamic> json) =
      _$ChatManagerModelImpl.fromJson;

  @override
  String? get status;
  @override
  DateTime? get updatedAt;
  @override
  DateTime? get createdAt;
  @override
  ContentType? get type;
  @override
  String? get content;
  @override
  UserModel? get author;
  @override
  String? get uId;
  @override
  String? get chatId;
  @override
  @JsonKey(ignore: true)
  _$$ChatManagerModelImplCopyWith<_$ChatManagerModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
