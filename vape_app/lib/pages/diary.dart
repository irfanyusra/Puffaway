import 'package:flutter/material.dart';
import 'package:vape_app/Logs/all_logs.dart';
import 'package:vape_app/Reflections/all_reflections.dart';

//Widgget used to allow navigation between the logs page and reflections page
class Diary extends StatefulWidget {
  @override
  _DiaryState createState() => _DiaryState();
}

class _DiaryState extends State<Diary> {
  //Variable that acts like flag that allows for navigation between pages
  bool showLogs = true;

//Used to toggle showLogs -- toggling between logs and reflections 
  void toggleDiary() {
    setState(() {
      showLogs = !showLogs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return showLogs
        ? AllLogs(toggleDiary: toggleDiary)
        : AllReflections(toggleDiary: toggleDiary);
  }
}
