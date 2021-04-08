import 'package:agrotis/service/localization/localization_service.dart';
import 'package:agrotis/ui/language_selector/language_selector_view_model.dart';
import 'package:agrotis/ui/media/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LanguageSelectorView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LanguageSelectorViewModel>.reactive(
      builder: (context, model, child) => _Body(),
      viewModelBuilder: () => LanguageSelectorViewModel(),
    );
  }
}

class _Body extends ViewModelWidget<LanguageSelectorViewModel> {
  @override
  Widget build(BuildContext context, LanguageSelectorViewModel model) {
    return Padding(
      padding: EdgeInsets.all(12.0.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _SelectionButton(
              title: "English",
              onTap: () => model.changeLanguage(LanguageType.ENGLISH),
              selected: model.currentLanguageType == LanguageType.ENGLISH),
          // SizedBox(width: 50.w),
          _SelectionButton(
              title: "മലയാളം",
              onTap: () => model.changeLanguage(LanguageType.MALAYALAM),
              selected: model.currentLanguageType == LanguageType.MALAYALAM)
        ],
      ),
    );
  }
}

class _SelectionButton extends StatelessWidget {
  final String title;
  final Function onTap;
  final bool selected;

  _SelectionButton(
      {Key key,
      @required this.title,
      @required this.onTap,
      @required this.selected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20.w),
      child: Ink(
        width: 200.w,
        height: 60.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.w),
            color: selected ? Colors.green : Colors.white,
            boxShadow: [BoxShadow(offset: Offset(2.w, 2.w))]),
        child: Center(
          child: Text(
            title,
            style: AppTextStyles.s3(
              color: selected ? Colors.white : Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
