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
  @override
  Widget build(BuildContext context) {
    String sDuration="";
    final logs = Provider.of<List<Log>>(context)??[];
      if(logs!=null){
      var lastHitTime= logs.length>0? DateTime.parse(
          logs.first.dateTime.toDate().toString()): new DateTime.now(); //last log time goes here
    
      var current = new DateTime.now();
      var diff = current.difference(lastHitTime);
      if(diff.inDays>=1){
        sDuration = "${diff.inDays}d ${diff.inHours.remainder(24)}h ${diff
            .inMinutes.remainder(60)}m";
      }else {
        sDuration = "${diff.inHours.remainder(24)}h ${diff
            .inMinutes.remainder(60)}m ${(diff.inSeconds.remainder(60))}s ";
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
      )
    );
    } else {
      return Loading();
    }
  }
}
