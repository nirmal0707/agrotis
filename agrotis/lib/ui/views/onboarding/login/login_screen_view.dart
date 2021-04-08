import 'package:agrotis/app/localization/app_localization.dart';
import 'package:agrotis/service/auth/auth_service.dart';
import 'package:agrotis/ui/language_selector/language_selector_view.dart';
import 'package:agrotis/ui/media/text_styles.dart';
import 'package:agrotis/ui/widgets/button/text_button1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:stacked/stacked.dart';
import 'package:timer_count_down/timer_count_down.dart';

import 'login_screen_view_model.dart';

class LoginScreenView extends StatelessWidget {
  const LoginScreenView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginScreenViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: SafeArea(
          child: _Body(),
        ),
      ),
      viewModelBuilder: () => LoginScreenViewModel(),
    );
  }
}

class _Body extends ViewModelWidget<LoginScreenViewModel> {
  const _Body({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, LoginScreenViewModel model) {
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: Column(
        children: [
          SizedBox(
            height: 20.h,
          ),
          Text(
            AppLocalizations.of(context).translate('login'),
            style: AppTextStyles.s3(),
            textAlign: TextAlign.center,
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _LoginView(),
                  LanguageSelectorView(),
                ],
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: AppTextButton(
                  title: model.getButtonText(),
                  onPressed: () => model.buttonAction(context),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _LoginView extends ViewModelWidget<LoginScreenViewModel> {
  const _LoginView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, LoginScreenViewModel model) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _MobileInput(),
        SizedBox(
          height: 50.h,
        ),
        Text(
          AppLocalizations.of(context).translate('l13'),
          style: AppTextStyles.s1(),
        ),
        SizedBox(
          height: 20.h,
        ),
        Text(
          model.getStatusText(),
          style: AppTextStyles.s0(),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 50.h,
        ),
        model.currentStep != PhoneAuthenticationSteps.INIT &&
                model.currentStep !=
                    PhoneAuthenticationSteps.AUTHENTICATION_SUCCESS
            ? _OtpInput()
            : SizedBox(
                height: 100.h,
                child: model.isBusy
                    ? Center(child: CircularProgressIndicator())
                    : Container(),
              ),
        SizedBox(
          height: 50.h,
        ),
      ],
    );
  }
}

class _MobileInput extends ViewModelWidget<LoginScreenViewModel> {
  const _MobileInput({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, LoginScreenViewModel model) {
    return Container(
      child: InternationalPhoneNumberInput(
        countries: ["IN"],
        onInputChanged: (PhoneNumber number) {
          model.phoneNumber = number.phoneNumber.substring(3);
        },
        onInputValidated: (bool value) {
          model.isMobileNoValid = value;
        },
        inputDecoration: new InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).focusColor),
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).focusColor),
          ),
          fillColor: Colors.transparent,
          filled: true,
        ),
        ignoreBlank: true,
        selectorTextStyle: AppTextStyles.s1(),
        textStyle: AppTextStyles.s1(),
      ),
    );
  }
}

class _OtpInput extends ViewModelWidget<LoginScreenViewModel> {
  const _OtpInput({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, LoginScreenViewModel model) {
    return Column(
      children: [
        PinCodeTextField(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          length: 6,
          keyboardType: TextInputType.number,
          animationType: AnimationType.fade,
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.underline,
            inactiveColor: Theme.of(context).focusColor,
            activeColor: Theme.of(context).focusColor,
            activeFillColor: Colors.transparent,
            inactiveFillColor: Colors.transparent,
            selectedFillColor: Colors.transparent,
            selectedColor: Theme.of(context).focusColor,
            borderRadius: BorderRadius.circular(5),
          ),
          cursorColor: Theme.of(context).focusColor,
          animationDuration: Duration(milliseconds: 300),
          backgroundColor: Colors.transparent,
          textStyle: AppTextStyles.s1(),
          enableActiveFill: true,
          onCompleted: (otp) {
            print("Completed");
            model.validateOtp(otp);
          },
          enablePinAutofill: true,
          onChanged: (value) {
            print(value);
          },
          beforeTextPaste: (text) {
            print("Allowing to paste $text");
            //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
            //but you can show anything you want here, like your pop up saying wrong paste format or etc
            return true;
          },
          appContext: context,
        ),
        !model.isTimeout
            ? Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 20.w),
                  Countdown(
                    build: (context, time) {
                      return Text(
                        model.getFormattedTime(time),
                        style: AppTextStyles.s0(),
                      );
                    },
                    seconds: Duration(minutes: 1).inSeconds,
                    onFinished: () {
                      model.isTimeout = true;
                    },
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () => model.validatePhone(),
                    child: Text(
                      "Didn't get the OTP? Resend",
                      style: AppTextStyles.s0(),
                    ),
                  ),
                  SizedBox(width: 20.w),
                ],
              ),
      ],
    );
  }
}
