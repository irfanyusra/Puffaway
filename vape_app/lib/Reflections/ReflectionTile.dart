import 'package:flutter/material.dart';
import 'package:vape_app/Models/Reflection.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:vape_app/services/reflections.dart';

class ReflectionTile extends StatefulWidget {
  final Function onDelete;

  final Reflection reflection;
  ReflectionTile({this.reflection, this.onDelete});
  @override
  _ReflectionTileState createState() => _ReflectionTileState();
}

class _ReflectionTileState extends State<ReflectionTile> {
  ReflectionsService _reflection = ReflectionsService();

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      background: Container(color: Colors.red),
      key: Key(UniqueKey().toString()),
      onDismissed: (direction) {
        widget.onDelete(widget.reflection.documentID, _reflection);
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("log deleted"),
          duration: Duration(milliseconds: 1000),
        ));
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Card(
          margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
          child: ListTile(
            title: Text('Stressor: ${widget.reflection.stressor}'),
            subtitle: Text(
                'Progress: ${widget.reflection.progress}\n ${timeago.format(widget.reflection.dateTime.toDate())}'),
          ),
        ),
      ),
    );
  }
}
