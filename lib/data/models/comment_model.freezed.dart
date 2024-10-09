// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'comment_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CommentModel _$CommentModelFromJson(Map<String, dynamic> json) {
  return _CommentModel.fromJson(json);
}

/// @nodoc
mixin _$CommentModel {
  UserModel get author => throw _privateConstructorUsedError;
  DateTime get time => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  List<EmojisModel> get emojis => throw _privateConstructorUsedError;
  String get postId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CommentModelCopyWith<CommentModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommentModelCopyWith<$Res> {
  factory $CommentModelCopyWith(
          CommentModel value, $Res Function(CommentModel) then) =
      _$CommentModelCopyWithImpl<$Res, CommentModel>;
  @useResult
  $Res call(
      {UserModel author,
      DateTime time,
      String content,
      List<EmojisModel> emojis,
      String postId});

  $UserModelCopyWith<$Res> get author;
}

/// @nodoc
class _$CommentModelCopyWithImpl<$Res, $Val extends CommentModel>
    implements $CommentModelCopyWith<$Res> {
  _$CommentModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? author = null,
    Object? time = null,
    Object? content = null,
    Object? emojis = null,
    Object? postId = null,
  }) {
    return _then(_value.copyWith(
      author: null == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as UserModel,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      emojis: null == emojis
          ? _value.emojis
          : emojis // ignore: cast_nullable_to_non_nullable
              as List<EmojisModel>,
      postId: null == postId
          ? _value.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res> get author {
    return $UserModelCopyWith<$Res>(_value.author, (value) {
      return _then(_value.copyWith(author: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CommentModelImplCopyWith<$Res>
    implements $CommentModelCopyWith<$Res> {
  factory _$$CommentModelImplCopyWith(
          _$CommentModelImpl value, $Res Function(_$CommentModelImpl) then) =
      __$$CommentModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {UserModel author,
      DateTime time,
      String content,
      List<EmojisModel> emojis,
      String postId});

  @override
  $UserModelCopyWith<$Res> get author;
}

/// @nodoc
class __$$CommentModelImplCopyWithImpl<$Res>
    extends _$CommentModelCopyWithImpl<$Res, _$CommentModelImpl>
    implements _$$CommentModelImplCopyWith<$Res> {
  __$$CommentModelImplCopyWithImpl(
      _$CommentModelImpl _value, $Res Function(_$CommentModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? author = null,
    Object? time = null,
    Object? content = null,
    Object? emojis = null,
    Object? postId = null,
  }) {
    return _then(_$CommentModelImpl(
      author: null == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as UserModel,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      emojis: null == emojis
          ? _value._emojis
          : emojis // ignore: cast_nullable_to_non_nullable
              as List<EmojisModel>,
      postId: null == postId
          ? _value.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$CommentModelImpl implements _CommentModel {
  const _$CommentModelImpl(
      {required this.author,
      required this.time,
      required this.content,
      final List<EmojisModel> emojis = const [],
      required this.postId})
      : _emojis = emojis;

  factory _$CommentModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CommentModelImplFromJson(json);

  @override
  final UserModel author;
  @override
  final DateTime time;
  @override
  final String content;
  final List<EmojisModel> _emojis;
  @override
  @JsonKey()
  List<EmojisModel> get emojis {
    if (_emojis is EqualUnmodifiableListView) return _emojis;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_emojis);
  }

  @override
  final String postId;

  @override
  String toString() {
    return 'CommentModel(author: $author, time: $time, content: $content, emojis: $emojis, postId: $postId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CommentModelImpl &&
            (identical(other.author, author) || other.author == author) &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.content, content) || other.content == content) &&
            const DeepCollectionEquality().equals(other._emojis, _emojis) &&
            (identical(other.postId, postId) || other.postId == postId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, author, time, content,
      const DeepCollectionEquality().hash(_emojis), postId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CommentModelImplCopyWith<_$CommentModelImpl> get copyWith =>
      __$$CommentModelImplCopyWithImpl<_$CommentModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CommentModelImplToJson(
      this,
    );
  }
}

abstract class _CommentModel implements CommentModel {
  const factory _CommentModel(
      {required final UserModel author,
      required final DateTime time,
      required final String content,
      final List<EmojisModel> emojis,
      required final String postId}) = _$CommentModelImpl;

  factory _CommentModel.fromJson(Map<String, dynamic> json) =
      _$CommentModelImpl.fromJson;

  @override
  UserModel get author;
  @override
  DateTime get time;
  @override
  String get content;
  @override
  List<EmojisModel> get emojis;
  @override
  String get postId;
  @override
  @JsonKey(ignore: true)
  _$$CommentModelImplCopyWith<_$CommentModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
