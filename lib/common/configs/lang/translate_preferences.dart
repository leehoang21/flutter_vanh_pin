import 'dart:ui';
import 'package:flutter_pin/common/configs/local_storage/local_storage.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:injectable/injectable.dart';

import '../../constants/language_constants.dart';
import '../default_environment.dart';

@singleton
class TranslatePreferences extends ITranslatePreferences {
  final LocalStorage localStorage;

  TranslatePreferences(this.localStorage);
  @override
  Future<Locale?> getPreferredLocale() async {
    final lang = await localStorage.read(DefaultEnvironment.lang) ??
        LanguageConstants.en;
    return Locale(lang);
  }

  @override
  Future savePreferredLocale(Locale locale) async {
    await localStorage.write(DefaultEnvironment.lang, locale.languageCode);
    return true;
  }
}
