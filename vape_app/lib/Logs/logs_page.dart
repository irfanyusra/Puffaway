import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vape_app/Models/Trigger.dart';
import 'package:vape_app/Models/User.dart';
import 'package:vape_app/services/database.dart';
import './logs_page_helper.dart';

//Widget used to get the triggers from the stream and send to LogsPageHelper()
//Where the data will be displayed
class LogsPage extends StatefulWidget {
  @override
  _LogsPageState createState() => _LogsPageState();
}

class _LogsPageState extends State<LogsPage> {
  @override
  Widget build(BuildContext context) {
    //Grab current user
    final user = Provider.of<User>(context);

    return StreamProvider<List<Trigger>>.value(
      value:DatabaseService(uid: user.uid).triggers,
      child:LogsPageHelper()
    );
  }
}

