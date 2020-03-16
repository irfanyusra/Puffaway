import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vape_app/Models/Trigger.dart';
import 'package:vape_app/Models/User.dart';
import 'package:vape_app/services/database.dart';
import 'package:vape_app/pages/settings_helper.dart';

import '../shared/loading.dart';

//Widget used to get the triggers from the stream and send to LogsPageHelper()
//Where the data will be displayed
class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    //Grab current user
    final user = Provider.of<User>(context);

    if(user!=null)
    return StreamProvider<List<Trigger>>.value(
      value:DatabaseService(uid: user.uid).triggers,
      child:SettingsHelper()
    );
    else{
      return Loading();
    }
  }
}

