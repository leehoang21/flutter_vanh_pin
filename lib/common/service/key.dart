import 'package:crypton/crypton.dart';
import 'package:encrypt/encrypt.dart';

import 'package:flutter_keychain/flutter_keychain.dart';
import 'package:injectable/injectable.dart';
import 'package:pinpin/common/configs/default_environment.dart';
import 'package:pinpin/common/configs/local_storage/local_storage.dart';

@singleton
class KeyService {
  late final RSAPublicKey _publicKey;
  late final RSAPrivateKey _privateKey;
  final LocalStorage localStorage;

  KeyService(this.localStorage);

  _init() {
    final key = RSAKeypair.fromRandom();
    _privateKey = key.privateKey;
    _publicKey = key.publicKey;
    localStorage.write(DefaultEnvironment.publicKey, _publicKey.toString());
    localStorage.write(DefaultEnvironment.privateKey, _privateKey.toString());
  }

  @postConstruct
  Future init() async {
    final publicKey = await localStorage.read(DefaultEnvironment.publicKey);
    if (publicKey == null) {
      _init();
    } else {
      _publicKey = RSAPublicKey.fromString(publicKey);
      final privateKey = await localStorage.read(DefaultEnvironment.privateKey);
      _privateKey = RSAPrivateKey.fromString(privateKey!);
    }
  }

  RSAPublicKey? get publicKey {
    return _publicKey;
  }

  String decrypteRsa(String cipherText) {
    final decrypted = _privateKey.decrypt(cipherText);

    return decrypted;
  }

  String encryteRsa(String plainText) {
    final encrypted = _publicKey.encrypt(plainText);
    return encrypted;
  }
}

class KeyApp {
  (Key, IV) get gennerateKey {
    return (Key.fromSecureRandom(32), IV.fromSecureRandom(16));
  }

  (Key, IV) _fromKey(String key, String iv) {
    return (Key.fromBase64(key), IV.fromBase64(iv));
  }

  Future<(Key, IV)?> getKeyAes(String uId) async {
    final value =
        await FlutterKeychain.get(key: DefaultEnvironment.key + (uId));
    final iv = await FlutterKeychain.get(key: DefaultEnvironment.iv + (uId));
    if (value == null) return null;
    if (iv == null) return null;
    return (
      Key.fromBase64(value),
      IV.fromBase64(iv),
    );
  }

  Future<void> setKeyAes(String key, String iv, String uId) async {
    final keyValue = _fromKey(key, iv);
    await FlutterKeychain.put(
        key: DefaultEnvironment.key + uId, value: keyValue.$1.base64);
    await FlutterKeychain.put(
        key: DefaultEnvironment.iv + uId, value: keyValue.$2.base64);
  }

  encrypted(String plainText, String key, String iv) {
    final keyValue = _fromKey(key, iv);
    final encrypter =
        Encrypter(AES(keyValue.$1, mode: AESMode.ctr, padding: null));
    final encrypted = encrypter.encrypt(plainText, iv: keyValue.$2);
    return encrypted.base64;
  }

  decrypted(String cipherText, String key, String iv) {
    final keyValue = _fromKey(key, iv);

    final encrypter =
        Encrypter(AES(keyValue.$1, mode: AESMode.ctr, padding: null));

    final decrypted =
        encrypter.decrypt(Encrypted.fromBase64(cipherText), iv: keyValue.$2);
    return decrypted;
  }
}
