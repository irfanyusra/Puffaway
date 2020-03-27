import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vape_app/Models/User.dart';
import 'package:vape_app/services/database.dart';
import 'package:vape_app/settings/settings_helper.dart';
import 'package:vape_app/shared/loading.dart';
import 'package:vape_app/Models/Log.dart';

import 'UserDataSettings.dart';


class AchievementsHelper extends StatefulWidget {
  @override
  _AchievementsHelperState createState() => _AchievementsHelperState();
}

class _AchievementsHelperState extends State<AchievementsHelper> {
  @override
 Widget build(BuildContext context) {
    //Grab current user
    final user = Provider.of<User>(context);
    if (user != null)
      return StreamProvider<List<Log>>.value(
        value: DatabaseService(uid: user.uid).logs,
        child: UserDataSettings(),
      );
    else
      return Loading();
  }
}

