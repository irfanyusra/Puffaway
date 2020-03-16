import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vape_app/Models/User.dart';
import 'package:vape_app/Models/pod.dart';
import 'package:vape_app/shared/loading.dart';
import 'package:vape_app/services/database.dart';
import 'package:vape_app/services/pods.dart';
import 'liquid_custom_progress_indicator.dart';

class ProgressBar extends StatefulWidget {

  @override
  _ProgressBarState createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  double _progressValue;
  var goal = 10; //database var for goal goes here

  final _pod = PodService();

  @override
  void initState() {
    super.initState();
    _progressValue = 1.0;
  }

  Path _buildVapePath() {
    return Path()
      ..moveTo(0, 100 * 0.45)
      ..lineTo(50 * 0.1, 100 * 0.45)..lineTo(50 * 0.25, 100 * 0.375)..lineTo(
          50 * 0.75, 100 * 0.375)..lineTo(50 * 0.9, 100 * 0.45)..lineTo(
          50, 100 * 0.45)..lineTo(50, 100 * 0.875)..lineTo(
          50 * 0.85, 100)..lineTo(50 * 0.15, 100)..lineTo(
          0, 100 * 0.875)..lineTo(0, 100 * 0.45)..lineTo(50 * 0.1, 100 * 0.45)
      ..close();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder<List<Pod>>(

        stream: DatabaseService(uid: user.uid).pods,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var startDateSec = snapshot.data.first.dateTime.seconds;
            var endDateSec = startDateSec + (goal * 24 * 60 * 60);
            var nowSec = DateTime
                .now()
                .millisecondsSinceEpoch / 1000; //time now in sec
            var totalSec = endDateSec - startDateSec;
            var totalSecLeft = endDateSec - nowSec;

            if(totalSecLeft / totalSec>0) {
              _progressValue = totalSecLeft / totalSec;
            }else{
              _progressValue = 0;
            }

            return Container(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    LiquidCustomProgressIndicator(
                      value: _progressValue,
                      valueColor: AlwaysStoppedAnimation(Colors.amberAccent),
                      backgroundColor: Colors.grey.withOpacity(0.5),
                      direction: Axis.vertical,
                      shapePath: _buildVapePath(),
                    ),
                    //Text('${(_progressValue * 100).round()}%'),

                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: FloatingActionButton( //finish pod
                        onPressed: () async {
                          _pod.addPodFinishTime();
                          //if they acheved their goal
                          setState(() {
                            if(totalSecLeft / totalSec<=0)
                            _showDialog();
                          });
                        },
                        tooltip: 'Finish Pod',
                        child: Icon(Icons.delete_outline),
                      ),
                    ),
                  ],
                )
            );
          } else {
            return Loading();
          }
        }
    );
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Congratulations!!"),
          content: new Text("You met your goal of making your pod last at least ${goal} days. Not everyone can quit cold "
              "turkey and decreasing the amount you vape by making pods last longer is an important first step."
              "Pleast navigate to the settings page and set a new goal!"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}


