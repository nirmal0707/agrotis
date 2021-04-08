import 'package:agrotis/app/locator.dart';
import 'package:agrotis/service/localization/localization_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class MyAppModel extends ReactiveViewModel {
  final AppLanguageService _service = locator<AppLanguageService>();

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_service];

  Locale get appLocal => _service.appLocal;
}
