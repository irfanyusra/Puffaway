import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vape_app/Models/Log.dart';
import 'dart:async';

class timer extends StatefulWidget {
  @override
  _timerState createState() => _timerState();
}

class _timerState extends State<timer> {
  @override
  Widget build(BuildContext context) {
    String sDuration="";
    final logs = Provider.of<List<Log>>(context);
    if (logs != null) {
      var lastHitTime = DateTime.parse(
          logs.last.dateTime.toDate().toString()); //last log time goes here
      var current = new DateTime.now();
      var diff = current.difference(lastHitTime);
      sDuration = "${diff.inDays}d ${diff.inHours.remainder(24)}h ${diff
          .inMinutes.remainder(60)}m ${(diff.inSeconds.remainder(60))}s ";

      Timer.periodic(Duration(seconds: 1), (v) {
        setState(() {
          current = DateTime.now(); // or BinaryTime see next step
        });
      });
    }
      return Container(
        alignment: Alignment.center,
        child: Text(
          sDuration,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w700,
          ),
        ),
      );
    }

}