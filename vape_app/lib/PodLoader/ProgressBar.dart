import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vape_app/services/pods.dart';
import 'liquid_custom_progress_indicator.dart';

class ProgressBar extends StatefulWidget {

  @override
  _ProgressBarState createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  double _progressValue;
  var goal=10;//database var for goal goes here

  final _pod = PodService();
  
  @override
  void initState() {
    super.initState();
    _progressValue = 1.0;
  }

  Path _buildVapePath() {
    return Path()
      ..moveTo(0, 100*0.45)
      ..lineTo(50*0.1, 100*0.45)
      ..lineTo(50*0.25, 100*0.375)
      ..lineTo(50*0.75, 100*0.375)
      ..lineTo(50*0.9, 100*0.45)
      ..lineTo(50, 100*0.45)
      ..lineTo(50, 100*0.875)
      ..lineTo(50*0.85, 100)
      ..lineTo(50*0.15, 100)
      ..lineTo(0, 100*0.875)
      ..lineTo(0, 100*0.45)
      ..lineTo(50*0.1, 100*0.45)
      ..close();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
          padding: EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

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
              LiquidCustomProgressIndicator(
                  value: _progressValue,
                  valueColor: AlwaysStoppedAnimation(Colors.amberAccent), // Defaults to the current Theme's accentColor.
                  backgroundColor: Colors.grey.withOpacity(0.5), // Defaults to the current Theme's backgroundColor.
                  direction: Axis.vertical, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right).
                  shapePath: _buildVapePath(), // A Path object used to draw the shape of the progress indicator.
                ),
              //Text('${(_progressValue * 100).round()}%'),

              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: FloatingActionButton( //finish pod
                  onPressed: () async {
                    _pod.addPodFinishTime();
                    setState(() {
                      _updateProgress();
                    });
                  },
                  tooltip: 'Finish Pod',
                  child: Icon(Icons.delete_outline),
                ),
              ),
            ],
          )
      );
  }

  void _updateProgress() {
    const oneDay = const Duration(seconds: 1);//updated bar every minute
    new Timer.periodic(oneDay, (Timer t) async {
      if (this.mounted) {
        setState(() {
          _progressValue -= 1.0 / (goal); //every minute a small piece of bar goes away 1440

          if (_progressValue <= 0.0) {
            t.cancel();
            _progressValue = 1.0;
            return;
          }
        });
      }
    });
  }
}

