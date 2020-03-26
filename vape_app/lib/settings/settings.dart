import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vape_app/Models/User.dart';
import 'package:vape_app/services/database.dart';
import 'package:vape_app/shared/loading.dart';

import 'UserDataSettings.dart';
import 'achievements_helper.dart';

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
    if (user != null)
      return StreamProvider<UserData>.value(
        value: DatabaseService(uid: user.uid).userData,
        child: AchievementsHelper(),
      );
    else
      return Loading();
  }
}
