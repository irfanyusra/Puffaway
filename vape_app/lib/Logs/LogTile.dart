import 'package:flutter/material.dart';
import 'package:vape_app/Models/Log.dart';

class LogTile extends StatelessWidget {
  final Log log;
  LogTile({this.log});

  @override
  Widget build(BuildContext context) {
       return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          // leading: CircleAvatar(
          //   radius: 25.0,
          //   backgroundColor: Colors.brown[0],
          // ),
          title: Text('Trigger: ${log.trigger}'),
          subtitle: Text('Thought: ${log.thought}'),
        ),
      ),
    );
  }
}