import 'package:agrotis/app/locator.dart';
import 'package:agrotis/service/tts_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:agrotis/app/router.gr.dart';

class DiseaseAnalyserViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final TtsService _ttsService = locator<TtsService>();


  void onSelect() {
    _navigationService.navigateTo(Routes.diseasePredictor);
    _ttsService.play("നിങ്ങളുടെ പ്ലാന്റ് സ്കാൻ ചെയ്യാൻ താഴെയുള്ള ബട്ടൺ ക്ലിക്കുചെയ്യുക");
  }
}
