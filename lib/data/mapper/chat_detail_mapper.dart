import 'package:pinpin/data/models/user_model.dart';

import '../../presentation/widgets/chat_view/chatview.dart';

class ChatMapper {
  static ChatUser convertUser(UserModel user) {
    return ChatUser(
      id: user.uId ?? '',
      name: user.userName ?? '',
      profilePhoto: user.avatar ?? '',
    );
  }
}
