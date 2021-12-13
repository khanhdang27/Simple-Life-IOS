import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLanguage {
  static const String appLanguageKey = 'langSelected';

  /// Use at _AppLocalizationsDelegate line 67 in this file
  static const List<String> supportedLangCode = ['en', 'zh'];

  /// Use at app.dart
  static Locale selectedLanguage = Locale('zh', null);

  /// Use at app.dart
  static List<Locale> supportLanguage = [
    Locale('zh'),
    Locale('en', 'US'),
  ];

  static final AppLanguage _instance = AppLanguage._internal();

  factory AppLanguage() {
    return _instance;
  }

  AppLanguage._internal();
}

class AppLocalizations {
  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  final Locale locale;

  Map<String, String> _localizedStrings = {};

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  Future<bool> load() async {
    String languageCode = 'assets/lang/${locale.languageCode}.json';
    if (locale.countryCode != null) {
      languageCode =
          'assets/lang/${locale.languageCode}_${locale.countryCode}.json';
    }
    String jsonString = await rootBundle.loadString(languageCode);
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });
    return true;
  }

  String translate(String key) {
    return _localizedStrings[key]!;
  }

  static String t(BuildContext context, String key) {
    return AppLocalizations.of(context).translate(key);
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return AppLanguage.supportedLangCode.contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
