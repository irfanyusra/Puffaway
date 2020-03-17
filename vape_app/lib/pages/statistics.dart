import 'package:flutter/material.dart';
import 'package:vape_app/PodLoader/ProgressBar.dart';
import 'package:vape_app/services/database.dart';
import 'package:vape_app/Models/Log.dart';
import 'package:vape_app/Models/User.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:vape_app/shared/Calendar.dart';
import 'package:vape_app/shared/TimeSeriesBar.dart';
import 'package:vape_app/shared/Timer.dart';
import 'settings.dart';

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
          title: Text('Dashboard',  key: Key("dashboard")),
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right:20.0),
              child: GestureDetector(
                onTap: () async {
                  Navigator.push(context, new MaterialPageRoute<void>(builder: (context) => Settings()));
                },
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
                padding: const EdgeInsets.only(top: 20),
                child: Center(child: Text("Time Since Last Hit", style: TextStyle(fontSize: 20))),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: timer(),
              ),
              ProgressBar(),
              Calendar(),
              TimeSeriesBar(),
              ],
            ),
          ),
        )
    );
  }
}
