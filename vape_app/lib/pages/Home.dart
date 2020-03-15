import 'package:flutter/material.dart';
import 'statistics.dart';
import './diary.dart';
import './toggle_diary.dart';
import './logging_trigger.dart';
import 'reflections_page.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _children = [Statistics(), LoggingTrigger(),Diary(), Reflections()];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: onTabTapped, // new
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.assessment, key: Key('stats-nav'),), title: Text('Stats')),
          BottomNavigationBarItem(
              icon: Icon(Icons.note_add, key: Key('log-nav'),), title: Text('Log')),
          BottomNavigationBarItem(
              icon: Icon(Icons.collections_bookmark,  key: Key('diary-nav'),), title: Text('Diary')),
          BottomNavigationBarItem(
              icon: Icon(Icons.comment,  key: Key('reflection-nav'),),
              //collections_bookmark,assessment, comment, book, import_contacts, note_add, settings
              title: Text('Reflection'))
        ],
      ),
    );
  }

  //Used to check which navigation bar item was pressed
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
