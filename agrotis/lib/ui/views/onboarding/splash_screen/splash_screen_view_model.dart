import 'package:agrotis/app/locator.dart';
import 'package:agrotis/app/router.gr.dart';
import 'package:agrotis/service/auth/firebase_auth_service.dart';
import 'package:agrotis/service/crop_service.dart';
import 'package:agrotis/service/tts_service.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SplashScreenViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final CropService _cropService = locator<CropService>();
  final TtsService _ttsService = locator<TtsService>();

  final FirebaseAuthService _firebaseAuthService =
      locator<FirebaseAuthService>();

  String title = "Agrotis";

  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      runSplashService();
    });
  }

  Future<void> runSplashService() async {
    _cropService.initialiseCrops();
    await _ttsService.initTts();
    _ttsService.play("അഗ്രോട്ടിസിലേക്ക് സ്വാഗതം");
    await Future.delayed(Duration(seconds: 5));
    var _user = await _firebaseAuthService.currentUser();

    if (_user?.phone != null)
      _navigationService.replaceWith(Routes.homeScreenView);
    else
      _navigationService.replaceWith(Routes.loginScreenView);
  }
}
