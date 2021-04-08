import 'package:agrotis/ui/media/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'crop_selection_view_model.dart';
import 'package:agrotis/app/localization/app_localization.dart';

class CropSelectionView extends StatelessWidget {
  const CropSelectionView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CropSelectionViewModel>.reactive(
      builder: (context, model, child) => _Body(),
      viewModelBuilder: () => CropSelectionViewModel(),
    );
  }
}

class _Body extends ViewModelWidget<CropSelectionViewModel> {
  const _Body({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, CropSelectionViewModel model) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20.w),
        Padding(
          padding: EdgeInsets.all(10.w),
          child: Text(
            "- ${AppLocalizations.of(context).translate('c1')} -",
            style: AppTextStyles.s2(),
          ),
        ),
        Container(
          height: 250.w,
          child: ListView.builder(
              shrinkWrap: true,
              primary: false,
              scrollDirection: Axis.horizontal,
              itemCount: model.crops.length,
              itemBuilder: (_, index) {
                var item = model.crops[index];
                return Ink(
                  padding:
                      EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.w),
                  height: 220.w,
                  width: 180.w,
                  child: InkWell(
                    splashColor: Colors.green[400],
                    onTap: () => model.onCropSelect(item),
                    child: Card(
                      shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(50.w)),
                      child: Padding(
                        padding: EdgeInsets.all(8.w),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Image.asset(item.imgPath),
                            ),
                            Text(
                              item.name,
                              style: AppTextStyles.s3(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
        ),
      ],
    );
  }
}
