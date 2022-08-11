import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class MammographClassification extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return MammographClassificationState();
  }
}
class MammographClassificationState extends State<MammographClassification>{
  bool _loading = true;
  late File _image;
  var _output = null;
  final picker = ImagePicker();
  var confidenceDouble = 0.0;
  var confidenceRounding = "0.0%";
  var barColor = Colors.green;
  var classification;
  var result;

  @override
  void initState() {
    super.initState();
    loadModel().then((value) {
      setState(() {});
    });
  }

  classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
        path: image.path,
        numResults: 2,
        threshold: 0.5,
        imageMean: 127.6,
        imageStd: 127.5);
    setState(() {
      _output = output!;
      _loading = false;
      if(_output[0]['label'] == "0 Normal"){
        barColor = Colors.green;
        result = "Negative";
        classification = "";
      }
      if(_output[0]['label'] == "1 Benign"){
        barColor = Colors.red;
        result = "Positive";
        classification = "(Benign)";
      } else{
        barColor = Colors.red;
        result = "Positive";
        classification = "(Malignant)";
      }
      confidenceDouble = _output[0]['confidence'];
      confidenceRounding = "${(confidenceDouble*100.0).toStringAsFixed(1)}%";
    });
  }

  loadModel() async {
    await Tflite.loadModel(
        model: 'assets/BreastCancerMammographModel.tflite',
        labels: 'assets/BreastCancerMammographLabels.txt');
  }

  pickImage() async {
    var image = await picker.pickImage(source: ImageSource.camera);
    if (image == null) return null;
    setState(() {
      _image = File(image.path);
    });
    classifyImage(_image);
  }

  @override
  void dispose() {
    Tflite.close();
  }

  pickGalleryImage() async {
    var image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) return null;
    setState(() {
      _image = File(image.path);
    });
    classifyImage(_image);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Breast Cancer Diagnosis"),
      ),

      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          _loading ? const SizedBox() : Image.file(_image),

          const Padding(padding: EdgeInsets.all(12.0)),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              (_output != null) ? Center(child: Text(
                "Diagnosis Result : $result for Breast Cancer $classification", textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold),)) : const SizedBox(),
              // label -> gives the name, confidence -> gives the model's confidence

              const Padding(padding: EdgeInsets.all(12.0)),

              Visibility(
                  child: CircularPercentIndicator(
                    animation: true,
                    radius: 50.0,
                    percent: confidenceDouble,
                    center: Text(confidenceRounding),
                    footer: const Text("Confidence"),
                    progressColor: barColor,
                    circularStrokeCap: CircularStrokeCap.round,
                  ),
                visible: !(_loading),
              ),
            ],
          ),
        ],
      ),

      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: (){
              pickImage();
            },
            child: const Icon(Icons.camera),
          ),

          const Padding(padding: EdgeInsets.all(15.0)),

          FloatingActionButton(
            onPressed: (){
              pickGalleryImage();
            },
            child: const Icon(Icons.photo_album),
          )
        ],
      ),
    );
  }
  
}