import 'package:flutter/material.dart';
import 'package:vape_app/PodLoader/ProgressBar.dart';
import 'package:vape_app/PodLoader/liquid_custom_progress_indicator.dart';
import 'package:vape_app/services/database.dart';
import 'package:vape_app/Models/Log.dart';
import 'package:vape_app/Models/User.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:vape_app/shared/Calendar.dart';
import 'package:vape_app/shared/Timer.dart';
import '../shared/ReusableFlatButton.dart';
import 'recommendation_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vape_app/services/auth.dart';
import 'package:vape_app/shared/ReusableFlatButton.dart';
import 'recommendation_page.dart';
import 'package:vape_app/services/logs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:vape_app/Models/Trigger.dart';
import 'package:vape_app/pages/recommendation_page.dart';
import 'package:vape_app/services/auth.dart';
import 'package:vape_app/shared/ReusableFlatButton.dart';
import 'package:vape_app/services/logs.dart';

class SettingsHelper extends StatefulWidget {
  @override
  _SettingsHelperState createState() => _SettingsHelperState();
}

class _SettingsHelperState extends State<SettingsHelper> {
  final LogsService _log = LogsService();

  List<DropdownMenuItem<String>> dropdownTriggerItems;
  String selectedTrigger;
  
  @override
  void initState() {
    // dropdownTriggerItems = buildDropdownTriggerItems(_log.getAllTriggers());
    // selectedTrigger = dropdownTriggerItems[0].value;
    super.initState();
  }

  List<DropdownMenuItem<String>> buildDropdownTriggerItems(List triggers) {
    List<DropdownMenuItem<String>> items = List();
    for (Trigger t in triggers) {
      items.add(
        DropdownMenuItem(
          value: t.trigger,
          child: Text(t.trigger),
        ),
      );
    }
    return items;
  }

  onChangeDropdownTriggerItem(String newTrig) {
    setState(() {
      selectedTrigger = newTrig;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _auth = AuthService();
    final triggers = Provider.of<List<Trigger>>(context) ?? [];
    dropdownTriggerItems = buildDropdownTriggerItems(triggers);

    return Scaffold(appBar: AppBar(
      title: Text("Settings"),
      centerTitle: true,
      actions: <Widget>[
        ResuableFlatButton(
          icon: Icon(Icons.person),
          label: Text("Logout"),
          onPressed: () async {
            await _auth.signOut();
          },
        )
      ]),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
        child: SingleChildScrollView(child: Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 200, 0),
            child: Text(
              'Remove a trigger',
              style: TextStyle(
                color: Colors.black,
                letterSpacing: 2.0,
                fontSize: 18,
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Center(
            child: Container(
              child: SizedBox(
                // width: 200,
                child: DropdownButton(
                  value: selectedTrigger,
                  items: dropdownTriggerItems,
                  onChanged: onChangeDropdownTriggerItem,
                ),
              ),
              color: Colors.blue[100]
            ),
          ),

        FlatButton(
          color: Colors.blue,
          child: Text("Remove"),
          onPressed: () {
            _log.deleteTrigger(selectedTrigger);
            setState(() {
              selectedTrigger = dropdownTriggerItems[0].value;
            });
          },
        ),

        SizedBox(
          height: 20.0,
        ),

        
        ],),)
      ),
    );
  }
}