import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vape_app/Models/Log.dart';
import 'package:vape_app/Models/User.dart';
import 'package:vape_app/pages/log_list.dart';
import 'package:vape_app/services/auth.dart';
import 'package:vape_app/services/database.dart';
import 'package:provider/provider.dart';
import 'package:vape_app/shared/logout.dart';

class AllLogs extends StatefulWidget {
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
            //Custom app bar 
            appBar: LogOutAppBar(
              title: Text('All Logs'),
              centerTitle: true,
              auth:_auth,
      ),
              body:LogList())
     
    );
  }
}
