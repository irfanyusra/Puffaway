import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProgressBar extends StatefulWidget {
  @override
  _ProgressBarState createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  double _progressValue;

  @override
  void initState() {
    super.initState();
    _progressValue = 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            LinearProgressIndicator(
              value: _progressValue,
            ),
            //Text('${(_progressValue * 100).round()}%'),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: FloatingActionButton( //finish pod
                onPressed: () {
                  setState(() {
                    _progressValue=100;
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
}

