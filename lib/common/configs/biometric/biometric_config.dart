import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_locker/flutter_locker.dart';
import 'package:injectable/injectable.dart';
import 'package:local_auth/local_auth.dart';
import 'package:pinpin/common/configs/firebase_config.dart';
import 'package:pinpin/common/configs/local_storage/local_storage.dart';
import 'package:pinpin/common/extension/string_extension.dart';
import 'package:pinpin/common/service/app_service.dart';
import 'package:pinpin/common/utils/app_utils.dart';
import '../../exception/app_error.dart';
import 'biometric_box_name.dart';

@singleton
class BiometricConfig {
  late LocalAuthentication _auth;
  final LocalStorage _localStorage;
  final AppService appService;
  final FirebaseConfig firebaseConfig;

  BiometricConfig(this.appService, this.firebaseConfig,
      {required LocalStorage localStorage})
      : _localStorage = localStorage;

  @postConstruct
  Future init() async {
    _auth = LocalAuthentication();
  }

  RetrieveSecretRequest _retrieveSecretRequest(String key) {
    return RetrieveSecretRequest(
      key: key,
      androidPrompt: _androidPrompt,
      iOsPrompt: _iOsPrompt,
    );
  }

  SaveSecretRequest _saveSecretRequest(String key, String secret) {
    return SaveSecretRequest(
      key: key,
      secret: secret,
      androidPrompt: _androidPrompt,
    );
  }

  AndroidPrompt get _androidPrompt => AndroidPrompt(
        cancelLabel: "cancel".tr,
        title: "auth".tr,
        descriptionLabel: "please_auth".tr,
      );

  IOsPrompt get _iOsPrompt => IOsPrompt(
        touchIdText: 'please_auth'.tr,
      );

  Future<AuthCredential?> get credential async {
    try {
      final jsonCredential = await FlutterLocker.retrieve(
        _retrieveSecretRequest(
          BiometricBoxName.credential,
        ),
      );
      if (isNullEmpty(jsonCredential)) return null;
      final mapCredential = json.decode(jsonCredential);
      final credential = AuthCredential(
        providerId: mapCredential['providerId'],
        signInMethod: mapCredential['signInMethod'],
        token: mapCredential['token'],
        accessToken: mapCredential['accessToken'],
      );
      return credential;
    } catch (e) {
      logger(e);
      return null;
    }
  }

  Future<bool> get canCheckBiometrics async {
    try {
      return _auth.canCheckBiometrics;
    } catch (e) {
      logger(e);
      return false;
    }
  }

  Future<bool> get canAuthenticateBiometric async {
    try {
      final result = await FlutterLocker.canAuthenticate();
      return result;
    } catch (e) {
      logger(e);
      return false;
    }
  }

  Future<bool> get isRegisterBiometricThisAccount async {
    try {
      final uId = appService.state.user?.uId ?? '';
      final storedUId = await _localStorage.read(BiometricBoxName.credential);
      return uId == storedUId;
    } catch (e) {
      logger(e);
      return false;
    }
  }

  Future<AppError?> registerBiometric() async {
    try {
      await _localStorage.write(
          BiometricBoxName.credential, appService.state.user?.uId ?? '');
      final jsonCredential = json.encode(appService.state.credential!.asMap());
      await FlutterLocker.save(
        _saveSecretRequest(BiometricBoxName.credential, jsonCredential),
      );
    } catch (e) {
      logger(e);
      return AppError(message: 'auth_fail');
    }
    return null;
  }

  Future<AppError?> unRegisterBiometric() async {
    try {
      await _localStorage.delete(BiometricBoxName.credential);
      await FlutterLocker.delete(BiometricBoxName.credential);
    } catch (e) {
      logger(e);
      return AppError(message: 'auth_fail');
    }
    return null;
  }
}
