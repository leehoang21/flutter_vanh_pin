import 'package:chatview/chatview.dart';
import 'package:pinpin/data/models/user_model.dart';

class ChatMapper {
  static ChatUser convertUser(UserModel user) {
    return ChatUser(
      id: user.uId ?? '',
      name: user.userName ?? '',
      profilePhoto: user.avatar ?? '',
    );
  }
}
