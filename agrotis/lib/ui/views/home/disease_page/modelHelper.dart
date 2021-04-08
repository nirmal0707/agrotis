import 'dart:async';
import 'dart:io';
import 'package:agrotis/ui/media/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';

import 'cure.dart';

class DiseasePredictor extends StatefulWidget {
  @override
  _DiseasePredictorState createState() => new _DiseasePredictorState();
}

class _DiseasePredictorState extends State<DiseasePredictor> {
  File _image;
  List _recognitions;
  String diseaseName = "";
  bool _busy = false;

  Future _showDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Make a choice! "),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text("Gallery "),
                    onTap: () {
                      predictImagePickerGallery(context);
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                  GestureDetector(
                    child: Text("Camera "),
                    onTap: () {
                      predictImagePickerCamera(context);
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  Future<void> predictImagePickerGallery(BuildContext context) async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    setState(() {
      _busy = true;
      _image = image;
    });
    Navigator.of(context).pop();
    recognizeImage(image);
  }

  Future<void> predictImagePickerCamera(BuildContext context) async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    if (image == null) return;
    setState(() {
      _busy = true;
      _image = image;
    });
    Navigator.of(context).pop();
    recognizeImage(image);
  }

  @override
  void initState() {
    super.initState();

    _busy = true;

    loadModel().then((val) {
      setState(() {
        _busy = false;
      });
    });
  }

  Future loadModel() async {
    try {
      await Tflite.loadModel(
        model: "assets/ml_models/Tanmay_final_model.tflite",
        labels: "assets/ml_models/Labels.txt",
      );
    } on PlatformException {
      print('Failed to load model.');
    }
  }

  Future recognizeImage(File image) async {
    var recognitions = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 6,
      threshold: 0.05,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _busy = false;
      _recognitions = recognitions;
    });
  }

  handleCure() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => Cure(diseaseName),
    ));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<Widget> stackChildren = [];

    stackChildren.add(Positioned(
      top: 0.0,
      left: 0.0,
      width: size.width,
      child: _image == null
          ? Center(
              child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('No image selected.'),
            ))
          : Image.file(_image),
    ));

    stackChildren.add(Center(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: _recognitions != null
              ? _recognitions.map((res) {
                  diseaseName = res['label'];
                  return Card(
                    child: Text(
                      "${res["index"]} - ${res["label"]}",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        background: Paint()..color = Colors.white,
                      ),
                    ),
                  );
                }).toList()
              : [],
        ),
      ),
    ));

    if (_image != null) {
      stackChildren.add(Positioned(
        bottom: 100.0,
        left: 80.0,
//        width: size.width,
        child: RaisedButton(
          onPressed: handleCure,
          padding: EdgeInsets.symmetric(horizontal: 100),
          child: Text(
            'Cure',
            style: AppTextStyles.s3(color: Colors.white),
          ),
          color: Colors.green,
        ),
      ));
    }

    if (_busy) {
      stackChildren.add(const Opacity(
        child: ModalBarrier(dismissible: false, color: Colors.grey),
        opacity: 0.3,
      ));
      stackChildren.add(const Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Plant Disease Recognition'),
      ),
      body: Stack(
        children: stackChildren,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          _showDialog(context);
        },
        tooltip: 'Pick Image',
        child: Icon(Icons.camera),
      ),
    );
  }
}
