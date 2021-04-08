import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import 'auth_service.dart';

@lazySingleton
class FirebaseAuthService implements AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  PhoneAuthenticationSteps _currentStep = PhoneAuthenticationSteps.INIT;
  String phoneVerificationId;

  AuthUser _userFromFirebase(auth.User user) {
    if (user == null) {
      return null;
    }
    return AuthUser(
        uid: user.uid,
        email: user.email,
        displayName: user.displayName,
        photoUrl: user.photoURL,
        phone: user.phoneNumber);
  }

  FirebaseAuth get firebaseAuth => _firebaseAuth;

  @override
  Future<AuthUser> currentUser() {
    return Future.value(_userFromFirebase(_firebaseAuth.currentUser));
  }

  @override
  void dispose() {
    _phoneAuthController.close();
  }

  @override
  Stream<AuthUser> get onAuthStateChanged =>
      _firebaseAuth.authStateChanges().map(_userFromFirebase);

  @override
  Future<void> signOut() {
    return _firebaseAuth.signOut();
  }

  @override
  Future<AuthUser> signInWithPhone(String phone) async {
    _currentStep = PhoneAuthenticationSteps.CODE_SENT;
    _updatePhoneAuthStep();
    await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: "+91" + phone,
        timeout: Duration(seconds: 60),
        verificationCompleted: _phoneVerificationCompleted,
        verificationFailed: _phoneVerificationFailed,
        codeSent: _phoneCodeSent,
        codeAutoRetrievalTimeout: _phoneCodeAutoRetrievalTimeout);
    print("Phone Authentication Ended");
    return null;
  }

  void _phoneCodeSent(String verificationId, [int forceResendingToken]) async {
    phoneVerificationId = verificationId;
    _currentStep = PhoneAuthenticationSteps.CODE_SENT;
    _updatePhoneAuthStep();
  }

  void _phoneVerificationCompleted(PhoneAuthCredential phoneAuthCredential) {
    _currentStep = PhoneAuthenticationSteps.AUTO_RETRIEVING_CODE;
    _updatePhoneAuthStep();
    _signInWithCred(phoneAuthCredential);
  }

  void _phoneVerificationFailed(auth.FirebaseAuthException error) {
    var statusMessage = '${error.message}';
    if (statusMessage.contains('Network')) {
      _currentStep = PhoneAuthenticationSteps.AUTHENTICATION_FAILED_NETWWORK;
    } else {
      _currentStep = PhoneAuthenticationSteps.AUTHENTICATION_FAILED;
    }
    _updatePhoneAuthStep();
  }

  void _phoneCodeAutoRetrievalTimeout(String verificationId) {
    phoneVerificationId = verificationId;
    _currentStep = PhoneAuthenticationSteps.AUTO_RETRIVAL_TIMEOUT;
    _updatePhoneAuthStep();
  }

  void _updatePhoneAuthStep() {
    _phoneAuthController.add(_currentStep);
  }

  StreamController<PhoneAuthenticationSteps> _phoneAuthController =
      StreamController<PhoneAuthenticationSteps>.broadcast(sync: true);

  @override
  Stream<PhoneAuthenticationSteps> get onPhoneAuthenticationStepChanged =>
      _phoneAuthController.stream;

  @override
  Future<AuthUser> validatePhoneOtp(String otp) {
    _currentStep = PhoneAuthenticationSteps.CODE_SENT;
    _updatePhoneAuthStep();
    AuthCredential auth = PhoneAuthProvider.credential(
        verificationId: this.phoneVerificationId, smsCode: otp);
    return _signInWithCred(auth);
  }

  Future<AuthUser> _signInWithCred(auth.AuthCredential auth) async {
    UserCredential creds;
    try {
      creds = await _firebaseAuth.signInWithCredential(auth);
      if (creds?.user != null) {
        _currentStep = PhoneAuthenticationSteps.AUTHENTICATION_SUCCESS;
      } else {
        _currentStep = PhoneAuthenticationSteps.AUTHENTICATION_FAILED;
      }
    } on FirebaseAuthException catch (e) {
      print(e);
      if (e.code == "invalid-verification-code") {
        _currentStep = PhoneAuthenticationSteps.INVALID_OTP_ENTERED;
      }
    }

    _updatePhoneAuthStep();
    return _userFromFirebase(creds.user);
  }
}
