import 'package:agrotis/ui/views/crop_finder/crop_finder.dart';
import 'package:agrotis/ui/views/home/crop_details/crop_details_view.dart';
import 'package:agrotis/ui/views/home/disease_page/disease_page_view.dart';
import 'package:agrotis/ui/views/home/disease_page/modelHelper.dart';
import 'package:agrotis/ui/views/home/home_view.dart';
import 'package:agrotis/ui/views/onboarding/login/login_screen_view.dart';
import 'package:agrotis/ui/views/onboarding/splash_screen/splash_screen_view.dart';
import 'package:auto_route/auto_route_annotations.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    // initial route is named "/"
    MaterialRoute(page: SplashScreenView, initial: true),
    MaterialRoute(page: HomeScreenView),
    MaterialRoute(page: LoginScreenView),
    MaterialRoute(page: CropDetailsView),
    MaterialRoute(page: DiseasePageView),
    MaterialRoute(page: DiseasePredictor),
    MaterialRoute(page: CropFinderView),
  ],
)
class $Router {}
