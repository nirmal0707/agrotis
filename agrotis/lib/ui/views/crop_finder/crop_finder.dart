import 'package:agrotis/ui/media/text_styles.dart';
import 'package:agrotis/ui/views/crop_finder/crop_finder_view_model.dart';
import 'package:agrotis/ui/views/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class CropFinderView extends StatelessWidget {
  const CropFinderView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CropFinderViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: SafeArea(
          child: _Body(),
        ),
      ),
      viewModelBuilder: () => CropFinderViewModel(),
    );
  }
}

class _Body extends ViewModelWidget<CropFinderViewModel> {
  const _Body({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, CropFinderViewModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            BackButton(),
            Text(
              "Suitable Crop Finder",
              style: AppTextStyles.s4(),
            ),
          ],
        ),
        Expanded(
          child: Center(
            child: model.isBusy
                ? Scaffold(body: Center(child: CircularProgressIndicator()))
                : Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "1. ",
                              style: AppTextStyles.s4(),
                            ),
                            SizedBox(width: 20),
                            Column(
                              children: [
                                Image.asset(
                                  model.crops[3].imgPath,
                                  width: 150,
                                  height: 150,
                                ),
                                 Text(
                              model.crops[3].name,
                              style: AppTextStyles.s3(),
                            ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 80),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "2. ",
                              style: AppTextStyles.s4(),
                            ),
                            SizedBox(width: 20),
                            Column(
                              children: [
                                Image.asset(
                                  model.crops[1].imgPath,
                                  width: 120,
                                  height: 120,
                                ),
                                 Text(
                              model.crops[1].name,
                              style: AppTextStyles.s3(),
                            ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 80),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "3. ",
                              style: AppTextStyles.s4(),
                            ),
                            SizedBox(width: 20),
                            Column(
                              children: [
                                Image.asset(
                                  model.crops[4].imgPath,
                                  width: 100,
                                  height: 100,
                                ),
                                 Text(
                              model.crops[4].name,
                              style: AppTextStyles.s3(),
                            ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
