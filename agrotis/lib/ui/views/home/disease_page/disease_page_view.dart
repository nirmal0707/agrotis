import 'package:agrotis/ui/views/home/disease_page/disease_page_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DiseasePageView extends StatelessWidget {
  const DiseasePageView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DiseasePageViewModel>.reactive(
      onModelReady: (model) => model.initState(),
      builder: (context, model, child) => Scaffold(
        body: SafeArea(
          child: _Body(),
        ),
        floatingActionButton: _PickImage(),
      ),
      viewModelBuilder: () => DiseasePageViewModel(),
    );
  }
}

class _Body extends ViewModelWidget<DiseasePageViewModel> {
  const _Body({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, DiseasePageViewModel model) {
    Size size = MediaQuery.of(context).size;
    List<Widget> stackChildren = [];

    stackChildren.add(Positioned(
      top: 0.0,
      left: 0.0,
      width: size.width,
      child: model.image == null ? Text('No image selected.') : Image.file(model.image),
    ));

    stackChildren.add(Center(
      child: Column(
        children: model.recognitions != null
            ? model.recognitions.map((res) {
                model.diseaseName = res['label'];
                return Text(
                  "${res["index"]} - ${res["label"]}",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    background: Paint()..color = Colors.white,
                  ),
                );
              }).toList()
            : [],
      ),
    ));

//     if (_image != null) {
//       stackChildren.add(Positioned(
//         bottom: 100.0,
//         left: 140.0,
// //        width: size.width,
//         child: RaisedButton(
//           onPressed: model.handleCure,
//           child: Text('Cure'),
//           color: Colors.blue,
//         ),
//       ));
//     }

    if (model.isBusy) {
      stackChildren.add(const Opacity(
        child: ModalBarrier(dismissible: false, color: Colors.grey),
        opacity: 0.3,
      ));
      stackChildren.add(const Center(child: CircularProgressIndicator()));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BackButton(),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: Stack(
              children: stackChildren,
            ),
          ),
        ),
      ],
    );
  }
}

// List<Widget> renderBoxes(Size screen, DiseasePageViewModel model) {
//   if (model.recognitions == null) return [];
//   if (model.imgWidth == null || model.imgHeight == null) return [];

//   double factorX = screen.width;
//   double factorY = model.imgHeight / model.imgHeight * screen.width;

//   return model.recognitions.map((re) {
//     return Positioned(
//       left: re["rect"]["x"] * factorX,
//       top: re["rect"]["y"] * factorY,
//       width: re["rect"]["w"] * factorX,
//       height: re["rect"]["h"] * factorY,
//       child: Container(
//         decoration: BoxDecoration(
//             border: Border.all(
//           color: Colors.red,
//           width: 3,
//         )),
//         child: Text(
//           "${re["detectedClass"]} ${(re["confidenceInClass"] * 100).toStringAsFixed(0)}%",
//           style: TextStyle(
//             background: Paint()..color = Colors.blue,
//             color: Colors.white,
//             fontSize: 15,
//           ),
//         ),
//       ),
//     );
//   }).toList();
// }

class _PickImage extends ViewModelWidget<DiseasePageViewModel> {
  const _PickImage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, DiseasePageViewModel model) {
    return FloatingActionButton(
      child: Icon(Icons.image),
      backgroundColor: Colors.red,
      tooltip: "Pick an Image",
      onPressed: () => _showDialog(context, model),
    );
  }
}

Future _showDialog(BuildContext context, DiseasePageViewModel model) async {
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
                    model.predictImagePickerGallery(context);
                  },
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                ),
                GestureDetector(
                  child: Text("Camera "),
                  onTap: () {
                    model.predictImagePickerCamera(context);
                  },
                )
              ],
            ),
          ),
        );
      });
}

// class _Body extends ViewModelWidget<DiseasePageViewModel> {
//   const _Body({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context, DiseasePageViewModel model) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         BackButton(),
//         Expanded(
//           child: Stack(
//             children: [
//               WebView(
//                 initialUrl: model.url,
//                 onPageStarted: (s) => model.setBusy(true),
//                 onPageFinished: (s) => model.setBusy(false),
//                 javascriptMode: JavascriptMode.unrestricted,

//               ),
//               Visibility(
//                 visible: model.isBusy,
//                 child: Scaffold(
//                   body: Center(
//                     child: CircularProgressIndicator(),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
