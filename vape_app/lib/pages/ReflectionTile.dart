import 'package:flutter/material.dart';
import 'package:vape_app/Models/Reflection.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:vape_app/services/logs.dart';

class ReflectionTile extends StatefulWidget {
  final Reflection reflection;
  ReflectionTile({this.reflection});
  @override
  _ReflectionTileState createState() => _ReflectionTileState();
}

class _ReflectionTileState extends State<ReflectionTile> {
    LogsService _log = LogsService();

  @override
 Widget build(BuildContext context) {
       return Dismissible(
        
        background: Container(color: Colors.red),
          key: Key(UniqueKey().toString()),
          onDismissed: (direction) {
          setState(() {
            //Delete reflection once swiped
             _log.deleteReflection(widget.reflection.documentID);
          });

          Scaffold.of(context)
              .showSnackBar(SnackBar(content: Text("log deleted")));
        },
                child: Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
          margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
          child: ListTile(
            // leading: CircleAvatar(
            //   radius: 25.0,
            //   backgroundColor: Colors.brown[0],
            // ),
            title: Text('Stressor: ${widget.reflection.stressor}'),
            subtitle: Text('Progress: ${widget.reflection.progress}\n ${timeago.format(widget.reflection.dateTime.toDate())}'),
          ),
      ),
    ),
       );
  }
}


