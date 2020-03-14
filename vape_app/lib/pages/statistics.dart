import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';
import 'package:vape_app/services/database.dart';
import 'package:vape_app/Models/Log.dart';
import 'package:vape_app/Models/User.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:vape_app/shared/Timer.dart';

class Statistics extends StatefulWidget {
  @override
  _StatisticsState createState() => _StatisticsState();
}

Map<String,dynamic> encodeMap(Map<DateTime,dynamic> map) {
  Map<String,dynamic> newMap = {};
  map.forEach((key,value) {
    newMap[key.toString()] = map[key];
  });
  return newMap;
}

Map<DateTime,dynamic> decodeMap(Map<String,dynamic> map) {
  Map<DateTime,dynamic> newMap = {};
  map.forEach((key,value) {
    newMap[DateTime.parse(key)] = map[key];
  });
  return newMap;
}

class _StatisticsState extends State<Statistics> {
  CalendarController _calendarController;
  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    Map<DateTime, List<dynamic>> _events;
    return StreamProvider<List<Log>>.value(
      value: DatabaseService(uid:user.uid).logs,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Dashboard'),
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
              TableCalendar( calendarController: _calendarController),
            ],
          ),
        )
      ),
    );
  }
}
