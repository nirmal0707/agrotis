import 'package:agrotis/ui/language_selector/language_selector_view.dart';
import 'package:agrotis/ui/media/assets.dart';
import 'package:agrotis/ui/media/text_styles.dart';
import 'package:agrotis/ui/views/home/disease_analyser/disease_analyser_view.dart';
import 'package:agrotis/ui/views/home/home_view_model.dart';
import 'package:agrotis/ui/widgets/button/text_button1.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:agrotis/app/localization/app_localization.dart';
import 'package:stacked/stacked.dart';

import 'crop_selection/crop_selection_view.dart';

class HomeScreenView extends StatelessWidget {
  const HomeScreenView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeScreenViewModel>.reactive(
      onModelReady: (model) => model.initFcm(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text(model.title),
          actions: [
            _PopUpMenu(
              model: model,
            )
          ],
        ),
        body: _Body(),
      ),
      viewModelBuilder: () => HomeScreenViewModel(),
    );
  }
}

class _Body extends ViewModelWidget<HomeScreenViewModel> {
  const _Body({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, HomeScreenViewModel model) {
    return SingleChildScrollView(
      primary: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CropSelectionView(),
          SizedBox(height: 30.w),
          DiseaseAnalyserView(),
          SizedBox(height: 30.w),
          _SuitablePlant(),
          SizedBox(height: 50.w),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "- ${AppLocalizations.of(context).translate('h5')} -",
                textAlign: TextAlign.center,
              ),
            ],
          ),
          SizedBox(height: 10.w),
          LanguageSelectorView(),
          SizedBox(height: 200.w),
        ],
      ),
    );
  }
}

class _PopUpMenu extends StatelessWidget {
  final HomeScreenViewModel model;
  const _PopUpMenu({
    Key key,
    this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<MenuAction>(
      onSelected: (MenuAction action) => model.popUpAction(action),
      itemBuilder: (BuildContext context) => <PopupMenuEntry<MenuAction>>[
        PopupMenuItem<MenuAction>(
          value: MenuAction.SIGN_OUT,
          child: Text(AppLocalizations.of(context).translate('h2')),
        ),
      ],
    );
  }
}

class _SuitablePlant extends ViewModelWidget<HomeScreenViewModel> {
  const _SuitablePlant({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, HomeScreenViewModel model) {
    return Card(
      shape:
          ContinuousRectangleBorder(borderRadius: BorderRadius.circular(50.w)),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  Image.asset(AppAssets.suitablePlant),
                ],
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              flex: 4,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context).translate('h3'),
                    style: AppTextStyles.s4(),
                  ),
                  SizedBox(height: 20.w),
                  Text(
                    AppLocalizations.of(context).translate('h4'),
                    style: AppTextStyles.s2(),
                  ),
                  SizedBox(height: 20.w),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      AppTextButton(
                        title: AppLocalizations.of(context).translate('h6'),
                        color: Colors.green,
                        textColor: Colors.white,
                        onPressed: () => model.findCrop(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:agrotis/ui/views/home/home_view_model.dart';
// import 'package:flutter/material.dart';
// import 'package:stacked/stacked.dart';

// class HomeScreenView extends StatelessWidget {
//   const HomeScreenView({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ViewModelBuilder<HomeScreenViewModel>.reactive(
//       builder: (context, model, child) => Scaffold(
//         body: _Body(),
//       ),
//       viewModelBuilder: () => HomeScreenViewModel(),
//     );
//   }
// }

// class _Body extends ViewModelWidget<HomeScreenViewModel> {
//   const _Body({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context, HomeScreenViewModel model) {
//     return Center(
//       child: Text(model.title),
//     );
//   }
// }
