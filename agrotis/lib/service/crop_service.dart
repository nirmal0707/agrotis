import 'package:agrotis/models/crop.dart';
import 'package:agrotis/models/crop_request.dart';
import 'package:agrotis/models/crop_suggestion_response.dart';
import 'package:agrotis/service/network/api_service.dart';
import 'package:agrotis/ui/media/assets.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';

@lazySingleton
class CropService with ReactiveServiceMixin {
  ApiService api;

  CropService(this.api);
  List<Crop> availableCrops = List<Crop>();
  Crop currentCrop;

  void initialiseCrops() {
    for (var item in cropList) {
      var crop = Crop.fromJson(item);
      availableCrops.add(crop);
    }
  }

  void selectCrop(Crop crop) {
    currentCrop = crop;
    notifyListeners();
  }

  Future<CropSuggestionResponse> getCropSuggestion(CropRequest reqData) async {
    var jsonRes = await api.post("postDeviceId", data: reqData.toJson());
    if (jsonRes != null) {
      var response = CropSuggestionResponse.fromJson(jsonRes);
      return response;
    } else {
      return null;
    }
  }
}

const List<Map<String, dynamic>> cropList = [
  {"name": "Potato", "imgPath": AppAssets.potato},
  {"name": "Tomato", "imgPath": AppAssets.tomato},
  {"name": "Corn", "imgPath": AppAssets.corn},
  {"name": "Paddy", "imgPath": AppAssets.paddy},
  {"name": "Pepper", "imgPath": AppAssets.pepper},
];
