import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pinpin/data/models/user_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../common/enums/app_enums.dart';

part 'group_model.freezed.dart';
part 'group_model.g.dart';

@freezed
class GroupModel with _$GroupModel {
  // ignore: invalid_annotation_target
  @JsonSerializable(explicitToJson: true)
  const factory GroupModel({
    UserModel? author,
    List<UserModel>? admins,
    List<UserModel>? members,
    String? avatar,
    String? uId,
    String? name,
    String? background,
    GroupType? type,
    DateTime? time,
  }) = _GroupModel;

  factory GroupModel.fromJson(Map<String, dynamic> json) =>
      _$GroupModelFromJson(json);

  factory GroupModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return GroupModel.fromJson(data).copyWith(uId: doc.id);
  }
}
