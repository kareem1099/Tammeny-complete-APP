import 'package:flutter/material.dart';
import 'package:tamenny_app/config/cache_helper.dart';

class LocaleNotifier extends ChangeNotifier {
  static const String _localeKey = 'selectedLocale';
  Locale _locale = const Locale('en'); // Default language is English

  Locale get locale => _locale;

  LocaleNotifier() {
    loadLocaleFromPrefs(); // Load saved locale on init
  }

  void setLocale(Locale locale) {
    _locale = locale;
    notifyListeners();
    _saveLocaleToPrefs();
  }

  Future<void> loadLocaleFromPrefs() async {
    final String languageCode = CacheHelper.getString(key: _localeKey) ?? 'en';
    _locale = Locale(languageCode);
    notifyListeners();
  }

  Future<void> _saveLocaleToPrefs() async {
    await CacheHelper.set(key: _localeKey, value: _locale.languageCode);
  }
}
