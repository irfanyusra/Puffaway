import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vape_app/Models/User.dart';
import 'package:vape_app/settings/settings_helper.dart';
import 'package:vape_app/shared/loading.dart';

class UserDataSettings extends StatefulWidget {
  @override
  _UserDataSettingsState createState() => _UserDataSettingsState();
}

class _UserDataSettingsState extends State<UserDataSettings> {
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserData>(context);
    
    if (userData != null)
      return SettingsHelper(name: userData.name, goal: userData.goal);
    else
      return Loading();
  }
}
