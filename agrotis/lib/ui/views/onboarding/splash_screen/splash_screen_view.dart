import 'package:agrotis/ui/media/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';

import 'splash_screen_view_model.dart';

class SplashScreenView extends StatelessWidget {
  const SplashScreenView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(750, 1334), allowFontScaling: false);
    return ViewModelBuilder<SplashScreenViewModel>.reactive(
      onModelReady: (model) => model.initState(),
      builder: (context, model, child) => Scaffold(
        body: _Body(),
      ),
      viewModelBuilder: () => SplashScreenViewModel(),
    );
  }
}

class _Body extends ViewModelWidget<SplashScreenViewModel> {
  const _Body({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, SplashScreenViewModel model) {
    return Center(
      child: Image.asset(AppAssets.agrotis)
    );
  }
}
