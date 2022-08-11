
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ImageClassificationPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Scan Diagnosis"),
        ),
        body: Center(
          child: ListView(
            padding: const EdgeInsets.only(left: 50.0, right: 50.0),
            shrinkWrap: true,
            children: [
              MaterialButton(
                onPressed: () => Navigator.pushNamed(context, '/MammographClassification'),
                child: const Text(
                  "Breast Cancer",
                  style: TextStyle(fontSize: 25),
                ),
                color: Colors.blue,
              ),

              const Padding(padding: EdgeInsets.all(12.0)),
              MaterialButton(
                onPressed: () => Navigator.pushNamed(context, '/BrainTumor'),
                child: const Text(
                  "Brain Tumor",
                  style: TextStyle(fontSize: 25),
                ),
                color: Colors.blue,
              ),

              const Padding(padding: EdgeInsets.all(12.0)),
              MaterialButton(
                onPressed: () => Navigator.pushNamed(context, '/AlzhimersScan'),
                child: const Text(
                  "Dementia",
                  style: TextStyle(fontSize: 25),
                ),
                color: Colors.blue,
              ),
              const Padding(padding: EdgeInsets.all(12.0)),
            ],
          ),
        )
      ),
    );
  }

}