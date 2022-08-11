import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Parkinson extends StatefulWidget {
  @override
  State<Parkinson> createState() => _ParkinsonState();
}

class _ParkinsonState extends State<Parkinson> {
  int _counter = 0;
  late var _pathToFile;
  late File _selectedAudio;
  var resJson;
  var localJitter, localabsoluteJitter, rapJitter, ppq5Jitter, localShimmer, localdbShimmer, apq3Shimmer, aqpq5Shimmer,apq11Shimmer, hnr05, hnr15, hnr25;
  var localJitterMax = 0.0392041585942167,localJitterMin = 0.0121499515950977, localabsoluteJitterMax = 0.000333369493821 , localabsoluteJitterMin = 0.000052819128760312576,
      rapJitterMax = 0.0192467218862682, rapJitterMin = 0.0048848272571992,
      ppq5JitterMax = 0.0194497361857341, ppq5JitterMin = 0.0051011065562702, localShimmerMax = 0.1548868995249582, localShimmerMin = 0.0560268214536197,
      localdbShimmerMax = 1.4144248720334518, localdbShimmerMin = 0.5689687592669774,
      apq3ShimmerMax = 0.057307776822486, apq3ShimmerMin = 0.0200570786598334, aqpq5ShimmerMax = 0.0846262034911827, aqpq5ShimmerMin = 0.0280832201685565,
      apq11ShimmerMax = 0.151126297149267, apq11ShimmerMin = 0.0477230953524613, hnr05Max = 12.113159625265675, hnr05Min = 0.3773129740483714,
      hnr15Max = 14.834480397801386,hnr15Min = -1.2592681083942068, hnr25Max = 17.213645808155242, hnr25Min = 4.317880424163253;
  var predValueParkinson, predValueNumParkinson;
  Color parkinsonColor = Colors.green;

  double featureScale(input, max, min){
    return (input - min)/(max - min);
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  Future<void> _predictParkinson() async {
    final interpreterParkinson = await Interpreter.fromAsset('Parkinson.tflite');

    localJitter = featureScale(resJson['localJitter'], localJitterMax, localJitterMin);
    localabsoluteJitter = featureScale(resJson['localabsoluteJitter'], localabsoluteJitterMax, localabsoluteJitterMin);
    rapJitter = featureScale(resJson['rapJitter'], rapJitterMax, rapJitterMin);
    ppq5Jitter = featureScale(resJson['ppq5Jitter'], ppq5JitterMax, ppq5JitterMin);
    localShimmer = featureScale(resJson['localShimmer'], localShimmerMax, localShimmerMin);
    localdbShimmer = featureScale(resJson['localdbShimmer'], localdbShimmerMax, localdbShimmerMin);
    apq3Shimmer = featureScale(resJson['apq3Shimmer'], apq3ShimmerMax, apq3ShimmerMin);
    aqpq5Shimmer = featureScale(resJson['aqpq5Shimmer'], aqpq5ShimmerMax, aqpq5ShimmerMin);
    apq11Shimmer = featureScale(resJson['apq11Shimmer'], apq11ShimmerMax, apq11ShimmerMin);
    hnr05 = featureScale(resJson['hnr05'], hnr05Max, hnr05Min);
    hnr15 = featureScale(resJson['hnr15'], hnr15Max, hnr15Min);
    hnr25 = featureScale(resJson['hnr25'], hnr25Max, hnr25Min);

    var inputParkinson = [
      [localJitter, localabsoluteJitter, rapJitter, ppq5Jitter, localShimmer, localdbShimmer, apq3Shimmer, aqpq5Shimmer, apq11Shimmer,hnr05,hnr15,hnr25]
    ];

    var outputParkinson = List.filled(1, 0).reshape([1, 1]);

    interpreterParkinson.run(inputParkinson, outputParkinson);

    setState(() {
      predValueParkinson = outputParkinson[0][0].toStringAsFixed(3);

      predValueNumParkinson = double.parse(predValueParkinson);

      predValueParkinson = "${(outputParkinson[0][0]*100.0).toStringAsFixed(1)}%";

      if(predValueNumParkinson < 0.20){
        parkinsonColor = Colors.green;
      }else
      if(predValueNumParkinson >= 0.20 && predValueNumParkinson < 0.40){
        parkinsonColor = Colors.yellow;
      }else
      if(predValueNumParkinson >= 0.40 && predValueNumParkinson < 0.65){
        parkinsonColor = Colors.orange;
      }else
      if(predValueNumParkinson >= 0.65){
        parkinsonColor = Colors.red;
      }
    });


  }

  void _getAudioFeatures() async{

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['wav'],
        );
        //final result = await FilePicker.platform.pickFiles(allowMultiple: true);
        //final file = result.files.first;
        if (result == null) return;
        String? path = result.files.single.path;
        _pathToFile = path;
        File file = File(_pathToFile);
        _selectedAudio = file ;
        var request = http.MultipartRequest(
          'POST',
          Uri.parse("http://manishmallapur.pythonanywhere.com/features"),
        );
        Map<String, String> headers = {"Content-type": "multipart/form-data"};
        request.files.add(
          http.MultipartFile(
            'audio',
            _selectedAudio.readAsBytes().asStream(),
            _selectedAudio.lengthSync(),
            filename: _selectedAudio.path.split('/').last,
          ),
        );
        request.headers.addAll(headers);
        print("request: " + request.toString());
        var res = await request.send();
        var reason = res.reasonPhrase;
        http.Response response = await http.Response.fromStream(res);
        setState(() {
          resJson = jsonDecode(response.body);
          Fluttertoast.showToast(
            msg: resJson['message'],
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
          );
        });
        _predictParkinson();
      }
    } on SocketException catch (_) {
      print('not connected');
      Fluttertoast.showToast(
        msg: "Please Connect to the Internet and try again",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text("Parkinson Disease Diagnosis"),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //(resJson != null && resJson['message'] == "Success!") ? Text("Diagnosis Result : ${resJson['result']} for Parkinson's Disease",textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold),) : const Text("Upload Audio File (.wav format only)")
            (resJson != null && resJson['message'] == "Success!") ? Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,children: [
              CircularPercentIndicator(
                animation: true,
                radius: 50.0,
                percent: (predValueNumParkinson),
                center: Text(predValueParkinson),
                footer: const Text("Parkinson's Disease"),
                progressColor: parkinsonColor,
                circularStrokeCap: CircularStrokeCap.round,
              ),
            ],) : const Text("Upload Audio File (.wav format only)")
            // Text(
            //   '$_counter',
            //   style: Theme.of(context).textTheme.headline4,
            // ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getAudioFeatures,
        tooltip: 'Increment',
        child: const Icon(Icons.audiotrack_outlined),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
