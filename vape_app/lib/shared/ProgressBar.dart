import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProgressBar extends StatefulWidget {
  @override
  _ProgressBarState createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  double _progressValue;
  bool _loading;

  @override
  void initState() {
    super.initState();
    _loading = false;
    _progressValue = 100;
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
  }

  void _updateProgress() {
    const oneSec = const Duration(seconds: 1);
    new Timer.periodic(oneSec, (Timer t) {
      setState(() {
        _progressValue -= 0.2;
        // we "finish" downloading here
        if (_progressValue.toStringAsFixed(1) == '0.0') {
          _loading = false;
          t.cancel();
          _progressValue: 1.0;
          return;
        }
      });
    });
  }
}

