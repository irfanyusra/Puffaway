import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vape_app/pages/loading.dart';
import 'package:vape_app/services/database.dart';
import 'package:vape_app/services/pods.dart';
import 'package:vape_app/Models/pod.dart';
import 'package:vape_app/Models/User.dart';
import 'PodLevel.dart';

class ProgressBar extends StatefulWidget {
  @override
  _ProgressBarState createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  double _progressValue;
  bool _loading;
  var goal=10;//database var for goal goes here

  final _pod = PodService();
  
  @override
  void initState() {
    super.initState();
    _loading = true;
    _progressValue = 1.0;
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder<List<Pod>>(
      stream: DatabaseService(uid: user.uid).pods,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var podDates = snapshot.data;
          return Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 100,
                    width: 50,
                    child: LinearProgressIndicator(
                      value: _progressValue,
                    ),
                  ),
                  //Text('${(_progressValue * 100).round()}%'),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: FloatingActionButton( //finish pod
                      onPressed: () async {
                        _pod.addPodFinishTime();
                        setState(() {
                          _loading = !_loading;
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
        }else{
          return Loading();
        }
      }
    );
  }

  void _updateProgress() {
    const oneDay = const Duration(seconds: 60);//updated bar every hour
    new Timer.periodic(oneDay, (Timer t) {
      setState(() {
        _progressValue -= 1.0/(1440*goal);//every minute a small piece of bar goes away

        if (_progressValue <= 0.0) {
          _loading = true;
          t.cancel();
          _progressValue = 1.0;
          return;
        }
      });
    });
  }
}

