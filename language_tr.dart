
import 'dart:ui';
import 'package:get/get.dart';
import 'package:topointme/core/language/items/en.dart';
import 'package:topointme/core/language/items/ru.dart';
import 'package:topointme/core/language/items/ua.dart';
import 'package:topointme/core/language/items/de.dart';
import 'package:topointme/core/language/items/es.dart';
import 'package:topointme/core/language/items/zh.dart';
import 'package:topointme/core/service/storage/settings.dart';

class Language extends Translations {
  static final locale = Locale('en', 'GB');
  static final fallbackLocale = Locale('en', 'GB');
  static final UaLanguage uaLanguage = UaLanguage();
  static final EnLanguage enLanguage = EnLanguage();
  static final DeLanguage deLanguage = DeLanguage();
  static final EsLanguage esLanguage = EsLanguage();
  static final ZhLanguage zhLanguage = ZhLanguage();
  static final RuLanguage ruLanguage = RuLanguage();

  @override
  Map<String, Map<String, String>> get keys => {
    'uk_UK': uaLanguage.language,
    'en_GB': enLanguage.language,
    'de_DE': deLanguage.language,
    'es_ES': esLanguage.language,
    'zh_CN': zhLanguage.language,
    'ru_RU': ruLanguage.language,
  };

  static final langCode = [
    'uk',
    'en',
    'de',
    'es',
    'zh',
    'ru',
  ];

  static final locales = [
    Locale('uk', 'UK'),
    Locale('en', 'GB'),
    Locale('de', 'DE'),
    Locale('es', 'ES'),
    Locale('zh', 'CN'),
    Locale('ru', 'RU'),
  ];

  void changeLocale(String lang) {
    final locale = _getLocaleFromLanguage(lang);
    Get.updateLocale(locale!);
    SettingsGet().language = locale.languageCode;
  }

  Locale? _getLocaleFromLanguage(String lang) {
    for (int i = 0; i < langCode.length; i++) {
      if (lang == langCode[i]) return locales[i];
    }
    return Get.locale;
  }

  Locale? language(String langCode) {
    final locale = _getLocaleFromLanguage(langCode);
    return locale;
  }
}

abstract class BaseLanguage {
  Map<String, String> get language;
}