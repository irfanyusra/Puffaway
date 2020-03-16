import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:vape_app/Models/Log.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {

  CalendarController _calendarController;
  Map<DateTime, List<dynamic>> _events;

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
    _events={};
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final logs = Provider.of<List<Log>>(context);

    setState(() {
      if(logs!=null) {
        for (var i = 0; i < logs.length; i++) {

          var date = DateTime.parse(logs[i].dateTime.toDate().toString());
          var formatter = new DateFormat('yyyy-MM-dd');
          var formatted = DateTime.parse(formatter.format(date));

          if (_events[formatted] != null) {
            _events[formatted].add("0");
          } else {
            _events[formatted] = ["0"];
          }
        }
      }
    });

    return TableCalendar(
        calendarController: _calendarController,
        events: _events,
    );
  }
}
