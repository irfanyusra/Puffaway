import 'package:flutter/material.dart';
import 'package:vape_app/services/database.dart';
import 'package:vape_app/Models/Log.dart';
import 'package:vape_app/Models/User.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:vape_app/shared/Calendar.dart';
import 'package:vape_app/PodLoader/PodPainter.dart';
import 'package:vape_app/PodLoader/ProgressBar.dart';
import 'package:vape_app/shared/Timer.dart';

class Statistics extends StatefulWidget {
  @override
  _StatisticsState createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {


  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamProvider<List<Log>>.value(
      value: DatabaseService(uid:user.uid).logs,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Dashboard'),
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right:20.0),
              child: GestureDetector(
                onTap: (){},
                child: Icon(
                  Icons.settings,
                  size: 26.0,
                ),
              ),
            ),
          ],
        ),

        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Center(child: Text("Time Since Last Hit", style: TextStyle(fontSize: 20))),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
                child: timer(),
              ),
              Center(
                child: CustomPaint(
                  painter: PodPainter(),
                  child: Container(
                    height: 100,
                    width: 50,
                  ),
                ),
              ),
              ProgressBar(),
              Calendar(),
              ],
            ),
          ),
        )
    );
  }
}
