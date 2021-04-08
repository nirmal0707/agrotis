import 'package:flutter/material.dart';

@immutable
class AuthUser {
  const AuthUser(
      {@required this.uid,
      this.email,
      this.photoUrl,
      this.displayName,
      this.phone});

  final String uid;
  final String email;
  final String photoUrl;
  final String displayName;
  final String phone;
}

enum PhoneAuthenticationSteps {
  INIT,
  AUTO_RETRIEVING_CODE,
  AUTHENTICATION_SUCCESS,
  AUTHENTICATION_FAILED,
  AUTHENTICATION_FAILED_NETWWORK,
  CODE_SENT,
  AUTO_RETRIVAL_TIMEOUT,
  INVALID_OTP_ENTERED
}

abstract class AuthService {
  Future<AuthUser> currentUser();
  Future<void> signInWithPhone(String phone);
  Future<AuthUser> validatePhoneOtp(String otp);

  Future<void> signOut();

  Stream<AuthUser> get onAuthStateChanged;

  Stream<PhoneAuthenticationSteps> get onPhoneAuthenticationStepChanged;

  void dispose();
}
