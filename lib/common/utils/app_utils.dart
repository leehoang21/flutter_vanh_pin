import 'dart:convert';
import 'dart:developer';
import 'package:crypto/crypto.dart';

void logger(Object? message) {
  log('app_logger: {${message.toString()}}');
}

bool isNullEmpty(Object? o) => o == null || "" == o || o == "null";

bool isNullEmptyOrFalse(Object? o) => o == null || false == o || "" == o;

bool isNullEmptyFalseOrZero(Object? o) =>
    o == null || false == o || 0 == o || "" == o || "0" == o;

bool isNullEmptyList<T>(List<T>? t) => t == null || [] == t || t.isEmpty;

bool isNullEmptyMap<T>(Map<T, T>? t) => t == null || {} == t || t.isEmpty;

bool isNumeric(dynamic s) {
  String sConvert = s.toString();
  if (isNullEmpty(sConvert)) {
    return false;
  }
  return (double.tryParse(sConvert) != null || int.tryParse(sConvert) != null);
}

String formatPhoneNumber(String phoneNumber) {
  String newPhoneNumber = '';

  for (int i = 0; i < phoneNumber.length; i++) {
    if (phoneNumber[i] != ' ') {
      newPhoneNumber += phoneNumber[i];
    }
    if (newPhoneNumber.length % 4 == 0) {
      newPhoneNumber += ' ';
    }
  }

  return newPhoneNumber.trim();
}

String hash(String value) {
  // final rd = math.Random.secure().nextInt(1000000);
  final key = utf8.encode(value.toString());
  final value0 = utf8.encode(value);
  final hmacSha256 = Hmac(sha512256, key); // HMAC-SHA256
  return '${hmacSha256.convert(value0)}';
}
