//TODO: fix all the text fields and buttons (after abdulaziz is done)
// import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:vape_app/Models/User.dart';
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
  SettingsHelper({this.name, this.goal});
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
  String dob = "Date of Birth";
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
        achievementButton = "Show Achievements";
      } else {
        achievementButton = "Hide Achievements";
      }
    });
  }

  setupBadges(logs) {
    if (logs != null) {
      setState(() {
        var lastHitTime = logs.length > 0
            ? DateTime.parse(logs.first.dateTime.toDate().toString())
            : new DateTime.now(); //last log time goes here
        var current = new DateTime.now();
        var diff = current.difference(lastHitTime);

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

  toggleNotifications() {
    setState(() {
      if (notifText == "Turn off notifications") {
        notifText = "Turn on notifications";
      } else {
        notifText = "Turn off notifications";
      }
    });
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1900),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        dob = "${selectedDate.toLocal()}".split(' ')[0];
        dobTextController.text = dob;
      });
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
    //dobTextController = widget.dob;
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
            appBar: AppBar(
                title: Text("User Settings"),
                centerTitle: true,
                actions: <Widget>[
                  ResuableFlatButton(
                    icon: Icon(Icons.person),
                    label: Text("Logout"),
                    onPressed: () async {
                      Navigator.pop(context);
                      await _auth.signOut();
                    },
                  )
                ]),

            //page body
            body: Padding(
                padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      //PERSONAL INFORMATION//
                      Center(
                        child: Text(
                          'Personal Information',
                          style: TextStyle(
                            color: Colors.black,
                            letterSpacing: 2.0,
                            fontSize: 20,
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 160, 0),
                        child: TextField(
                          controller: nameTextController,
                          style: TextStyle(fontSize: 20),
                          decoration: InputDecoration(
                              hintText: 'Name',
                              contentPadding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
                          onChanged: (name) async {
                            //Update name in database
                            await _auth.updateUserData(
                                name, userData.goal, userData.token);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 7, 160, 0),
                        child: TextField(
                          onTap: () => _selectDate(context),
                          style: new TextStyle(fontSize: 20.0),
                          key: Key('dob-field'),
                          focusNode: AlwaysDisabledFocusNode(),
                          controller: dobTextController,
                          decoration: new InputDecoration(
                              hintText: 'Date of Birth',
                              contentPadding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 210, 0),
                        child: FlatButton(
                            color: Colors.blue,
                            child: Text(notifText),
                            onPressed: toggleNotifications),
                      ),

                      SizedBox(height: 10),

                      Center(
                        child: Text(
                          'Goal Information',
                          style: TextStyle(
                            color: Colors.black,
                            letterSpacing: 2.0,
                            fontSize: 20,
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 50, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 18, 0, 0),
                                child: Text("My goal is for one pod to last:",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    )),
                              ),
                            ),
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(50, 0, 0, 0),
                                child: Form(
                                  key: goalKey,
                                  child: TextFormField(
                                    keyboardType:
                                        TextInputType.numberWithOptions(),
                                    controller: goalTextController,
                                    decoration: InputDecoration(
                                        contentPadding:
                                            EdgeInsets.fromLTRB(0, 20, 0, 0),
                                        errorStyle: TextStyle(height: 0)),
                                    onChanged: (goal) async {
                                      //SEND GOAL TO DB
                                      if (goalKey.currentState.validate()) {
                                        await _auth.updateUserData(
                                            userData.name,
                                            goal,
                                            userData.token);
                                      }
                                    },
                                    validator: (goal) {
                                      if (!RegExp(r"^[1-9]+[0-9]*$")
                                          .hasMatch(goal)) {
                                        return '';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 18, 0, 0),
                                child: Text("days",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    )),
                              ),
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
                                  icon: Icon(Icons.add,
                                      key: Key("save-trigger-btn")),
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

                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                          child: Container(
                            width: 165,
                            child: FlatButton(
                              color: Colors.blue,
                              child: Text(achievementButton),
                              onPressed: toggleAchievements,
                            ),
                          ),
                        ),
                      ),

                      // Visibility(
                      //   visible: !triggerVisibility,
                      //   child: Padding(
                      //     padding: const EdgeInsets.fromLTRB(0, 8, 220, 0),
                      //     child: FlatButton(
                      //       color: Colors.blue,
                      //       child: Text("Add custom trigger"),
                      //       onPressed: toggleTrigger,
                      //     ),
                      //   ),
                      // ),

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

                      //ADD A TRIGGER//
                      Visibility(
                        visible: !triggerVisibility,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(2, 0, 220, 0),
                          child: FlatButton(
                            color: Colors.blue,
                            child: Text("Add custom trigger"),
                            onPressed: toggleTrigger,
                          ),
                        ),
                      ),
                      Visibility(
                        visible: triggerVisibility,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                          child: TextField(
                            key: Key('thought-field'),
                            controller: triggerTextController,
                            maxLines: 1,
                            decoration: new InputDecoration(
                              border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(25.0),
                                borderSide: new BorderSide(),
                              ),
                              hintText: 'Add your trigger',
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: triggerVisibility,
                        child: SizedBox(height: 4),
                      ),
                      Visibility(
                        visible: triggerVisibility,
                        child: TextField(
                          key: Key('thought-field'),
                          controller: triggerTextController,
                          maxLines: 2,
                          decoration: new InputDecoration(
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(25.0),
                              borderSide: new BorderSide(),
                            ),
                            hintText: 'Pair a reccomendation with the trigger',
                          ),
                        ),
                      ),
                      Visibility(
                        visible: triggerVisibility,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            FlatButton(
                                color: Colors.blue,
                                child: Text('Cancel'),
                                onPressed: toggleTrigger),
                            SizedBox(width: 5),
                            FlatButton(
                              key: (Key('save-trigger-btn')),
                              color: Colors.blue,
                              child: Text('Add'),
                              onPressed: () async {
                                toggleTrigger();
                                await _log
                                    .createTrigger(triggerTextController.text);
                                setState(() {
                                  triggerTextController.text = "";
                                  selectedTrigger =
                                      dropdownTriggerItems[0].value;
                                });
                              },
                            ),
                          ],
                        ),
                      ),

                      //FOOTER//
                      //Expanded(child: Container(),),
                      Column(
                        children: <Widget>[
                          FlatButton(
                            color: Colors.blue,
                            child: Text("Instructions"),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute<void>(
                                      builder: (context) => FourStepSoln()));
                            },
                          ),
                          Text("Made with ♥️ by Team 50"),
                        ],
                      ),

                      SizedBox(height: 10),
                    ],
                  ),
                )),
          );
        } else {
          return Loading();
        }
      },
    );
  }
}
