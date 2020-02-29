import 'package:flutter/material.dart';
import './all_logs.dart';
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
  final List<Widget> _children = [
    LoggingTrigger(),
    AllLogs(),
    Reflections()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped, // new
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.note_add),
              title: Text('Log')
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.collections_bookmark),
              title: Text('Diary')
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.comment),
              //collections_bookmark,assessment, comment, book, import_contacts, note_add, settings
              title: Text('Reflection')
          )
        ],
      ),
    );
  }
  
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}