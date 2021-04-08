import 'package:agrotis/ui/media/assets.dart';
import 'package:agrotis/ui/media/text_styles.dart';
import 'package:agrotis/ui/views/home/disease_analyser/dsease_analyser_view_model.dart';
import 'package:agrotis/ui/widgets/button/text_button1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';
import 'package:agrotis/app/localization/app_localization.dart';

class DiseaseAnalyserView extends StatelessWidget {
  const DiseaseAnalyserView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DiseaseAnalyserViewModel>.reactive(
      builder: (context, model, child) => _Body(),
      viewModelBuilder: () => DiseaseAnalyserViewModel(),
    );
  }
}

class _Body extends ViewModelWidget<DiseaseAnalyserViewModel> {
  const _Body({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, DiseaseAnalyserViewModel model) {
    return Card(
      shape:
          ContinuousRectangleBorder(borderRadius: BorderRadius.circular(50.w)),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context).translate('a1'),
                    style: AppTextStyles.s4(),
                  ),
                  SizedBox(height: 20.w),
                  Text(
                    AppLocalizations.of(context).translate('a2'),
                    style: AppTextStyles.s2(),
                  ),
                  SizedBox(height: 20.w),
                  AppTextButton(
                    title: AppLocalizations.of(context).translate('a3'),
                    color: Colors.green,
                    textColor: Colors.white,
                    onPressed: () => model.onSelect(),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  Image.asset(AppAssets.disease),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
