import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vape_app/Models/Log.dart';
import 'package:vape_app/Models/User.dart';
import 'package:vape_app/pages/log_list.dart';
import 'package:vape_app/services/auth.dart';
import 'package:vape_app/services/database.dart';
import 'package:provider/provider.dart';
import 'package:vape_app/shared/ReusableFlatButton.dart';

class AllLogs extends StatefulWidget {
  final Function toggleDiary;
  AllLogs({this.toggleDiary});
  @override
  _AllLogsState createState() => _AllLogsState();
}

class _AllLogsState extends State<AllLogs> {


  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final _auth = AuthService();
    return StreamProvider<List<Log>>.value(
          value:DatabaseService(uid:user.uid).logs,
          child: Scaffold(
        appBar: AppBar(
          title: Text('Triggers Log'),
          centerTitle: true,
          actions: <Widget>[
          ResuableFlatButton(
            label: Text(''),
           icon:Icon(Icons.filter_list),//Used as later more filtering options will be added such as sort etc.
          //Allows user to change to reflections
          onPressed: () {
            widget.toggleDiary();
            }),
        
      ],
        ),
        body:LogList())
     
    );
  }
}
