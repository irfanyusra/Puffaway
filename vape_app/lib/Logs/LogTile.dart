import 'package:flutter/material.dart';
import 'package:vape_app/Models/Log.dart';
import 'package:vape_app/services/logs.dart';
import 'package:timeago/timeago.dart' as timeago;

class LogTile extends StatefulWidget {
  final Function onDelete;
  final Log log;
  const LogTile({Key key,this.log,this.onDelete}):super(key:key);
  
  @override
  _LogTileState createState() => _LogTileState();
}

class _LogTileState extends State<LogTile> {
  LogsService _log = LogsService();
  @override
  Widget build(BuildContext context) {
    
    return Dismissible(
        background: Container(color: Colors.red),
          key: Key(UniqueKey().toString()),
          onDismissed: (direction) {
        widget.onDelete(widget.log.documentID,_log);
          Scaffold.of(context)
              .showSnackBar(SnackBar(content: Text("log deleted"),duration:Duration(milliseconds:500)));
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

                    title: Text('Trigger: ${widget.log.trigger}'),
                    subtitle: Text('Thought: ${widget.log.thought}\n ${timeago.format(widget.log.dateTime.toDate())}'),
          ),
        ),
      )
    );
    }
}
  


