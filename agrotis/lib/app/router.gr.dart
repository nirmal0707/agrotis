// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../ui/views/crop_finder/crop_finder.dart';
import '../ui/views/home/crop_details/crop_details_view.dart';
import '../ui/views/home/disease_page/disease_page_view.dart';
import '../ui/views/home/disease_page/modelHelper.dart';
import '../ui/views/home/home_view.dart';
import '../ui/views/onboarding/login/login_screen_view.dart';
import '../ui/views/onboarding/splash_screen/splash_screen_view.dart';

class Routes {
  static const String splashScreenView = '/';
  static const String homeScreenView = '/home-screen-view';
  static const String loginScreenView = '/login-screen-view';
  static const String cropDetailsView = '/crop-details-view';
  static const String diseasePageView = '/disease-page-view';
  static const String diseasePredictor = '/disease-predictor';
  static const String cropFinderView = '/crop-finder-view';
  static const all = <String>{
    splashScreenView,
    homeScreenView,
    loginScreenView,
    cropDetailsView,
    diseasePageView,
    diseasePredictor,
    cropFinderView,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.splashScreenView, page: SplashScreenView),
    RouteDef(Routes.homeScreenView, page: HomeScreenView),
    RouteDef(Routes.loginScreenView, page: LoginScreenView),
    RouteDef(Routes.cropDetailsView, page: CropDetailsView),
    RouteDef(Routes.diseasePageView, page: DiseasePageView),
    RouteDef(Routes.diseasePredictor, page: DiseasePredictor),
    RouteDef(Routes.cropFinderView, page: CropFinderView),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    SplashScreenView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const SplashScreenView(),
        settings: data,
      );
    },
    HomeScreenView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const HomeScreenView(),
        settings: data,
      );
    },
    LoginScreenView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const LoginScreenView(),
        settings: data,
      );
    },
    CropDetailsView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const CropDetailsView(),
        settings: data,
      );
    },
    DiseasePageView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const DiseasePageView(),
        settings: data,
      );
    },
    DiseasePredictor: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => DiseasePredictor(),
        settings: data,
      );
    },
    CropFinderView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const CropFinderView(),
        settings: data,
      );
    },
  };
}
