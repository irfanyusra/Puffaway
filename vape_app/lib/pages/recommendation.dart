import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:math';

class Recommendation extends StatefulWidget {
  @override
  _RecommendationState createState() => _RecommendationState();
}

class _RecommendationState extends State<Recommendation> {
  Map data = {};

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;
    print(data);
//  'Thoughts: ${data['thoughts']}',
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
                alignment: AlignmentDirectional(0.0, 0.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueAccent),
                  borderRadius: BorderRadius.all(Radius.circular(5.0) //                 <--- border radius here
                      ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Recommendation',
                    style: TextStyle(
                      color: Colors.black,
                      letterSpacing: 2.0,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              Container(
                child: FlatButton(
                  color: Colors.blue,
                  child: Text('Next'),
                  onPressed: () {},
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
