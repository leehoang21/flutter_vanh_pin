import 'package:flutter_pin/common/extension/string_extension.dart';
import 'package:flutter_pin/common/utils/app_utils.dart';

class AppValidator {
  //số điện thoại phải là số và có 10 ký tự, số đầu tiên là 0
  static const String _validatePhone = r'^0\d{9}$';
  static const String _validateEmail =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  //Mật khẩu phải có ít nhất 8 ký tự, trong đó có ít nhất 1 chữ cái viết hoa, 1 chữ cái viết thường và 1 số,1 ký tự đặc biệt
  static const String _validatePassword =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[^\w\s]).{8,}$';
  static RegExp expPhoneNumber = RegExp(_validatePhone);
  static RegExp expPassword = RegExp(_validatePassword);

  static RegExp expEmail = RegExp(_validateEmail);

  static String? validatePhoneNumber(String? phoneNumber) {
    phoneNumber = phoneNumber?.replaceAll(' ', '');
    if (phoneNumber == null ||
        phoneNumber.isEmpty ||
        !expPhoneNumber.hasMatch(phoneNumber)) {
      return 'invalid_phone'.tr;
    }
    return null;
  }

  static String? validatePassword(String? password) {
    if (password == null ||
        password.isEmpty ||
        !expPassword.hasMatch(password)) {
      return 'invalid_password'.tr;
    }
    return null;
  }

  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty || !expEmail.hasMatch(email)) {
      return 'invalid_email'.tr;
    }
    return null;
  }

  static String? validateUseName(String? userName) {
    if (isNullEmpty(userName)) {
      return 'user_empty'.tr;
    }
    return null;
  }
}
