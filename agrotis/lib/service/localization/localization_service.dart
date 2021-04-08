import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:observable_ish/observable_ish.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

enum LanguageType { ENGLISH, MALAYALAM }

@singleton
class AppLanguageService with ReactiveServiceMixin {
  AppLanguageService() {
    listenToReactiveValues([
      _appLocale,
    ]);
  }

  RxValue<Locale> _appLocale = RxValue<Locale>(initial: Locale('en'));

  Locale get appLocal => _appLocale.value ?? Locale("en");

  fetchLocale() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getString('language_code') == null) {
      _appLocale.value = Locale('ml');
      return null;
    }
    _appLocale.value = Locale(prefs.getString('language_code'));
    return null;
  }

  void changeLanguage(Locale type) async {
    var prefs = await SharedPreferences.getInstance();
    if (_appLocale.value == type) {
      return;
    }
    if (type == Locale("ml")) {
      _appLocale.value = Locale("ml");
      await prefs.setString('language_code', 'ml');
      await prefs.setString('countryCode', '');
    } else {
      _appLocale.value = Locale("en");
      await prefs.setString('language_code', 'en');
      await prefs.setString('countryCode', 'US');
    }
    notifyListeners();
  }
}
