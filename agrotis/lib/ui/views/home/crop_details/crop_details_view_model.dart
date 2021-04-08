import 'package:agrotis/app/locator.dart';
import 'package:agrotis/models/crop.dart';
import 'package:agrotis/models/crop_request.dart';
import 'package:agrotis/models/crop_suggestion_response.dart';
import 'package:agrotis/service/auth/auth_service.dart';
import 'package:agrotis/service/auth/firebase_auth_service.dart';
import 'package:agrotis/service/crop_service.dart';
import 'package:stacked/stacked.dart';

class CropDetailsViewModel extends FutureViewModel {
  final CropService _cropService = locator<CropService>();
  final FirebaseAuthService _firebaseAuthService =
      locator<FirebaseAuthService>();
  Crop get currentCrop => _cropService.currentCrop;

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

  @override
  Future futureToRun() => getData();

  CropSuggestionResponse cropData=CropSuggestionResponse();

  Future<void> getData() async {
    var user = await _firebaseAuthService.currentUser();
    CropRequest reqData =
        CropRequest(id: user.phone.substring(3), crop: _cropService.currentCrop.name);
    var response = await _cropService.getCropSuggestion(reqData);
    if (response != null) {
      cropData = response;
    }
  }
}
