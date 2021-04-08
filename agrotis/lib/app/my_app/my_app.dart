import 'package:agrotis/app/localization/app_localization.dart';
import 'package:agrotis/app/locator.dart';
import 'package:agrotis/app/my_app/my_app_model.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:agrotis/app/router.gr.dart' as router;
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MyAppModel>.reactive(
      builder: (context, model, child) => MaterialApp(
        locale: model.appLocal,
        supportedLocales: [
          Locale('en', 'US'),
          Locale('ml', ''),
        ],
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        builder: ExtendedNavigator.builder(
          router: router.Router(),
          navigatorKey: locator<NavigationService>().navigatorKey,
          initialRoute: router.Routes.splashScreenView,
          builder: (context, extendedNav) => Theme(
            data: ThemeData(
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            child: extendedNav,
          ),
        ),
      ),
      viewModelBuilder: () => MyAppModel(),
    );
  }
}
