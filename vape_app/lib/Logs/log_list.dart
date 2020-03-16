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

        });
  }
}
