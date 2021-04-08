import 'package:agrotis/service/localization/localization_service.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';

enum TtsState { playing, stopped, paused, continued }

@lazySingleton
class TtsService with ReactiveServiceMixin {
  FlutterTts flutterTts;
  TtsState ttsState;

  Future<void> initTts() async {
    flutterTts = FlutterTts();

    await setLang();

    await flutterTts.setSpeechRate(0.5);

    flutterTts.setStartHandler(() {
      print("playing");
      notifyListeners();
      ttsState = TtsState.playing;
    });
    flutterTts.setCompletionHandler(() {
      print("Complete");
      notifyListeners();
      ttsState = TtsState.stopped;
    });
    flutterTts.setErrorHandler((msg) {
      print("error: $msg");
      ttsState = TtsState.stopped;
      notifyListeners();
    });
  }

  Future<void> setLang() async {
    // if (type == LanguageType.MALAYALAM)
      await flutterTts.setLanguage("ml-IN");
    // else
    //   await flutterTts.setLanguage("en-US");
  }

  Future<void> play(String text) async {
    flutterTts?.stop();
    var result = await flutterTts.speak(text);
    if (result == 1) {
      ttsState = TtsState.playing;
      notifyListeners();
    }
  }

  Future<void> stop() async {
    await flutterTts.stop();
  }
}
