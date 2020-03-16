import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vape_app/Logs/LogTile.dart';
import 'package:vape_app/Models/Log.dart';
import 'package:vape_app/services/logs.dart';

class LogList extends StatefulWidget {
  @override
  _LogListState createState() => _LogListState();
}

class _LogListState extends State<LogList> {
  //removeLog() is a function which removes a log once the log is swiped
  void removeLog(var documentID, LogsService log) async {
    await log.deleteLog(documentID);
  }

  @override
  Widget build(BuildContext context) {
    final logs = Provider.of<List<Log>>(context) ?? [];
    var getLogsLength = logs.length;

    return ListView.builder(
        itemCount: getLogsLength,
        itemBuilder: (context, index) {
          return LogTile(
              log: logs[index],
              onDelete: (documentID, log) => removeLog(documentID, log));

          // return Dismissible(
          //     background: Container(color: Colors.red),
          //     key: Key(list_logs[index].dateT.toString()),
          //     onDismissed: (direction) {
          //       setState(() {
          //         list_logs.removeAt(index);
          //       });

          //       Scaffold.of(context)
          //           .showSnackBar(SnackBar(content: Text("log deleted")));
          //     },
          //     child: Padding(
          //       padding:
          //           const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
          //       child: Card(
          //         child: ListTile(
          //           title: Text(
          //             '${list_logs[index].formatted_day.toString()} at ${list_logs[index].formatted_time.toString()}',
          //             style: TextStyle(
          //               color: Colors.black,
          //               letterSpacing: 2,
          //               fontSize: 18,
          //             ),
          //           ),
          //           subtitle: Text(
          //             'Trigger: ${list_logs[index].trigger} \n'
          //             'Thoughts: ${list_logs[index].thoughts}\n'
          //             'Stressors: ${list_logs[index].stressors}\n'
          //             'Feeling about the progress: ${list_logs[index].progress}',
          //             style: TextStyle(
          //               color: Colors.grey[700],
          //               letterSpacing: 1.5,
          //               fontSize: 14,
          //             ),
          //           ),
          //         ),
          //       ),
          //     ),
          //   );
          // }),
          // ),
        });
  }
}
