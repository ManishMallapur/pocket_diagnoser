//import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dots_indicator/dots_indicator.dart';

class PredModel extends StatefulWidget {
  @override
  _PredModelState createState() => _PredModelState();
}

class _PredModelState extends State<PredModel> {


  final TextEditingController _ageController = new TextEditingController();
  final TextEditingController _BMIController = new TextEditingController();
  final TextEditingController _cholesterolController = new TextEditingController();
  final TextEditingController _glucoseController = new TextEditingController();
  final TextEditingController _systoleController = new TextEditingController();
  final TextEditingController _diastoleController = new TextEditingController();
  final TextEditingController _CPKcontroller = new TextEditingController();
  final TextEditingController _ejectionFractionController = new TextEditingController();
  final TextEditingController _plateletsController = new TextEditingController();
  final TextEditingController _creatinineController = new TextEditingController();
  final TextEditingController _sodiumController = new TextEditingController();
  final TextEditingController _numCigsController = new TextEditingController();
  final TextEditingController _heartRateController = new TextEditingController();
  final TextEditingController _insulinControler = new TextEditingController();
  final TextEditingController _HOMAcontroller = new TextEditingController();
  final TextEditingController _leptinController = new TextEditingController();
  final TextEditingController _adiponectinController = new TextEditingController();
  final TextEditingController _resistinController = new TextEditingController();
  final TextEditingController _MCPController = new TextEditingController();

  var ageMax = 95.0, ageMin = 24.0, BMIMax = 56.8, BMIMin = 15.54, cholesterolMax = 600.0, cholesterolMin = 113.0, glucoseMax = 394.0, glucoseMin = 40.0;
  var systoleMax = 295.0, systoleMin = 83.5, diastoleMax = 142.5,diastoleMin = 48.0, CPKMax = 7861.0, CPKMin = 23.0, ejectionMax = 80.0, ejectionMin = 14.0, plateletsMax = 850000.0, plateletsMin = 25100.0;
  var creatinineMax = 9.4 , creatinineMin = 0.5, sodiumMax = 148.0, sodiumMin = 113.0, numCigsMax = 70.0, numCigsMin = 0.0, heartRateMax = 143.0, heartRateMin = 44.0, insulinMax = 58.46, insulinMin = 2.432;
  var HOMAMax = 25.05034187, HOMAMin = 0.467408667, leptinMax = 90.28, leptinMin = 4.311, adiponectinMax = 38.04, adiponectinMin = 1.65602, resistinMax = 82.1, resistinMin= 3.21, MCPMax = 1698.44, MCPMin = 45.843;


  bool firstPage = true;
  bool secondPage = false;
  bool thirdPage = false;
  bool fourthPage = false;
  bool fltBtnPrev = false;
  bool fltBtnNext = true;

  bool isCheckBreastCancer = false;
  bool isCheckHeartAttack = false;
  bool isCheckHeartFailure = false;

  double currentPageIndex = 0.0;


  String dropdownValueGender = 'Male';
  String dropDownValueAnemia = 'No';
  String dropDownValueDiabetes = 'No';
  String dropDownValueSmoking = 'No';
  String dropDownValueStroke = 'No';
  String dropDownValueHypertension = 'No';
  String dropDownValueBPMeds = 'No';
  String dropDownValueHighBP = 'No';

  String missingData = "";

  Color breastCancerColor = Colors.green;
  Color heartAttackColor = Colors.green;
  Color heartFailureColor = Colors.green;



  //var predValue = "";
  var predValueBreastCancer = "0.0%";
  var predValueHeartAttack = "0.0%";
  var predValueHeartFailure = "0.0%";
  var predValueNumBreastCancer = 0.0, predValueNumHeartAttack = 0.0, predValueNumHeartFailure = 0.0;

  var ageVar = 18.0, ageDefault = 18.0; // text field \\\\\
  var genderVar = 1.0, genderDefault = 1.0; // drop down (1- male, 0 - female) the rest -> (0 - no, 1 - yes)
  var BMIVar = 24.0, BMIDefault = 24.0; // text field \\\\\\
  var systoleVar = 122.0, systoleDefault = 122.0; // text field\\\\\
  var diastoleVar = 71.0, diastoleDefault = 71.0; // text field\\\\\
  var cholesterolVar = 185.0, cholesterolDefault = 185.0; // text field\\\\\
  var glucoseVar = 92.5, glucoseDefault = 92.5; // text field\\\\\\\
  var smokingVar = 0.0, smokingDefault = 0.0; // drop down
  var anemiaVar = 0.0, anemiaDefault = 0.0; // drop down
  var highBPVar = 0.0, highBPDefault = 0.0; // check using systole and diastole variables
  var CPKVar = 65.0, CPKDefault = 65.0; // text field\\\\\
  var ejectionFracVar = 63.0, ejectionFracDefault = 63.0; // text field\\\\\
  var plateletVar = 300000.0, plateletsDefault = 300000.0; // text field\\\\\
  var creatinineVar = 0.85, creatinineDefault = 0.85; // text field\\\\\
  var sodiumVar = 116.0, sodiumDefault = 116.0; // text field\\\\\
  var numCigarettesVar = 0.0, numCigsDefault = 0.0; // text field\\\\\\
  var strokeVar = 0.0, strokeDefault = 0.0; // drop down
  var hypertensionVar = 0.0, hypertensionDefault =0.0; // drop down
  var heartRateVar = 72.0, heartRateDefault = 72.0; // text field\\\\\
  var insulinVar = 9.0, insulinDefault = 9.0; // text field\\\\\
  var HOMAVar = 0.75, HOMADefault = 0.75; // text field\\\\\\
  var leptinVar = 9.0, leptinDefault = 9.0; // text field
  var adiponectinVar = 7.5, adiponectinDefault = 7.5; // text field
  var resistinVar = 7.07, resistinDefault = 7.07; // text field
  var MCPVar = 534.647, MCPDefault = 534.647; // text field
  var diabetesVar = 0.0, diabetesDefault = 0.0; // drop down
  var BPMedsVar = 0.0 , BPMedsDefault = 0.0;// drop Down

  double FeatureScale(input, max, min){
    return (input - min)/(max - min);
  }

  void visibilityController(){
    if(currentPageIndex == 0.0){
      setState(() {
        firstPage = true;
        secondPage = false;
        thirdPage = false;
        fourthPage = false;

        fltBtnPrev = false;
        fltBtnNext = true;
      });
    }else if(currentPageIndex == 1.0){
      firstPage = false;
      secondPage = true;
      thirdPage = false;
      fourthPage = false;

      fltBtnPrev = true;
      fltBtnNext = true;
    }else if(currentPageIndex == 2.0){
      firstPage = false;
      secondPage = false;
      thirdPage = true;
      fourthPage = false;

      fltBtnPrev = true;
      fltBtnNext = true;
    }else if(currentPageIndex == 3.0){
      firstPage = false;
      secondPage = false;
      thirdPage = false;
      fourthPage = true;

      fltBtnPrev = true;
      fltBtnNext = false;
    }
}


  @override
  void initState() {
    super.initState();
  }

  void fetchData(){
    if(double.tryParse(_ageController.text) == null){
      setState(() {
        missingData = "Please Enter Your Age";
        Fluttertoast.showToast(
            msg: missingData,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
        );
      });
    }else if(double.tryParse(_BMIController.text) == null){
      setState(() {
        missingData = "Please Enter Your BMI";
        Fluttertoast.showToast(
          msg: missingData,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      });
    }else if(double.tryParse(_numCigsController.text) == null){
      setState(() {
        missingData = "Please Enter the Number of Cigarettes Consumed per Day";
        Fluttertoast.showToast(
          msg: missingData,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      });
    }else if(double.tryParse(_heartRateController.text) == null){
      setState(() {
        missingData = "Please Enter Your Heart Rate";
        Fluttertoast.showToast(
          msg: missingData,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      });
    }else{
      setState(() {
        missingData = "";
        ageVar = double.parse(_ageController.text);
        BMIVar = double.parse(_BMIController.text);
        numCigarettesVar = double.parse(_numCigsController.text);
        heartRateVar = double.parse(_heartRateController.text);
        if(double.tryParse(_systoleController.text) == null){
          systoleVar = systoleDefault;
        }else{
          systoleVar = double.parse(_systoleController.text);
        }
        if(double.tryParse(_diastoleController.text) == null){
          diastoleVar = diastoleDefault;
        }else{
          diastoleVar = double.parse(_diastoleController.text);
        }
        if(double.tryParse(_cholesterolController.text) == null){
          cholesterolVar = cholesterolDefault;
        }else{
          cholesterolVar = double.parse(_cholesterolController.text);
        }
        if(double.tryParse(_glucoseController.text) == null){
          glucoseVar = glucoseDefault;
        }else{
          glucoseVar = double.parse(_glucoseController.text);
        }
        if(double.tryParse(_CPKcontroller.text) == null){
          CPKVar = CPKDefault;
        }else{
          CPKVar = double.parse(_CPKcontroller.text);
        }
        if(double.tryParse(_ejectionFractionController.text) == null){
          ejectionFracVar = ejectionFracDefault;
        }else{
          ejectionFracVar = double.parse(_ejectionFractionController.text);
        }
        if(double.tryParse(_plateletsController.text) == null){
          plateletVar = plateletsDefault;
        }else{
          plateletVar = double.parse(_plateletsController.text);
        }
        if(double.tryParse(_creatinineController.text) == null){
          creatinineVar = creatinineDefault;
        }else{
          creatinineVar = double.parse(_creatinineController.text);
        }
        if(double.tryParse(_sodiumController.text) == null){
          sodiumVar = sodiumDefault;
        }else{
          sodiumVar = double.parse(_sodiumController.text);
        }
        if(double.tryParse(_insulinControler.text) == null){
          insulinVar = insulinDefault;
        }else{
          insulinVar = double.parse(_insulinControler.text);
        }
        if(double.tryParse(_HOMAcontroller.text) == null){
          HOMAVar = HOMADefault;
        }else{
          HOMAVar = double.parse(_HOMAcontroller.text);
        }
        if(double.tryParse(_leptinController.text) == null){
          leptinVar = leptinDefault;
        }else{
          leptinVar = double.parse(_leptinController.text);
        }
        if(double.tryParse(_adiponectinController.text) == null){
          adiponectinVar = adiponectinDefault;
        }else{
          adiponectinVar = double.parse(_adiponectinController.text);
        }
        if(double.tryParse(_resistinController.text) == null){
          resistinVar = resistinDefault;
        }else{
          resistinVar = double.parse(_resistinController.text);
        }
        if(double.tryParse(_MCPController.text) == null){
          MCPVar = MCPDefault;
        }else{
          MCPVar = double.parse(_MCPController.text);
        }
      });
      predData();
    }
  }

  Future<void> predData() async {
    final interpreterBreastCancer = await Interpreter.fromAsset('BreastCancer.tflite');
    final interpreterHeartAttack = await Interpreter.fromAsset("HeartAttack.tflite") ;
    final interpreterHeartFailure = await Interpreter.fromAsset("HeartFailure.tflite");

    ageVar = FeatureScale(ageVar, ageMax, ageMin);
    BMIVar  = FeatureScale(BMIVar, BMIMax, BMIMin);
    glucoseVar = FeatureScale(glucoseVar, glucoseMax, glucoseMin);
    insulinVar = FeatureScale(insulinVar, insulinMax, insulinMin);
    HOMAVar = FeatureScale(HOMAVar, HOMAMax, HOMAMin);
    leptinVar = FeatureScale(leptinVar, leptinMax, leptinMin);
    adiponectinVar = FeatureScale(adiponectinVar, adiponectinMax, adiponectinMin);
    resistinVar = FeatureScale(resistinVar, resistinMax, resistinMin);
    MCPVar = FeatureScale(MCPVar, MCPMax, MCPMin);
    numCigarettesVar = FeatureScale(numCigarettesVar, numCigsMax, numCigsMin);
    cholesterolVar = FeatureScale(cholesterolVar, cholesterolMax, cholesterolMin);
    systoleVar = FeatureScale(systoleVar, systoleMax, systoleMin);
    diastoleVar = FeatureScale(diastoleVar, diastoleMax, diastoleMin);
    heartRateVar = FeatureScale(heartRateVar, heartRateMax, heartRateMin);
    CPKVar = FeatureScale(CPKVar, CPKMax, CPKMin);
    ejectionFracVar = FeatureScale(ejectionFracVar, ejectionMax, ejectionMin);
    plateletVar = FeatureScale(plateletVar, plateletsMax, plateletsMin);
    creatinineVar = FeatureScale(creatinineVar, creatinineMax, creatinineMin);
    sodiumVar = FeatureScale(sodiumVar, sodiumMax, sodiumMin);


    var inputBreastCancer = [
    [ageVar, BMIVar, glucoseVar, insulinVar, HOMAVar, leptinVar, adiponectinVar, resistinVar, MCPVar]
    ];
    var inputHeartAttack = [
      [genderVar, ageVar, smokingVar, numCigarettesVar, BPMedsVar, strokeVar, hypertensionVar, diabetesVar, cholesterolVar, systoleVar, diastoleVar, BMIVar, heartRateVar,
        glucoseVar]
    ];
    var inputHeartFailure = [
      [ageVar, anemiaVar, CPKVar, diabetesVar,ejectionFracVar, highBPVar, plateletVar, creatinineVar, sodiumVar, genderVar,smokingVar]
    ];

    var outputBreastCancer = List.filled(1, 0).reshape([1, 1]);
    var outputHeartAttack = List.filled(1, 0).reshape([1, 1]);
    var outputHeartFailure = List.filled(1, 0).reshape([1, 1]);


    interpreterBreastCancer.run(inputBreastCancer, outputBreastCancer) ;
    interpreterHeartAttack.run(inputHeartAttack, outputHeartAttack);
    interpreterHeartFailure.run(inputHeartFailure, outputHeartFailure);

    print(outputBreastCancer[0][0]);
    print(outputHeartAttack[0][0]);
    print(outputHeartFailure[0][0]);

    setState(() {

      predValueBreastCancer = outputBreastCancer[0][0].toStringAsFixed(3);
      predValueHeartAttack = outputHeartAttack[0][0].toStringAsFixed(3);
      predValueHeartFailure = outputHeartFailure[0][0].toStringAsFixed(3);

      predValueNumBreastCancer = double.parse(predValueBreastCancer);
      predValueNumHeartAttack = double.parse(predValueHeartAttack);
      predValueNumHeartFailure = double.parse(predValueHeartFailure);

      predValueBreastCancer = "${(outputBreastCancer[0][0]*100.0).toStringAsFixed(1)}%";
      predValueHeartAttack = "${(outputHeartAttack[0][0]*100.0).toStringAsFixed(1)}%";
      predValueHeartFailure = "${(outputHeartFailure[0][0]*100.0).toStringAsFixed(1)}%";

      if(genderVar == 1){
        predValueBreastCancer = "--";
        predValueNumBreastCancer = 0.0;
      }
      if(predValueNumBreastCancer < 0.20){
        breastCancerColor = Colors.green;
      }
      if(predValueNumBreastCancer >= 0.20){
        breastCancerColor = Colors.yellow;
      }
      if(predValueNumBreastCancer >= 0.40){
        breastCancerColor = Colors.orange;
      }
      if(predValueNumBreastCancer >= 0.65){
        breastCancerColor = Colors.red;
      }
      if(predValueNumHeartAttack < 0.20){
        heartAttackColor = Colors.green;
      }
      if(predValueNumHeartAttack >= 0.20){
        heartAttackColor = Colors.yellow;
      }
      if(predValueNumHeartAttack >= 0.40){
        heartAttackColor = Colors.orange;
      }
      if(predValueNumHeartAttack >= 0.65){
        heartAttackColor = Colors.red;
      }
      if(predValueNumHeartFailure < 0.20){
        heartFailureColor = Colors.green;
      }
      if(predValueNumHeartFailure >= 0.20){
        heartFailureColor = Colors.yellow;
      }
      if(predValueNumHeartFailure >= 0.40){
        heartFailureColor = Colors.orange;
      }
      if(predValueNumHeartFailure >= 0.65){
        heartFailureColor = Colors.red;
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.red;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Intelligent Diagnosis"),
        actions: [
          IconButton(onPressed: () => Navigator.pushNamed(context, '/ImageClassification'), icon: const Icon(Icons.image)),
          IconButton(onPressed: () => Navigator.pushNamed(context, '/Parkinson'), icon: const Icon(Icons.multitrack_audio_outlined))
        ],
      ),
      body: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(20.0),
          children: [

            Visibility(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Align(
                    child: Text("Please Enter all of the following data:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
                    alignment: Alignment.centerLeft,
                  ),

                  const Padding(padding: EdgeInsets.all(12.0),),
                  TextField(
                    controller: _ageController,
                    decoration: const InputDecoration(
                      labelText: "Enter Age*(In Years)",
                      hintText: "Age",
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[0-9.,]')),
                    ],
                  ),

                  const Padding(padding: EdgeInsets.all(12.0)),

                  TextField(
                    controller: _BMIController,
                    decoration: const InputDecoration(
                      labelText: "Enter BMI*",
                      hintText: "BMI",
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[0-9.,]')),
                    ],
                  ),

                  const Padding(padding: EdgeInsets.all(12.0)),

                  TextField(
                    controller: _numCigsController,
                    decoration: const InputDecoration(
                      labelText: "Enter the number of cigarettes consumed per day*",
                      hintText: "Number of cigarettes consumed per day",
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[0-9.,]')),
                    ],
                  ),

                  const Padding(padding: EdgeInsets.all(12.0)),

                  TextField(
                    controller: _heartRateController,
                    decoration: const InputDecoration(
                      labelText: "Enter Heart Rate(Number of Heart Beats / Minute)*",
                      hintText: "Heart Rate",
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[0-9.,]')),
                    ],
                  ),

                  const Padding(padding: EdgeInsets.all(12.0)),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Select Your Gender"),
                        const Padding(padding: EdgeInsets.all(2.0)),
                        DropdownButton<String>(
                          value: dropdownValueGender,
                          //hint: const Text("Gender*"),
                          icon: const Icon(Icons.arrow_downward),
                          elevation: 16,
                          style: const TextStyle(color: Colors.deepPurple),

                          underline: Container(
                            height: 2,
                            color: Colors.deepPurpleAccent,
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownValueGender = newValue!;
                              if(dropdownValueGender == 'Male'){
                                genderVar = 1.0;
                              }else{
                                genderVar = 0.0;
                              }
                            });
                          },
                          items: <String>['Male', 'Female']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                  const Padding(padding: EdgeInsets.all(12.0)),
                ],
              ),
              visible: firstPage,
            ),

            Visibility(
              child: Align(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Choose the options that apply to you:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
                    const Padding(padding: EdgeInsets.all(12.0),),
                    const Text("Do you have Anemia?"),

                    const Padding(padding: EdgeInsets.all(2.0)),

                    DropdownButton<String>(
                      value: dropDownValueAnemia,
                      //hint: const Text("Anemia"),
                      icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropDownValueAnemia = newValue!;
                          if(dropDownValueAnemia == 'Yes'){
                            anemiaVar = 1.0;
                          }else{
                            anemiaVar = 0.0;
                          }
                        });
                      },
                      items: <String>['No', 'Yes']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),

                    const Padding(padding: EdgeInsets.all(12.0)),

                    const Text("Do you have Diabetes?"),

                    const Padding(padding: EdgeInsets.all(2.0)),

                    DropdownButton<String>(
                      value: dropDownValueDiabetes,
                      //hint: const Text("Diabetes"),
                      icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropDownValueDiabetes = newValue!;
                          if(dropDownValueDiabetes == 'Yes'){
                            diabetesVar = 1.0;
                          }else{
                            diabetesVar = 0.0;
                          }
                        });
                      },
                      items: <String>['No', 'Yes']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),

                    const Padding(padding: EdgeInsets.all(12.0)),

                    const Text("Do you Smoke?"),

                    const Padding(padding: EdgeInsets.all(2.0)),

                    DropdownButton<String>(
                      value: dropDownValueSmoking,
                      //hint: const Text("Smoking"),
                      icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropDownValueSmoking = newValue!;
                          if(dropDownValueSmoking == 'Yes'){
                            smokingVar = 1.0;
                          }else{
                            smokingVar = 0.0;
                          }
                        });
                      },
                      items: <String>['No', 'Yes']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),

                    const Padding(padding: EdgeInsets.all(12.0)),

                    const Text("Do you have a history of Stroke?"),

                    const Padding(padding: EdgeInsets.all(2.0)),

                    DropdownButton<String>(
                      value: dropDownValueStroke,
                      //hint: const Text("Stroke"),
                      icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropDownValueStroke = newValue!;
                          if(dropDownValueStroke == 'Yes'){
                            strokeVar = 1.0;
                          }else{
                            strokeVar = 0.0;
                          }
                        });
                      },
                      items: <String>['No', 'Yes']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),

                    const Padding(padding: EdgeInsets.all(12.0)),

                    const Text("Do you have Hypertension?"),

                    const Padding(padding: EdgeInsets.all(2.0)),

                    DropdownButton<String>(
                      value: dropDownValueHypertension,
                      //hint: const Text("HyperTension"),
                      icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropDownValueHypertension = newValue!;
                          if(dropDownValueHypertension == 'Yes'){
                            hypertensionVar = 1.0;
                          }else{
                            hypertensionVar = 0.0;
                          }
                        });
                      },
                      items: <String>['No', 'Yes']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),

                    const Padding(padding: EdgeInsets.all(12.0)),

                    const Text("Do you have High Blood Pressure?"),

                    const Padding(padding: EdgeInsets.all(2.0)),

                    DropdownButton<String>(
                      value: dropDownValueHighBP,
                      //hint: const Text("High Blood Pressure"),
                      icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropDownValueHighBP = newValue!;
                          if(dropDownValueHighBP == 'Yes'){
                            highBPVar = 1.0;
                          }else{
                            highBPVar = 0.0;
                          }
                        });
                      },
                      items: <String>['No', 'Yes']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),

                    const Padding(padding: EdgeInsets.all(12.0)),

                    const Text("Do you take Medication Related to Blood Pressure?"),

                    const Padding(padding: EdgeInsets.all(2.0)),

                    DropdownButton<String>(
                      value: dropDownValueBPMeds,
                      //hint: const Text("Blood Pressure Medication"),
                      icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropDownValueBPMeds = newValue!;
                          if(dropDownValueBPMeds == 'Yes'){
                            BPMedsVar = 1.0;
                          }else{
                            BPMedsVar = 0.0;
                          }
                        });
                      },
                      items: <String>['No', 'Yes']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    const Padding(padding: EdgeInsets.all(12.0)),
                  ],
                ),
                alignment: Alignment.centerLeft,
              ),
              visible: secondPage,
            ),

            Visibility(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  children: [
                    const Text("Select The Diseases for which you want to be diagnosed:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
                    const Padding(padding: EdgeInsets.all(12.0),),
                    Row(
                      children: [
                        const Text("Breast Cancer", style: TextStyle(fontSize: 20),),
                        const Padding(padding: EdgeInsets.all(3.0),),
                        Checkbox(
                          checkColor: Colors.white,
                          fillColor: MaterialStateProperty.resolveWith(getColor),
                          value: isCheckBreastCancer,
                          onChanged: (bool? value) {
                            setState(() {
                              isCheckBreastCancer = value!;
                            });
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text("Heart Attack", style: TextStyle(fontSize: 20),),
                        const Padding(padding: EdgeInsets.all(3.0),),
                        Checkbox(
                          checkColor: Colors.white,
                          fillColor: MaterialStateProperty.resolveWith(getColor),
                          value: isCheckHeartAttack ,
                          onChanged: (bool? value) {
                            setState(() {
                              isCheckHeartAttack = value!;
                            });
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text("Heart Failure", style: TextStyle(fontSize: 20),),
                        const Padding(padding: EdgeInsets.all(3.0),),
                        Checkbox(
                          checkColor: Colors.white,
                          fillColor: MaterialStateProperty.resolveWith(getColor),
                          value: isCheckHeartFailure,
                          onChanged: (bool? value) {
                            setState(() {
                              isCheckHeartFailure = value!;
                            });
                          },
                        ),
                      ],
                    ),
                    const Padding(padding: EdgeInsets.all(12.0)),
                  ],
                ),
              ),
              visible: thirdPage,
            ),

            Visibility(
              child: Column(
                children: [

                  const Align(
                    child: Text("Enter Available Data:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
                    alignment: Alignment.centerLeft,
                  ),

                  const Padding(padding: EdgeInsets.all(12.0)),

                  Visibility(
                    child: Column(
                      children: [
                        TextField(
                          controller: _insulinControler,
                          decoration: const InputDecoration(
                            labelText: "Enter Insulin Levels in blood(µU/mL)",
                            hintText: "Insulin Level",
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp('[0-9.,]')),
                          ],
                        ),

                        const Padding(padding: EdgeInsets.all(12.0)),

                        TextField(
                          controller: _HOMAcontroller,
                          decoration: const InputDecoration(
                            labelText: "Enter the result for Insulin Resistance of Homeostatic Model Assessment",
                            hintText: "Homeostatic Model Assessment",
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp('[0-9.,]')),
                          ],
                        ),

                        const Padding(padding: EdgeInsets.all(12.0)),

                        TextField(
                          controller: _leptinController,
                          decoration: const InputDecoration(
                            labelText: "Enter Leptin Levels in blood(ng/mL)",
                            hintText: "Leptin Level",
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp('[0-9.,]')),
                          ],
                        ),

                        const Padding(padding: EdgeInsets.all(12.0)),

                        TextField(
                          controller: _adiponectinController,
                          decoration: const InputDecoration(
                            labelText: "Enter Adiponectin Levels in blood(µg/mL)",
                            hintText: "Adiponectin Level",
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp('[0-9.,]')),
                          ],
                        ),

                        const Padding(padding: EdgeInsets.all(12.0)),

                        TextField(
                          controller: _resistinController,
                          decoration: const InputDecoration(
                            labelText: "Enter Resistin Levels in blood(ng/mL)",
                            hintText: "Resistin Level",
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp('[0-9.,]')),
                          ],
                        ),

                        const Padding(padding: EdgeInsets.all(12.0)),

                        TextField(
                          controller: _MCPController,
                          decoration: const InputDecoration(
                            labelText: "Enter Monocyte Chemoattractant Protein-1 Levels in blood(pg/dL)",
                            hintText: "Monocyte Chemoattractant Protein-1 Level",
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp('[0-9.,]')),
                          ],
                        ),

                        const Padding(padding: EdgeInsets.all(12.0)),
                      ],
                    ),
                    visible: isCheckBreastCancer,
                  ),

                  Visibility(
                    child: Column(
                      children: [
                        TextField(
                          controller: _cholesterolController,
                          decoration: const InputDecoration(
                            labelText: "Enter Cholesterol Levels(mg/dL)",
                            hintText: "Cholesterol Level",
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp('[0-9.,]')),
                          ],
                        ),

                        const Padding(padding: EdgeInsets.all(12.0)),

                        TextField(
                          controller: _systoleController,
                          decoration: const InputDecoration(
                            labelText: "Enter Systolic Pressure",
                            hintText: "Systolic Pressure",
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp('[0-9.,]')),
                          ],
                        ),

                        const Padding(padding: EdgeInsets.all(12.0)),

                        TextField(
                          controller: _diastoleController,
                          decoration: const InputDecoration(
                            labelText: "Enter Diastolic Pressure",
                            hintText: "Diastolic Pressure",
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp('[0-9.,]')),
                          ],
                        ),

                        const Padding(padding: EdgeInsets.all(12.0)),
                      ],
                    ),
                    visible: isCheckHeartAttack,
                  ),

                  Visibility(
                    child: Column(
                      children: [
                        TextField(
                          controller: _CPKcontroller,
                          decoration: const InputDecoration(
                            labelText: "Enter Creatinine Phosphokinase Levels in blood(mcg/L)",
                            hintText: "Creatinine Phosphokinase Level",
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp('[0-9.,]')),
                          ],
                        ),

                        const Padding(padding: EdgeInsets.all(12.0)),

                        TextField(
                          controller: _ejectionFractionController,
                          decoration: const InputDecoration(
                            labelText: "Enter Ejection Fraction Value(Percentage)",
                            hintText: "Ejection Fraction",
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp('[0-9.,]')),
                          ],
                        ),

                        const Padding(padding: EdgeInsets.all(12.0)),

                        TextField(
                          controller: _plateletsController,
                          decoration: const InputDecoration(
                            labelText: "Enter Platelet Count(Kiloplatelets/mL)",
                            hintText: "Platelet Count",
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp('[0-9.,]')),
                          ],
                        ),

                        const Padding(padding: EdgeInsets.all(12.0)),

                        TextField(
                          controller: _creatinineController,
                          decoration: const InputDecoration(
                            labelText: "Enter Serum Creatinine Levels in blood(mg/dL)",
                            hintText: "Serum Creatinine Level",
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp('[0-9.,]')),
                          ],
                        ),

                        const Padding(padding: EdgeInsets.all(12.0)),

                        TextField(
                          controller: _sodiumController,
                          decoration: const InputDecoration(
                            labelText: "Enter Serum Sodium Levels in blood(mEq/L)",
                            hintText: "Serum Sodium Level",
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp('[0-9.,]')),
                          ],
                        ),

                        const Padding(padding: EdgeInsets.all(12.0)),
                      ],
                    ),
                    visible: isCheckHeartFailure,
                  ),

                  Visibility(
                    child: Column(
                      children: [
                        TextField(
                          controller: _glucoseController,
                          decoration: const InputDecoration(
                            labelText: "Enter Glucose Levels in blood(mg/dL)",
                            hintText: "Glucose Level",
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp('[0-9.,]')),
                          ],
                        ),

                        const Padding(padding: EdgeInsets.all(12.0)),
                      ],
                    ),
                    visible: (isCheckBreastCancer || isCheckHeartAttack),
                  ),

                  MaterialButton(
                    color: Colors.blue,
                    child: const Text(
                      "Predict",
                      style: TextStyle(fontSize: 25),
                    ),
                    onPressed: fetchData,
                  ),

                  const Padding(padding: EdgeInsets.all(12.0)),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      const Padding(padding: EdgeInsets.all(19.0)),

                      Visibility(
                        child: const Padding(padding: EdgeInsets.all(12),),
                        visible: !((isCheckHeartFailure & isCheckHeartAttack)||(isCheckHeartFailure & isCheckBreastCancer)),
                      ),

                      Visibility(
                          child: Row(
                            children: [
                              CircularPercentIndicator(
                                animation: true,
                                radius: 50.0,
                                percent: (predValueNumBreastCancer),
                                center: Text(predValueBreastCancer),
                                footer: const Text("Breast Cancer"),
                                progressColor: breastCancerColor,
                                circularStrokeCap: CircularStrokeCap.round,
                              ),
                              const Padding(padding: EdgeInsets.all(12.0)),
                            ],
                          ),
                        visible: isCheckBreastCancer,
                      ),



                      Visibility(
                        child: Row(
                          children: [
                            CircularPercentIndicator(
                              animation: true,
                              radius: 50.0,
                              percent: (predValueNumHeartAttack),
                              center: Text(predValueHeartAttack),
                              footer: const Text("Heart Attack"),
                              progressColor: heartAttackColor,
                              circularStrokeCap: CircularStrokeCap.round,
                            ),
                            const Padding(padding: EdgeInsets.all(12.0)),
                          ],
                        ),
                        visible: isCheckHeartAttack,
                      ),



                      Visibility(
                          child: CircularPercentIndicator(
                            animation: true,
                            radius: 50.0,
                            percent: (predValueNumHeartFailure),
                            center: Text(predValueHeartFailure),
                            footer: const Text("Heart Failure"),
                            progressColor: heartFailureColor,
                            circularStrokeCap: CircularStrokeCap.round,
                          ),
                        visible: isCheckHeartFailure,
                      ),

                      Visibility(
                        child: const Padding(padding: EdgeInsets.all(12),),
                        visible: !(isCheckHeartAttack || isCheckBreastCancer),
                      ),

                      const Padding(padding: EdgeInsets.all(19)),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.all(30)),
                ],
              ),
              visible: fourthPage,
            ),

            const Padding(padding: EdgeInsets.all(12.0)),

          ],
        ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [

          const Padding(padding: EdgeInsets.all(15)),
          
          Visibility(
              child: const Padding(padding: EdgeInsets.all(28)),
              visible: !(fltBtnPrev),
          ),

          Visibility(child: FloatingActionButton(
            onPressed: () {
              setState(() {
                currentPageIndex = (currentPageIndex - 1.0);
                visibilityController();
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Icon(Icons.arrow_back_ios_new),
              ],
            ),
          ),
            visible: fltBtnPrev,
          ),

          const Padding(padding: EdgeInsets.all(30)),

          DotsIndicator(
            dotsCount: 4,
            position: currentPageIndex,
            decorator: DotsDecorator(
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
            ),
          ),

          const Padding(padding: EdgeInsets.all(30)),

          Visibility(child: FloatingActionButton(
            onPressed: () {
              setState(() {
                if(currentPageIndex == 0.0){
    if(double.tryParse(_ageController.text) == null){
    setState(() {
    missingData = "Please Enter Your Age";
    Fluttertoast.showToast(
    msg: missingData,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    );
    });
    }else if(double.tryParse(_BMIController.text) == null){
    setState(() {
    missingData = "Please Enter Your BMI";
    Fluttertoast.showToast(
    msg: missingData,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    );
    });
    }else if(double.tryParse(_numCigsController.text) == null){
    setState(() {
    missingData = "Please Enter the Number of Cigarettes Consumed per Day";
    Fluttertoast.showToast(
    msg: missingData,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    );
    });
    }else if(double.tryParse(_heartRateController.text) == null){
    setState(() {
    missingData = "Please Enter Your Heart Rate";
    Fluttertoast.showToast(
    msg: missingData,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    );
    });
    }else{
      currentPageIndex = (currentPageIndex + 1.0);
      visibilityController();
    }
                }else if(currentPageIndex == 2.0){
                  if((isCheckBreastCancer || isCheckHeartAttack || isCheckHeartFailure) == false){
                    Fluttertoast.showToast(
                      msg: "Please Select at least 1 Disease to Diagnose",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                    );
                  }else{
                    currentPageIndex = (currentPageIndex + 1.0);
                    visibilityController();
                  }
                }
                else{
                  currentPageIndex = (currentPageIndex + 1.0);
                  visibilityController();
                }

              });

            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Icon(Icons.arrow_forward_ios),
              ],
            ),
          ),
            visible: fltBtnNext,
          ),

          Visibility(
            child: const Padding(padding: EdgeInsets.all(28)),
            visible: !(fltBtnNext),
          ),

        ],
      ),
    );
  }
}
