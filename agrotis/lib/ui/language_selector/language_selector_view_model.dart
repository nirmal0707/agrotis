import 'package:agrotis/app/locator.dart';
import 'package:agrotis/service/localization/localization_service.dart';
import 'package:agrotis/service/tts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

class LanguageSelectorViewModel extends ReactiveViewModel {
  final _languageService = locator<AppLanguageService>();
  final TtsService _ttsService = locator<TtsService>();

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_languageService];

  LanguageType get currentLanguageType =>
      _languageService.appLocal == Locale("ml")
          ? LanguageType.MALAYALAM
          : LanguageType.ENGLISH;

  void changeLanguage(LanguageType languageType) {
    switch (languageType) {
      case LanguageType.MALAYALAM:
        _languageService.changeLanguage(Locale("ml"));
        break;
      default:
        _languageService.changeLanguage(Locale("en"));
        break;
    }
    // _ttsService.setLang(languageType);
    notifyListeners();
  }
}
