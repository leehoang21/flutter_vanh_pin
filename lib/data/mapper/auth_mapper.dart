import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_pin/data/models/user_model.dart';

class AuthMapper {
  static UserModel convertUserCredentialToUserModel(User user) {
    return UserModel(
      phoneNumber: user.phoneNumber ?? '',
      uId: user.uid,
      avatar: user.photoURL,
      email: user.email,
      userName: user.displayName ?? '',
    );
  }
}
