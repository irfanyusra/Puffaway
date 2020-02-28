import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vape_app/Models/Log.dart';
import 'package:vape_app/services/database.dart';
import 'package:provider/provider.dart';

class AllLogs extends StatefulWidget {
  @override
  _AllLogsState createState() => _AllLogsState();
}

class _AllLogsState extends State<AllLogs> {
  //TODO: delete btn
  List<Log> list_logs = [
    Log('trigger1', 'thoughts1', 'recommendation', 'stressors', 'progress'),
    Log('trigger2', 'thoughts2', 'recommendation', 'stressors', 'progress'),
    Log('trigger3', 'thoughts3', 'recommendation', 'stressors', 'progress'),
    Log('trigger4', 'thoughts4', 'recommendation', 'stressors', 'progress'),
    Log('trigger5', 'thoughts5', 'recommendation', 'stressors', 'progress'),
    Log('trigger1', 'thoughts1', 'recommendation', 'stressors', 'progress'),
    Log('trigger2', 'thoughts2', 'recommendation', 'stressors', 'progress'),
    Log('trigger3', 'thoughts3', 'recommendation', 'stressors', 'progress'),
    Log('trigger4', 'thoughts4', 'recommendation', 'stressors', 'progress'),
    Log('trigger5', 'thoughts5', 'recommendation', 'stressors', 'progress'),
  ];

  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot>.value(
          value:DatabaseService().logs,
          child: Scaffold(
        appBar: AppBar(
          title: Text('All Logs'),
          centerTitle: true,
        ),
        body:LogList() 
        ListView.builder(
            itemCount: list_logs.length,
            itemBuilder: (context, index) {
              return Dismissible(
                background: Container(color: Colors.red),
                key: Key(list_logs[index].dateT.toString()),
                onDismissed: (direction) {
                  setState(() {
                    list_logs.removeAt(index);
                  });

                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text("log deleted")));
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
                  child: Card(
                    child: ListTile(
                      title: Text(
                        '${list_logs[index].formatted_day.toString()} at ${list_logs[index].formatted_time.toString()}',
                        style: TextStyle(
                          color: Colors.black,
                          letterSpacing: 2,
                          fontSize: 18,
                        ),
                      ),
                      subtitle: Text(
                        'Trigger: ${list_logs[index].trigger} \n'
                        'Thoughts: ${list_logs[index].thoughts}\n'
                        'Stressors: ${list_logs[index].stressors}\n'
                        'Feeling about the progress: ${list_logs[index].progress}',
                        style: TextStyle(
                          color: Colors.grey[700],
                          letterSpacing: 1.5,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
