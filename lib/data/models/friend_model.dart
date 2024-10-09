import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pinpin/data/models/user_model.dart';

part 'friend_model.freezed.dart';
part 'friend_model.g.dart';

enum FriendStatus {
  pending,
  accepted,
  all,
}

@freezed
class FriendModel with _$FriendModel {
  // ignore: invalid_annotation_target
  @JsonSerializable(explicitToJson: true)
  const factory FriendModel({
    UserModel? user,
    @Default(FriendStatus.pending) FriendStatus status,
    String? uId,
    UserModel? author,
  }) = _FriendModel;

  factory FriendModel.fromJson(Map<String, dynamic> json) =>
      _$FriendModelFromJson(json);
}
