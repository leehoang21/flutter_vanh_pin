import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:pinpin/common/configs/default_environment.dart';
import 'package:pinpin/common/configs/local_storage/local_storage.dart';
import 'package:pinpin/common/utils/app_utils.dart';
import 'package:pinpin/data/models/user_model.dart';
import 'common/configs/lang/translate_preferences.dart';
import 'common/constants/language_constants.dart';
import 'common/di/di.dart';
import 'common/initializer/init.dart';
import 'data/models/notification_model.dart';
import 'firebase_options.dart';
import 'presentation/app/app.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final LocalStorage localStorage = LocalStorage();

  final model =
      NotificationModel.fromString(((message.data)['data'] as String?) ?? '');

  final state = await localStorage.read(DefaultEnvironment.notification);
  final user = await localStorage.read(DefaultEnvironment.user);
  if (isNullEmpty(user)) {
    final userModel = UserModel.fromJson(json.decode(user!));
    final key = '${DefaultEnvironment.notification}-${userModel.uId}';
    if (isNullEmpty(state)) {
      localStorage.write(key, json.encode([model.toJson()]));
    } else {
      final List<NotificationModel> notifications =
          (json.decode(state ?? '') as List)
              .map((e) => NotificationModel.fromJson(e))
              .toList();
      notifications.add(model);
      localStorage.write(
          key, json.encode(notifications.map((e) => e.toJson()).toList()));
    }
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppInitializer.init();
  final delegate = await LocalizationDelegate.create(
    fallbackLocale: LanguageConstants.en,
    supportedLocales: [
      LanguageConstants.vi,
      LanguageConstants.en,
    ],
    preferences: getIt.get<TranslatePreferences>(),
  );
  // Set the background messaging handler early on, as a named top-level function
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(
    LocalizedApp(
      delegate,
      const App(),
    ),
  );
}
