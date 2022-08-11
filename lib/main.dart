import 'package:flutter/material.dart';
import 'package:pocket_diagnoser/predModel.dart';
import './ImgClassification.dart';
import './BreastCancerMammograph.dart';
import './BrainTumorScan.dart';
import './AlzhimersScan.dart';
import './ParkinsonDisease.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/' : (context) => PredModel() ,
        '/ImageClassification': (context) => ImageClassificationPage(),
        '/MammographClassification': (context) => MammographClassification(),
        '/BrainTumor' : (context) => BrainTumorScan(),
        '/AlzhimersScan' : (context) => AlzhimersScan(),
        '/Parkinson' : (context) => Parkinson(),
      },
    );
  }
}