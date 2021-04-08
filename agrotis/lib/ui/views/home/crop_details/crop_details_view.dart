import 'package:agrotis/ui/media/assets.dart';
import 'package:agrotis/ui/media/text_styles.dart';
import 'package:agrotis/ui/views/home/crop_details/crop_details_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CropDetailsView extends StatelessWidget {
  const CropDetailsView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CropDetailsViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: SafeArea(
          child: _Body(),
        ),
      ),
      viewModelBuilder: () => CropDetailsViewModel(),
    );
  }
}

class _Body extends ViewModelWidget<CropDetailsViewModel> {
  const _Body({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, CropDetailsViewModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            BackButton(),
            Text(
              model.currentCrop.name,
              style: AppTextStyles.s4(),
            ),
          ],
        ),
        Expanded(
          child: model.isBusy
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Opacity(
                        opacity: 0.6,
                        child: Image.asset(AppAssets.bg),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Device Readings",
                            style: AppTextStyles.s3(),
                          ),
                          SizedBox(height: 10.w),
                          _IconSet(
                            path: AppAssets.humidity,
                            title:
                                "Humidity: ${model.cropData?.deviceValues?.humidity}",
                          ),
                          _IconSet(
                            path: AppAssets.light,
                            title:
                                "Light: ${model.cropData?.deviceValues?.light}",
                          ),
                          _IconSet(
                            path: AppAssets.moisture,
                            title:
                                "Moisture: ${model.cropData?.deviceValues?.moisture}",
                          ),
                          _IconSet(
                            path: AppAssets.temperature,
                            title:
                                "Temperature: ${model.cropData?.deviceValues?.temperature}",
                          ),
                          _IconSet(
                            path: AppAssets.ph,
                            title: "Ph: ${model.cropData?.deviceValues?.ph}",
                          ),
                          SizedBox(height: 30.w),
                          Text(
                            "Suggestions",
                            style: AppTextStyles.s3(),
                          ),
                          SizedBox(height: 10.w),
                          if( model.cropData?.suggestions!=null||false)
                          ListBody(
                            children: model.cropData?.suggestions
                                ?.map(
                                  (e) => Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "* ${e ?? ""}",
                                        style: AppTextStyles.s2(),
                                      ),
                                      SizedBox(height: 5.w),
                                    ],
                                  ),
                                )
                                ?.toList(),
                          ),
                          SizedBox(height: 30.w),
                          Text(
                            "Optimum Values",
                            style: AppTextStyles.s3(),
                          ),
                          SizedBox(height: 10.w),
                          _IconSet(
                            path: AppAssets.temperature,
                            title:
                                "Min temperature: ${model.cropData?.optimumValues?.minTemp}",
                          ),
                          _IconSet(
                            path: AppAssets.temperature,
                            title:
                                "Max temperature: ${model.cropData?.optimumValues?.maxTemp}",
                          ),
                          _IconSet(
                            path: AppAssets.temperature,
                            title:
                                "Adverse temperature: ${model.cropData?.optimumValues?.advTemp}",
                          ),
                          _IconSet(
                            path: AppAssets.ph,
                            title:
                                "Min ph: ${model.cropData?.optimumValues?.minPh}",
                          ),
                          _IconSet(
                            path: AppAssets.ph,
                            title:
                                "Max ph: ${model.cropData?.optimumValues?.maxPh}",
                          ),
                          SizedBox(height: 30.w),
                          // Text(
                          //   "Side Effects",
                          //   style: AppTextStyles.s3(),
                          // ),
                          // SizedBox(height: 10.w),
                          // Text(
                          //   "${model.cropData?.optimumValues?.sideEffect}",
                          //   style: AppTextStyles.s1(),
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ],
    );
  }
}

class _IconSet extends StatelessWidget {
  final String path;
  final String title;
  const _IconSet({Key key, this.path, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.w),
      child: Row(
        children: [
          Image.asset(
            path,
            width: 50.w,
            height: 50.w,
            fit: BoxFit.contain,
          ),
          SizedBox(width: 5.w),
          Text(
            title ?? "",
            style: AppTextStyles.s2(),
          ),
        ],
      ),
    );
  }
}
