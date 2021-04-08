import 'package:agrotis/app/locator.dart';
import 'package:agrotis/models/crop.dart';
import 'package:agrotis/service/crop_service.dart';
import 'package:stacked/stacked.dart';

class CropFinderViewModel extends FutureViewModel {
  final CropService _cropService = locator<CropService>();
  @override
  Future futureToRun() => loadCrop();

  Future<void> loadCrop() async {
    await Future.delayed(Duration(seconds: 5));
  }

  List<Crop> get crops => _cropService.availableCrops;
}
