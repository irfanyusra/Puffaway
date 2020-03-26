import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vape_app/Models/Log.dart';
import 'dart:async';
import 'package:vape_app/shared/loading.dart';

class timer extends StatefulWidget {
  @override
  _timerState createState() => _timerState();
}

class _timerState extends State<timer> {
  final FirebaseMessaging _fcm = FirebaseMessaging();

  @override
  Widget build(BuildContext context) {
    String sDuration = "";
    final logs = Provider.of<List<Log>>(context) ?? [];
    if (logs != null) {
      var lastHitTime = logs.length > 0
          ? DateTime.parse(logs.first.dateTime.toDate().toString())
          : new DateTime.now(); //last log time goes here

      var current = new DateTime.now();
      var diff = current.difference(lastHitTime);
      if (diff.inDays >= 1) {
        sDuration =
            "${diff.inDays}d ${diff.inHours.remainder(24)}h ${diff.inMinutes.remainder(60)}m";
      } else {
        sDuration =
            "${diff.inHours.remainder(24)}h ${diff.inMinutes.remainder(60)}m ${(diff.inSeconds.remainder(60))}s ";
      }

      //subscribe to different notification classes depending on how long you have been vape free for
      if (diff.inDays == 1) {
        //vape free for 1 day
        _fcm.subscribeToTopic("day1");
      } else if (diff.inDays == 2) {
        //vape free for 2 days
        _fcm.unsubscribeFromTopic("day1");
        _fcm.subscribeToTopic("day2");
      } else if (diff.inDays == 3) {
        //unsubscribe from day 2 message
        _fcm.unsubscribeFromTopic("day2");
      } else if (diff.inDays == 5) {
        //vape free for 5 days
        _fcm.subscribeToTopic("day5");
      } else if (diff.inDays == 6) {
        _fcm.unsubscribeFromTopic("day5");
      } else if (diff.inDays == 7) {
        //vape free for 1 week
        _fcm.subscribeToTopic("week1");
      } else if (diff.inDays == 8) {
        _fcm.unsubscribeFromTopic("week1");
      } else if (diff.inDays == 14) {
        _fcm.subscribeToTopic("week2");
      } else if (diff.inDays == 15) {
        _fcm.unsubscribeFromTopic("week2");
      } else if (diff.inDays == 21) {
        _fcm.subscribeToTopic("week3");
      } else if (diff.inDays == 22) {
        _fcm.unsubscribeFromTopic("week3");
      } else if (diff.inDays == 30) {
        _fcm.subscribeToTopic("month1");
      } else if (diff.inDays == 31) {
        _fcm.unsubscribeFromTopic("month1");
      } else if (diff.inDays == 92) {
        _fcm.subscribeToTopic("month3");
      } else if (diff.inDays == 93) {
        _fcm.unsubscribeFromTopic("month3");
      } else if (diff.inDays == 182) {
        _fcm.subscribeToTopic("month6");
      } else if (diff.inDays == 183) {
        _fcm.unsubscribeFromTopic("month6");
      } else if (diff.inDays == 274) {
        _fcm.subscribeToTopic("month9");
      } else if (diff.inDays == 275) {
        _fcm.unsubscribeFromTopic("month9");
      } else if (diff.inDays == 365) {
        _fcm.subscribeToTopic("year1");
      } else if (diff.inDays == 366) {
        _fcm.unsubscribeFromTopic("year1");
      }

      Timer.periodic(Duration(seconds: 1), (v) async {
        if (this.mounted) {
          setState(() {
            current = DateTime.now(); // or BinaryTime see next step
          });
        }
      });

      return Container(
          alignment: Alignment.center,
          child: Text(
            sDuration,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w700,
            ),
          ));
    } else {
      return Loading();
    }
  }
}
