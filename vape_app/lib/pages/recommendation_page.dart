import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vape_app/Models/Recommendation.dart';

class Recommendation extends StatefulWidget {
  @override
  _RecommendationState createState() => _RecommendationState();
}

class _RecommendationState extends State<Recommendation> {
  Map data = {};
  List<Recommendations> listRecommendations = [
    Recommendations(
        trigger: "Select one", recom: "Please select a trigger next time"),
    Recommendations(trigger: "trigger1", recom: "dddddd \n dddsds"),
    Recommendations(trigger: "trigger2", recom: "dddddd2"),
    Recommendations(trigger: "trigger3", recom: "dddddd3"),
    Recommendations(trigger: "trigger4", recom: "dddddd4")
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
    //print(data);
    getRecommendation(data['trigger']);

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
                  style: TextStyle(
                    color: Colors.black,
                    letterSpacing: 2.0,
                    fontSize: 18,
                  ),
                ),
              ),
              SizedBox(
                height: 40.0,
              ),

              Container(
                child: Text(
                  'Based on the trigger, ${data['trigger']},  you selected, we recommend ',
                  style: TextStyle(
                    color: Colors.black,
                    letterSpacing: 2.0,
                    fontSize: 18,
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),

              Container(
                alignment: Alignment.topLeft,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueAccent),
                  borderRadius: BorderRadius.all(Radius.circular(
                          5.0) //                 <--- border radius here
                      ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Recommendation: \n ${rec.recom}',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.black,
                      letterSpacing: 2.0,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              //TODO: Make the button at the bottom of the page
              Container(
                alignment: Alignment.bottomCenter,
                child: FlatButton(
                  color: Colors.blue,
                  child: Text('Finish Log',
                      style: TextStyle(
                        fontSize: 20,
                      )),
                  onPressed: () {
                    //go to the reflections page
                    //sending all the variables for logging (trigger, thoughts, recommendation
                    Navigator.pushNamed(context, '/reflections', arguments: {
                      'thoughts': data['thoughts'],
                      'trigger': data['trigger'],
                      'recommendation': rec,
                    });
                  },
                ),
              ),
//
            ],
          ),
        ),
      ),
    );
  }
}
