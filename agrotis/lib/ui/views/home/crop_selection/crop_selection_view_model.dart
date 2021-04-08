import 'package:agrotis/app/locator.dart';
import 'package:agrotis/app/router.gr.dart';
import 'package:agrotis/models/crop.dart';
import 'package:agrotis/service/crop_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class CropSelectionViewModel extends ReactiveViewModel {
  final CropService _cropService = locator<CropService>();
  final NavigationService _navigationService = locator<NavigationService>();

  List<Crop> get crops => _cropService.availableCrops;

  void onCropSelect(Crop item) {
    _cropService.selectCrop(item);
    _navigationService.navigateTo(Routes.cropDetailsView);
  }

  @override
  void addListener(void Function() listener) {
    _cropService.addListener(listener);
    super.addListener(listener);
  }

  @override
  void removeListener(void Function() listener) {
    _cropService.removeListener(listener);
    super.removeListener(listener);
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_cropService];
}
