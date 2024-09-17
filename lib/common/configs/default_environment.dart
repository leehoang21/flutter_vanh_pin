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

  //local
  static const String lang = 'lang';
  static const String vn = 'vn';
  static const String en = 'en';
}
