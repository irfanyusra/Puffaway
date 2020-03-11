import 'package:flutter/material.dart';
import 'package:vape_app/services/auth.dart';
import './diary.dart';
import './logging_trigger.dart';
import 'reflections_page.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {

  final AuthService _auth = AuthService(); 
  int _currentIndex = 0;
  final List<Widget> _children = [
    LoggingTrigger(),
    AllLogs(),
    Reflections()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      elevation: 2.0,
      actions: <Widget>[
        FlatButton.icon(
          icon:Icon(Icons.person),
          label:Text('Logout'),
          onPressed: () async {
            await _auth.signOut();
          },)
      ],),
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