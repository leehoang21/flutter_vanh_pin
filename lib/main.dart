import 'package:flutter/material.dart';
import 'package:flutter_pin/common/assets/assets.gen.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'common/configs/lang/translate_preferences.dart';
import 'common/di/di.dart';
import 'common/initializer/init.dart';
import 'presentation/app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppInitializer.init();
  final delegate = await LocalizationDelegate.create(
    fallbackLocale: Assets.i18n.en,
    supportedLocales: [
      Assets.i18n.vi,
      Assets.i18n.en,
    ],
    preferences: getIt<TranslatePreferences>(),
  );
  runApp(
    LocalizedApp(
      delegate,
      const App(),
    ),
  );
}
