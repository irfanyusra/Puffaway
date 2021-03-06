//TODO: fix all the text fields and buttons (after abdulaziz is done)
// import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:vape_app/Models/User.dart';
import 'package:vape_app/helper_functions/validation.dart';
import 'package:vape_app/pages/four_step_soln.dart';
import 'package:vape_app/services/database.dart';
import 'package:vape_app/shared/constants.dart';
import 'package:vape_app/shared/loading.dart';
import '../shared/ReusableFlatButton.dart';
import 'package:flutter/widgets.dart';
import 'package:vape_app/services/auth.dart';
import 'package:vape_app/shared/ReusableFlatButton.dart';
import 'package:vape_app/services/logs.dart';
import 'package:vape_app/Models/Trigger.dart';
import 'package:vape_app/Models/Log.dart';

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

class SettingsHelper extends StatefulWidget {
  //Getting these from the Settings widget
  final String name;
  final String goal;
  final String dob;

  SettingsHelper({this.name, this.goal, this.dob});
  @override
  _SettingsHelperState createState() => _SettingsHelperState();
}

class _SettingsHelperState extends State<SettingsHelper> {
  final LogsService _log = LogsService();

  List<DropdownMenuItem<String>> dropdownTriggerItems;
  String selectedTrigger;
  String notifText = "Turn off notifications";

  final triggerTextController = TextEditingController();
  final nameTextController = TextEditingController();
  final goalTextController = TextEditingController();
  final goalKey = GlobalKey<FormState>();

  bool triggerVisibility = false;

  //calendar variables
  DateTime selectedDate = DateTime.now();
  // String dob = "Date of Birth";
  final dobTextController = TextEditingController();

  //badges variables
  List<String> achievementStrings = [
    "badges/1g.png",
    "badges/2g.png",
    "badges/3g.png",
    "badges/4g.png",
    "badges/5g.png",
    "badges/6g.png",
    "badges/7g.png",
    "badges/8g.png",
    "badges/9g.png"
  ];
  bool achievementVisibility = false;
  String achievementButton = "Show Achievements";

  toggleAchievements() {
    setState(() {
      achievementVisibility = !achievementVisibility;

      if (achievementVisibility) {
        achievementButton = "Hide Achievements";
        triggerVisibility = false;
      } else {
        achievementButton = "Show Achievements";
      }
    });
  }

  setupBadges(logs) {
    if (logs != null) {
      setState(() {
        var diff = differenceInTimeLastHitAndNow(logs);
        if (diff.inDays > 181) {
          achievementStrings = [
            "badges/1.png",
            "badges/2.png",
            "badges/3.png",
            "badges/4.png",
            "badges/5.png",
            "badges/6.png",
            "badges/7.png",
            "badges/8.png",
            "badges/9.png"
          ];
        } else if (diff.inDays > 91) {
          achievementStrings = [
            "badges/1.png",
            "badges/2.png",
            "badges/3.png",
            "badges/4.png",
            "badges/5.png",
            "badges/6.png",
            "badges/7.png",
            "badges/8.png",
            "badges/9g.png"
          ];
        } else if (diff.inDays > 29) {
          achievementStrings = [
            "badges/1.png",
            "badges/2.png",
            "badges/3.png",
            "badges/4.png",
            "badges/5.png",
            "badges/6.png",
            "badges/7.png",
            "badges/8g.png",
            "badges/9g.png"
          ];
        } else if (diff.inDays > 20) {
          achievementStrings = [
            "badges/1.png",
            "badges/2.png",
            "badges/3.png",
            "badges/4.png",
            "badges/5.png",
            "badges/6.png",
            "badges/7g.png",
            "badges/8g.png",
            "badges/9g.png"
          ];
        } else if (diff.inDays > 13) {
          achievementStrings = [
            "badges/1.png",
            "badges/2.png",
            "badges/3.png",
            "badges/4.png",
            "badges/5.png",
            "badges/6g.png",
            "badges/7g.png",
            "badges/8g.png",
            "badges/9g.png"
          ];
        } else if (diff.inDays > 6) {
          achievementStrings = [
            "badges/1.png",
            "badges/2.png",
            "badges/3.png",
            "badges/4.png",
            "badges/5g.png",
            "badges/6g.png",
            "badges/7g.png",
            "badges/8g.png",
            "badges/9g.png"
          ];
        } else if (diff.inDays > 4) {
          achievementStrings = [
            "badges/1.png",
            "badges/2.png",
            "badges/3.png",
            "badges/4g.png",
            "badges/5g.png",
            "badges/6g.png",
            "badges/7g.png",
            "badges/8g.png",
            "badges/9g.png"
          ];
        } else if (diff.inDays > 2) {
          achievementStrings = [
            "badges/1.png",
            "badges/2.png",
            "badges/3g.png",
            "badges/4g.png",
            "badges/5g.png",
            "badges/6g.png",
            "badges/7g.png",
            "badges/8g.png",
            "badges/9g.png"
          ];
        } else if (diff.inDays > 0) {
          achievementStrings = [
            "badges/1.png",
            "badges/2g.png",
            "badges/3g.png",
            "badges/4g.png",
            "badges/5g.png",
            "badges/6g.png",
            "badges/7g.png",
            "badges/8g.png",
            "badges/9g.png"
          ];
        } else {
          achievementStrings = [
            "badges/1g.png",
            "badges/2g.png",
            "badges/3g.png",
            "badges/4g.png",
            "badges/5g.png",
            "badges/6g.png",
            "badges/7g.png",
            "badges/8g.png",
            "badges/9g.png"
          ];
        }
      });
    }
  }

  // toggleNotifications() {
  //   setState(() {
  //     if (notifText == "Turn off notifications") {
  //       notifText = "Turn on notifications";
  //     } else {
  //       notifText = "Turn off notifications";
  //     }
  //   });
  // }

  Future<DateTime> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1900),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        dobTextController.text = "${selectedDate.toLocal()}".split(' ')[0];
      });
    return picked;
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    triggerTextController.dispose();
    nameTextController.dispose();
    dobTextController.dispose();
    goalTextController.dispose();
    super.dispose();
  }

  void initState() {
    super.initState();
    nameTextController.text = widget.name;
    dobTextController.text = widget.dob;
    print(widget.dob);
    print(dobTextController.text);

    goalTextController.text = widget.goal;
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

  toggleTrigger() {
    setState(() {
      triggerVisibility = !triggerVisibility;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _auth = AuthService();
    var appBar = AppBar(
        title: Text("Profile Settings"),
        centerTitle: true,
        actions: <Widget>[
          ResuableFlatButton(
            icon: Icon(Icons.person),
            label: Text("Logout", key: Key("logout-btn")),
            onPressed: () async {
              Navigator.pop(context);
              await _auth.signOut();
            },
          )
        ]);
    var _pageSize = MediaQuery.of(context).size.height;
    var _notifySize = MediaQuery.of(context).padding.top;
    var _appBarSize = appBar.preferredSize.height;

    final user = Provider.of<User>(context);
    final userData = Provider.of<UserData>(context);
    final logs = Provider.of<List<Log>>(context) ?? [];
    setupBadges(logs);

    return StreamBuilder<List<Trigger>>(
      stream: DatabaseService(uid: user.uid).triggers,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          //Grab the user data from the stream builder
          List<Trigger> triggers = snapshot.data;
          dropdownTriggerItems = buildDropdownTriggerItems(triggers);

          return Scaffold(
            //header
            appBar: appBar,
            //page body
            body: SingleChildScrollView(
              child: Container(
                height: _pageSize - (_appBarSize + _notifySize),
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Builder(
                  builder: (context) => Column(
                    children: <Widget>[
                      //to hide when acheivements are open
                      Visibility(
                        visible: !achievementVisibility,
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: 20),
                            //PERSONAL INFORMATION//
                            Center(
                              child: Text(
                                'Personal Information',
                                style: textStyle,
                              ),
                            ),
                            SizedBox(height: 15),
                            TextField(
                              controller: nameTextController,
                              style: textFieldStyle,
                              decoration: textInputDecoration.copyWith(
                                  hintText: 'Name'),
                              onChanged: (name) async {
                                //Update name in database
                                await _auth.updateUserData(name, userData.goal,
                                    userData.dob, userData.token);
                              },
                            ),
                            SizedBox(height: 10),
                            TextField(
                              onTap: () async {
                                DateTime picked = await _selectDate(context);
                                if(picked!=null)
                                await _auth.updateUserData(
                                    userData.name,
                                    userData.goal,
                                  DateFormat('yyyy-MM-dd').format(picked),
                                    userData.token);
                              },
                              style: textFieldStyle,
                              key: Key('dob-field'),
                              focusNode: AlwaysDisabledFocusNode(),
                              controller: dobTextController,
                              decoration: textInputDecoration.copyWith(
                                  hintText: 'Date of Birth'),
                              onChanged: (dob) async {
                                //print("dob");
                                //Update name in database
                                await _auth.updateUserData(userData.name,
                                    userData.goal, dob, userData.token);
                              },
                            ),
                            SizedBox(height: 15),
                            // buttonThemeAuth(
                            //   context,
                            //   RaisedButton(
                            //       elevation: 5.0,
                            //       color: Colors.blue,
                            //       child: Text(notifText),
                            //       onPressed: toggleNotifications),
                            // ),
                            SizedBox(height: 30),
                            Center(
                              child: Text(
                                'Goal Information',
                                style: textStyle,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 18, 0, 0),
                                    child:
                                        Text("My goal is for one pod to last:",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                            )),
                                  ),
                                ),
                                Flexible(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(50, 0, 0, 0),
                                    child: Form(
                                      key: goalKey,
                                      child: TextFormField(
                                        keyboardType:
                                            TextInputType.numberWithOptions(),
                                        controller: goalTextController,
                                        decoration: InputDecoration(
                                            contentPadding: EdgeInsets.fromLTRB(
                                                0, 20, 0, 0),
                                            errorStyle: TextStyle(height: 0)),
                                        onChanged: (goal) async {
                                          //SEND GOAL TO DB
                                          if (goalKey.currentState.validate()) {
                                            await _auth.updateUserData(
                                                userData.name,
                                                goal,
                                                userData.dob,
                                                userData.token);
                                          }
                                        },
                                        validator: GoalFieldValidator.validate,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 18, 0, 0),
                                    child: Text("days",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                        )),
                                  ),
                                ),
                              ],
                            ),
                            //     ),
                            SizedBox(height: 20),
                            TextField(
                              key: Key('add-trigger-field'),
                              controller: triggerTextController,
                              style: textFieldStyle,
                              decoration: inputDecoration.copyWith(
                                hintText: 'Add custom trigger',
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.add, key: Key("save-trigger-btn")),
                                  onPressed: () async {
                                    print("Add pressed");
                                    await _log.createTrigger(
                                        triggerTextController.text);
                                    setState(() {
                                      triggerTextController.text = "";
                                      selectedTrigger =
                                          dropdownTriggerItems[0].value;
                                    });
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                        content: Text("Trigger added"),
                                        duration: Duration(milliseconds: 500)));
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 20),
                      //acheivement button
                      buttonThemeAuth(
                          context,
                          FlatButton(
                            color: Colors.blue,
                            child: Text(achievementButton),
                            onPressed: toggleAchievements,
                          )),
                      //achievement badges
                      Visibility(
                        visible: achievementVisibility,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Image(
                                    image: AssetImage(achievementStrings[0]),
                                    height: 50,
                                  ),
                                  Image(
                                    image: AssetImage(achievementStrings[1]),
                                    height: 50,
                                  ),
                                  Image(
                                    image: AssetImage(achievementStrings[2]),
                                    height: 50,
                                  ),
                                  Image(
                                    image: AssetImage(achievementStrings[3]),
                                    height: 50,
                                  ),
                                ]),
                            Container(
                              width: 240,
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Image(
                                      image: AssetImage(achievementStrings[4]),
                                      height: 55,
                                    ),
                                    Image(
                                      image: AssetImage(achievementStrings[5]),
                                      height: 55,
                                    ),
                                    Image(
                                      image: AssetImage(achievementStrings[6]),
                                      height: 55,
                                    ),
                                  ]),
                            ),
                            Container(
                              width: 145,
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Image(
                                      image: AssetImage(achievementStrings[7]),
                                      height: 60,
                                    ),
                                    Image(
                                      image: AssetImage(achievementStrings[8]),
                                      height: 60,
                                    ),
                                  ]),
                            )
                          ],
                        ),
                      ),

                      //     //FOOTER//
                      Expanded(child: Container()),
                      buttonThemeAuth(
                          context,
                          FlatButton(
                            color: Colors.blue,
                            child: Text("Instructions"),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute<void>(
                                      builder: (context) => FourStepSoln()));
                            },
                          )),
                      SizedBox(height: 20),
                      Text("Made with ♥️ by Team 50"),
                      SizedBox(height: 20),
                    ],
                    //
                  ),
                ),
              ),
            ),
          );
        } else {
          return Loading();
        }
      },
    );
  }
}
