import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vape_app/Models/User.dart';
import 'package:vape_app/pages/setup_helper.dart';
import 'package:vape_app/services/database.dart';
import 'package:vape_app/settings/settings_helper.dart';
import 'package:vape_app/shared/loading.dart';


//Widget used to get the triggers from the stream and send to LogsPageHelper()
//Where the data will be displayed
class Setup extends StatefulWidget {
  @override
  _SetupState createState() => _SetupState();
}

class _SetupState extends State<Setup> {
  @override
  Widget build(BuildContext context) {
    //Grab current user
    final user = Provider.of<User>(context);
    if (user != null){
      return StreamProvider<UserData>.value(
        value: DatabaseService(uid: user.uid).userData,
        child: SetupHelper(),
      );}
    else{
      return Loading();
    }
  }
}
