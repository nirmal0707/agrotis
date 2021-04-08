import 'package:agrotis/app/locator.dart';
import 'package:agrotis/service/auth/firebase_auth_service.dart';
import 'package:agrotis/service/crop_service.dart';
import 'package:agrotis/service/fcm_service.dart';
import 'package:agrotis/service/tts_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:agrotis/app/router.gr.dart';

enum MenuAction { SIGN_OUT }

class HomeScreenViewModel extends BaseViewModel {
  final CropService _cropService = locator<CropService>();
  final FcmService _fcmService = locator<FcmService>();
  final FirebaseAuthService _firebaseAuthService =
      locator<FirebaseAuthService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final TtsService _ttsService = locator<TtsService>();

  String title = "Agrotis";

  initFcm() async {
    _ttsService.play("വിശദാംശങ്ങൾ കാണുന്നതിന് ക്രോപ്പ് തിരഞ്ഞെടുക്കുക");
    await _fcmService.initialise();
    // FirebaseMessaging messaging = FirebaseMessaging();
    // String token = await messaging.getToken();
    // print(token);
  }

  void popUpAction(MenuAction action) {
    switch (action) {
      case MenuAction.SIGN_OUT:
        _firebaseAuthService.signOut();
        _navigationService.replaceWith(Routes.loginScreenView);
        break;
    }
  }

  void findCrop(){
    _navigationService.navigateTo(Routes.cropFinderView);
  }
}
