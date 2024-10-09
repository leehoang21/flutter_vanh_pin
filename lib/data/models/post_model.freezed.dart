// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PostModel _$PostModelFromJson(Map<String, dynamic> json) {
  return _PostModel.fromJson(json);
}

/// @nodoc
mixin _$PostModel {
  List<String> get images => throw _privateConstructorUsedError;
  UserModel get author => throw _privateConstructorUsedError;
  GroupModel? get group => throw _privateConstructorUsedError;
  DateTime get time => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  List<EmojisModel>? get emojis => throw _privateConstructorUsedError;
  int get commentCount => throw _privateConstructorUsedError;
  int get shareCount => throw _privateConstructorUsedError;
  PostModel? get share => throw _privateConstructorUsedError;
  String? get uId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PostModelCopyWith<PostModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostModelCopyWith<$Res> {
  factory $PostModelCopyWith(PostModel value, $Res Function(PostModel) then) =
      _$PostModelCopyWithImpl<$Res, PostModel>;
  @useResult
  $Res call(
      {List<String> images,
      UserModel author,
      GroupModel? group,
      DateTime time,
      String content,
      List<EmojisModel>? emojis,
      int commentCount,
      int shareCount,
      PostModel? share,
      String? uId});

  $UserModelCopyWith<$Res> get author;
  $GroupModelCopyWith<$Res>? get group;
  $PostModelCopyWith<$Res>? get share;
}

/// @nodoc
class _$PostModelCopyWithImpl<$Res, $Val extends PostModel>
    implements $PostModelCopyWith<$Res> {
  _$PostModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? images = null,
    Object? author = null,
    Object? group = freezed,
    Object? time = null,
    Object? content = null,
    Object? emojis = freezed,
    Object? commentCount = null,
    Object? shareCount = null,
    Object? share = freezed,
    Object? uId = freezed,
  }) {
    return _then(_value.copyWith(
      images: null == images
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>,
      author: null == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as UserModel,
      group: freezed == group
          ? _value.group
          : group // ignore: cast_nullable_to_non_nullable
              as GroupModel?,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      emojis: freezed == emojis
          ? _value.emojis
          : emojis // ignore: cast_nullable_to_non_nullable
              as List<EmojisModel>?,
      commentCount: null == commentCount
          ? _value.commentCount
          : commentCount // ignore: cast_nullable_to_non_nullable
              as int,
      shareCount: null == shareCount
          ? _value.shareCount
          : shareCount // ignore: cast_nullable_to_non_nullable
              as int,
      share: freezed == share
          ? _value.share
          : share // ignore: cast_nullable_to_non_nullable
              as PostModel?,
      uId: freezed == uId
          ? _value.uId
          : uId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res> get author {
    return $UserModelCopyWith<$Res>(_value.author, (value) {
      return _then(_value.copyWith(author: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $GroupModelCopyWith<$Res>? get group {
    if (_value.group == null) {
      return null;
    }

    return $GroupModelCopyWith<$Res>(_value.group!, (value) {
      return _then(_value.copyWith(group: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PostModelCopyWith<$Res>? get share {
    if (_value.share == null) {
      return null;
    }

    return $PostModelCopyWith<$Res>(_value.share!, (value) {
      return _then(_value.copyWith(share: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PostModelImplCopyWith<$Res>
    implements $PostModelCopyWith<$Res> {
  factory _$$PostModelImplCopyWith(
          _$PostModelImpl value, $Res Function(_$PostModelImpl) then) =
      __$$PostModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<String> images,
      UserModel author,
      GroupModel? group,
      DateTime time,
      String content,
      List<EmojisModel>? emojis,
      int commentCount,
      int shareCount,
      PostModel? share,
      String? uId});

  @override
  $UserModelCopyWith<$Res> get author;
  @override
  $GroupModelCopyWith<$Res>? get group;
  @override
  $PostModelCopyWith<$Res>? get share;
}

/// @nodoc
class __$$PostModelImplCopyWithImpl<$Res>
    extends _$PostModelCopyWithImpl<$Res, _$PostModelImpl>
    implements _$$PostModelImplCopyWith<$Res> {
  __$$PostModelImplCopyWithImpl(
      _$PostModelImpl _value, $Res Function(_$PostModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? images = null,
    Object? author = null,
    Object? group = freezed,
    Object? time = null,
    Object? content = null,
    Object? emojis = freezed,
    Object? commentCount = null,
    Object? shareCount = null,
    Object? share = freezed,
    Object? uId = freezed,
  }) {
    return _then(_$PostModelImpl(
      images: null == images
          ? _value._images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>,
      author: null == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as UserModel,
      group: freezed == group
          ? _value.group
          : group // ignore: cast_nullable_to_non_nullable
              as GroupModel?,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      emojis: freezed == emojis
          ? _value._emojis
          : emojis // ignore: cast_nullable_to_non_nullable
              as List<EmojisModel>?,
      commentCount: null == commentCount
          ? _value.commentCount
          : commentCount // ignore: cast_nullable_to_non_nullable
              as int,
      shareCount: null == shareCount
          ? _value.shareCount
          : shareCount // ignore: cast_nullable_to_non_nullable
              as int,
      share: freezed == share
          ? _value.share
          : share // ignore: cast_nullable_to_non_nullable
              as PostModel?,
      uId: freezed == uId
          ? _value.uId
          : uId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$PostModelImpl implements _PostModel {
  const _$PostModelImpl(
      {final List<String> images = const [],
      required this.author,
      this.group,
      required this.time,
      required this.content,
      final List<EmojisModel>? emojis = const [],
      this.commentCount = 0,
      this.shareCount = 0,
      this.share,
      this.uId})
      : _images = images,
        _emojis = emojis;

  factory _$PostModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PostModelImplFromJson(json);

  final List<String> _images;
  @override
  @JsonKey()
  List<String> get images {
    if (_images is EqualUnmodifiableListView) return _images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_images);
  }

  @override
  final UserModel author;
  @override
  final GroupModel? group;
  @override
  final DateTime time;
  @override
  final String content;
  final List<EmojisModel>? _emojis;
  @override
  @JsonKey()
  List<EmojisModel>? get emojis {
    final value = _emojis;
    if (value == null) return null;
    if (_emojis is EqualUnmodifiableListView) return _emojis;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey()
  final int commentCount;
  @override
  @JsonKey()
  final int shareCount;
  @override
  final PostModel? share;
  @override
  final String? uId;

  @override
  String toString() {
    return 'PostModel(images: $images, author: $author, group: $group, time: $time, content: $content, emojis: $emojis, commentCount: $commentCount, shareCount: $shareCount, share: $share, uId: $uId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostModelImpl &&
            const DeepCollectionEquality().equals(other._images, _images) &&
            (identical(other.author, author) || other.author == author) &&
            (identical(other.group, group) || other.group == group) &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.content, content) || other.content == content) &&
            const DeepCollectionEquality().equals(other._emojis, _emojis) &&
            (identical(other.commentCount, commentCount) ||
                other.commentCount == commentCount) &&
            (identical(other.shareCount, shareCount) ||
                other.shareCount == shareCount) &&
            (identical(other.share, share) || other.share == share) &&
            (identical(other.uId, uId) || other.uId == uId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_images),
      author,
      group,
      time,
      content,
      const DeepCollectionEquality().hash(_emojis),
      commentCount,
      shareCount,
      share,
      uId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PostModelImplCopyWith<_$PostModelImpl> get copyWith =>
      __$$PostModelImplCopyWithImpl<_$PostModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PostModelImplToJson(
      this,
    );
  }
}

abstract class _PostModel implements PostModel {
  const factory _PostModel(
      {final List<String> images,
      required final UserModel author,
      final GroupModel? group,
      required final DateTime time,
      required final String content,
      final List<EmojisModel>? emojis,
      final int commentCount,
      final int shareCount,
      final PostModel? share,
      final String? uId}) = _$PostModelImpl;

  factory _PostModel.fromJson(Map<String, dynamic> json) =
      _$PostModelImpl.fromJson;

  @override
  List<String> get images;
  @override
  UserModel get author;
  @override
  GroupModel? get group;
  @override
  DateTime get time;
  @override
  String get content;
  @override
  List<EmojisModel>? get emojis;
  @override
  int get commentCount;
  @override
  int get shareCount;
  @override
  PostModel? get share;
  @override
  String? get uId;
  @override
  @JsonKey(ignore: true)
  _$$PostModelImplCopyWith<_$PostModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
