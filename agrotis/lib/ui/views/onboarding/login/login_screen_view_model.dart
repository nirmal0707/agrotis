import 'package:agrotis/app/locator.dart';
import 'package:agrotis/app/router.gr.dart';
import 'package:agrotis/service/auth/auth_service.dart';
import 'package:agrotis/service/auth/firebase_auth_service.dart';
import 'package:agrotis/service/device_service.dart';
import 'package:agrotis/service/tts_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:agrotis/app/localization/app_localization.dart';

class LoginScreenViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final DeviceService _deviceService = locator<DeviceService>();
  final TtsService _ttsService = locator<TtsService>();

  bool _isMobileNoValid = false;

  String _statusText = "";

  String get statusText => _statusText;

  set statusText(String statusText) {
    _statusText = statusText;
    notifyListeners();
  }

  AuthService _authService = locator<FirebaseAuthService>();

  PhoneAuthenticationSteps _currentStep = PhoneAuthenticationSteps.INIT;

  bool _isTimeout = false;

  bool get isTimeout => _isTimeout;

  set isTimeout(bool isTimeout) {
    _isTimeout = isTimeout;
    notifyListeners();
  }

  PhoneAuthenticationSteps get currentStep => _currentStep;

  set currentStep(PhoneAuthenticationSteps currentStep) {
    _currentStep = currentStep;
    statusText = getStatusText();
    switch (_currentStep) {
      case PhoneAuthenticationSteps.AUTHENTICATION_SUCCESS:
        setBusy(false);
        authSucessAction();
        break;
      case PhoneAuthenticationSteps.AUTHENTICATION_FAILED:
      case PhoneAuthenticationSteps.AUTHENTICATION_FAILED_NETWWORK:
      case PhoneAuthenticationSteps.AUTO_RETRIVAL_TIMEOUT:
      case PhoneAuthenticationSteps.INVALID_OTP_ENTERED:
      case PhoneAuthenticationSteps.INIT:
        setBusy(false);
        break;
      case PhoneAuthenticationSteps.AUTO_RETRIEVING_CODE:
      case PhoneAuthenticationSteps.CODE_SENT:
        setBusy(false);
        break;
    }
    notifyListeners();
  }

  LoginScreenViewModel() {
    _ttsService.play("ലോഗിൻ ചെയ്യുന്നതിനുള്ള വിശദാംശങ്ങൾ നൽകുക");
    _authService.onPhoneAuthenticationStepChanged.listen((event) {
      if (currentStep == PhoneAuthenticationSteps.AUTHENTICATION_SUCCESS)
        return;
      if (currentStep == PhoneAuthenticationSteps.AUTO_RETRIEVING_CODE) {
        isTimeout = false;
        notifyListeners();
      }
      currentStep = event;
    });
  }

  String _phoneNumber;

  bool _isOtpRequested = false;

  bool get isOtpRequested => _isOtpRequested;

  set isOtpRequested(bool isOtpRequested) {
    _isOtpRequested = isOtpRequested;
    notifyListeners();
  }

  String get phoneNumber => _phoneNumber;

  set phoneNumber(String initialMobileValue) {
    _phoneNumber = initialMobileValue;
    notifyListeners();
  }

  bool get isMobileNoValid => _isMobileNoValid;

  set isMobileNoValid(bool isMobileNoValid) {
    _isMobileNoValid = isMobileNoValid;
    notifyListeners();
  }

  void validatePhone() {
    setBusy(true);
    _authService.signInWithPhone(phoneNumber);
  }

  void validateOtp(String otp) {
    print(otp);
    _authService.validatePhoneOtp(otp);
  }

  int getEndTime() {
    return DateTime.now().millisecondsSinceEpoch + 1000 * 60;
  }

  String getButtonText() {
    BuildContext context = _navigationService.navigatorKey.currentContext;

    switch (currentStep) {
      case PhoneAuthenticationSteps.INIT:
      case PhoneAuthenticationSteps.AUTO_RETRIVAL_TIMEOUT:
        return AppLocalizations.of(context).translate('l1');
      case PhoneAuthenticationSteps.AUTHENTICATION_FAILED:
      case PhoneAuthenticationSteps.AUTHENTICATION_FAILED_NETWWORK:
        return AppLocalizations.of(context).translate('l2');
      case PhoneAuthenticationSteps.AUTO_RETRIEVING_CODE:
      case PhoneAuthenticationSteps.INVALID_OTP_ENTERED:
      case PhoneAuthenticationSteps.CODE_SENT:
        return AppLocalizations.of(context).translate('l3');
      case PhoneAuthenticationSteps.AUTHENTICATION_SUCCESS:
        return AppLocalizations.of(context).translate('l4');
    }
    return AppLocalizations.of(context).translate('l4');
  }

  String getStatusText() {
    BuildContext context = _navigationService.navigatorKey.currentContext;
    switch (currentStep) {
      case PhoneAuthenticationSteps.INIT:
        return "";

      case PhoneAuthenticationSteps.AUTO_RETRIEVING_CODE:
        return AppLocalizations.of(context).translate('l5');
      case PhoneAuthenticationSteps.AUTHENTICATION_SUCCESS:
        return AppLocalizations.of(context).translate('l6');
      case PhoneAuthenticationSteps.AUTHENTICATION_FAILED:
        return AppLocalizations.of(context).translate('l7');
      case PhoneAuthenticationSteps.AUTHENTICATION_FAILED_NETWWORK:
        return AppLocalizations.of(context).translate('l8');
      case PhoneAuthenticationSteps.AUTO_RETRIVAL_TIMEOUT:
        return AppLocalizations.of(context).translate('l9');
      case PhoneAuthenticationSteps.INVALID_OTP_ENTERED:
        return AppLocalizations.of(context).translate('l10');
      case PhoneAuthenticationSteps.CODE_SENT:
        return "${AppLocalizations.of(context).translate('l11')} $phoneNumber ${AppLocalizations.of(context).translate('l12')}";
    }
    return "";
  }

  bool shouldEnableButton() {
    if (currentStep == PhoneAuthenticationSteps.CODE_SENT && isTimeout == true)
      return true;
    if (currentStep == PhoneAuthenticationSteps.INIT && isMobileNoValid == true)
      return true;
    if (currentStep == PhoneAuthenticationSteps.AUTHENTICATION_SUCCESS)
      return true;
    if (currentStep == PhoneAuthenticationSteps.AUTHENTICATION_FAILED ||
        currentStep == PhoneAuthenticationSteps.AUTHENTICATION_FAILED_NETWWORK)
      return true;
    return false;
  }

  Future<void> buttonAction(BuildContext context) async {
    if (shouldEnableButton() == false) return;
    if ((currentStep == PhoneAuthenticationSteps.CODE_SENT &&
            isTimeout == true) ||
        currentStep == PhoneAuthenticationSteps.INIT) {
      validatePhone();
    } else if (currentStep == PhoneAuthenticationSteps.AUTHENTICATION_FAILED ||
        currentStep ==
            PhoneAuthenticationSteps.AUTHENTICATION_FAILED_NETWWORK) {
      validatePhone();
    } else if (currentStep == PhoneAuthenticationSteps.AUTHENTICATION_SUCCESS) {
      authSucessAction();
    }
    return true;
  }

  void authSucessAction() async {
    await _deviceService.postToken(phoneNumber);
    _navigationService.replaceWith(Routes.homeScreenView);
  }

  String getFormattedTime(double time) {
    return formatTime(time);
  }

  String formatTime(double time) {
    Duration duration = Duration(seconds: time.round());
    return [duration.inMinutes, duration.inSeconds]
        .map((seg) => seg.remainder(60).toString().padLeft(2, '0'))
        .join(':');
  }
}
