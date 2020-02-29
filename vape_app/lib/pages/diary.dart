import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vape_app/Models/Log.dart';
import 'package:vape_app/pages/log_list.dart';
import 'package:vape_app/services/database.dart';
import 'package:provider/provider.dart';

class AllLogs extends StatefulWidget {
  @override
  _AllLogsState createState() => _AllLogsState();
}

class _AllLogsState extends State<AllLogs> {
  //TODO: delete btn for only the first log 

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Log>>.value(
          value:DatabaseService().logs,
          child: Scaffold(
        appBar: AppBar(
          title: Text('All Logs'),
          centerTitle: true,
        ),
        body:LogList())
     
    );
  }
}
