import 'package:flutter/material.dart';
import 'package:vape_app/Models/Reflection.dart';

class ReflectionTile extends StatelessWidget {
  final Reflection reflection;
  ReflectionTile({this.reflection});

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
          title: Text('Stressor: ${reflection.stressor}'),
          subtitle: Text('Progress: ${reflection.progress}'),
        ),
      ),
    );
  }
}