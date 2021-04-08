import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';
import 'package:tflite/tflite.dart';

class DiseasePageViewModel extends BaseViewModel {
  // String url =
  //     "https://storage.googleapis.com/tfhub-visualizers/visualizers/vision/index.html?modelMetadataUrl=https%3A%2F%2Fstorage.googleapis.com%2Ftfhub-visualizers%2Fagripredict%2Fdisease-classification%2F1%2Fmetadata.json&publisherName=AgriPredict&publisherThumbnailUrl=https%3A%2F%2Fagripredict-tfub.s3.amazonaws.com%2Fimages%2Fagripredict-v2.png";

  File image;
  List recognitions;
  String diseaseName = "";

  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      loadModel();
    });
  }

  Future loadModel() async {
    setBusy(true);
    Tflite?.close();
    try {
      await Tflite.loadModel(
        model: "assets/ml_models/Tanmay_final_model.tflite",
        labels: "assets/ml_models/Labels.txt",
      );
    } on PlatformException {
      print('Failed to load model.');
    }
    setBusy(false);
  }

  Future<void> predictImagePickerGallery(BuildContext context) async {
    var img = await ImagePicker().getImage(source: ImageSource.gallery);
    if (img == null) return;
    image = File(img.path);
    setBusy(true);
    Navigator.of(context).pop();
    recognizeImage(img.path);
  }

  Future<void> predictImagePickerCamera(BuildContext context) async {
    var img = await ImagePicker().getImage(source: ImageSource.camera);
    if (img == null) return;
    image = File(img.path);
    setBusy(true);
    Navigator.of(context).pop();
    recognizeImage(img.path);
  }

  Future recognizeImage(String path) async {
    print("hello");
    var recgnts = await Tflite.runModelOnImage(
      path: path,
      numResults: 6,
      threshold: 0.05,
      imageMean: 127.5,
      imageStd: 127.5,
    );

    recognitions = recgnts;
    setBusy(false);
  }
}
