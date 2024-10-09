import 'package:flutter/foundation.dart';

class DefaultEnvironment {
  static const String environmentHome = 'vanh-pin';
  static const String environment = kDebugMode ? 'develop' : 'release';
  static const String avatar = 'avatar.jpeg';

  static const String customer = 'customer';
  static const String user = 'user';
  static const String post = 'post';
  static const String images = 'images';
  static const String group = 'group';
  static const String chat = 'chats';
  static const String message = 'messages';
  static const String friend = 'friend';
  static const String comment = 'comment';
  static const String tokens = 'tokens';
  static const String notification = 'notification';

  static const String key = 'key';
  static const String token = 'token';

  //local
  static const String lang = 'lang';
  static const String vn = 'vn';
  static const String en = 'en';
}
