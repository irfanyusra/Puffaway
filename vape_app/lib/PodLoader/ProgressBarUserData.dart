import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vape_app/Models/User.dart';
import 'package:vape_app/PodLoader/ProgressBar.dart';
import 'package:vape_app/services/database.dart';
import 'package:vape_app/shared/loading.dart';

class ProgressBarUserData extends StatefulWidget {
  @override
  _ProgressBarUserDataState createState() => _ProgressBarUserDataState();
}

class _ProgressBarUserDataState extends State<ProgressBarUserData> {

  
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user != null)
      return StreamProvider<UserData>.value(
        value: DatabaseService(uid: user.uid).userData,
        child: ProgressBar(),
      );
    else
      return Loading();
  }
  }