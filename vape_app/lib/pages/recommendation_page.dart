import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vape_app/Models/Recommendation.dart';
import 'package:vape_app/services/auth.dart';
import 'package:vape_app/shared/constants.dart';
import 'dart:convert' show utf8;

class Recommendation extends StatefulWidget {
  final String trigger;
  Recommendation({this.trigger});
  @override
  _RecommendationState createState() => _RecommendationState();
}

class _RecommendationState extends State<Recommendation> {
  Map data = {};
  List<Recommendations> listRecommendations = [
    // Recommendations(
    // trigger: "Select one", recom: "Please select a trigger next time"),
    Recommendations(
        trigger: "Time of day",
        recom:
            "Try planning somthing else you enjoy for this specific time of the day"),
    Recommendations(
        trigger: "Wake-up routine",
        recom: "Drink a coffee instead if your looking for a pick me up"),
    Recommendations(trigger: "Boredom", recom: "Watch some netflix"),
    Recommendations(trigger: "Stress", recom: "Try drinking some tea"),
    Recommendations(
        trigger: "Vape smell",
        recom:
            "Try chewing some gum the taste will get the smell out of your head"),
    Recommendations(trigger: "Seeing someone vaping", recom: "Walk away"),
    Recommendations(trigger: "Fatigue", recom: "Drink coffee"),
    Recommendations(trigger: "Partying", recom: "Have another beer"),
    Recommendations(trigger: "Sex", recom: "Do it again its more fun!")
  ];
  Recommendations rec;

  Recommendations getRecommendation(String trig) {
    rec = listRecommendations.where((Recommendations r) {
      return r.trigger == trig;
    }).first;
    return rec;
//   listRecommendations.
  }

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;
    final _auth = AuthService();
    // print(utf8.encode(widget.trigger));
    // print(utf8.encode(listRecommendations[5].trigger));
    rec = getRecommendation(widget.trigger);


    return Scaffold(
      appBar: AppBar(
        title: Text('Recommendation'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                child: Text(
                  'Sometimes vaping is a good way to deal with life, but noticing why you do it can help you determine a better alternative',
                  style: textStyle,
                ),
              ),
              SizedBox(height: 40.0),
              Container(
                child: Text(
                  'Based on the trigger, you selected, we recommend ', //NEED TO PUT DATABASE VAR
                  style: textStyle,
                ),
              ),
              SizedBox(height: 20.0),
              Container(
                alignment: Alignment.topLeft,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueAccent),
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    'Recommendation: \n ${rec.recom}',
                    textAlign: TextAlign.left,
                    style: textStyle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
