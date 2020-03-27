import 'package:flutter/material.dart';
import 'package:vape_app/services/logs.dart';
import 'package:vape_app/shared/constants.dart';

//TODO: fix recommendations
class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

class Setup extends StatefulWidget {
  @override
  _SetupState createState() => _SetupState();
}

class _SetupState extends State<Setup> {
  //Used to retrieve name and goal from text fields
  String name = '';
  String goal = '';
  String dob = "Date of Birth";
  DateTime selectedDate = DateTime.now();
  final nameTextController = TextEditingController();
  final goalTextController = TextEditingController();
  final dobTextController = TextEditingController();
  final triggerTextController = TextEditingController();
  final recommendationTextController = TextEditingController();
  LogsService _log = LogsService();

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

  final String helpText = 
    "The \"Goal in days\" field is where you set how many days you want to go without vaping. We recommend you start with 1 day without vaping, and then slowly increase your goal.\n\n"
    "You can also add your personal vape triggers. These triggers will be available when logging your vape habit.";

  void showHelp() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Help"),
          content: new Text(helpText),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Setup'),
        centerTitle: true,
      ),
      body: Builder(
        builder: (context) => Padding(
          padding: const EdgeInsets.fromLTRB(25, 25, 25, 20),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  key: Key('name-field'),
                  style: textFieldStyle,
                  controller: nameTextController,
                  decoration: inputDecoration.copyWith(hintText: 'Name'),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextField(
                  onTap: () => _selectDate(context),
                  style: textFieldStyle,
                  key: Key('dob-field'),
                  focusNode: AlwaysDisabledFocusNode(),
                  controller: dobTextController,
                  decoration:
                      inputDecoration.copyWith(hintText: 'Date of Birth'),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextField(
                  key: Key('goal-field'),
                  keyboardType: TextInputType.number,
                  style: textFieldStyle,
                  controller: goalTextController,
                  decoration:
                      inputDecoration.copyWith(hintText: 'Goal in days'),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextField(
                  key: Key('trigger-field'),
                  controller: triggerTextController,
                  decoration: inputDecoration.copyWith(
                    hintText: 'Add custom trigger',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.add, key: Key("save-trigger-btn")),
                      onPressed: () async {
                        await _log.createTrigger(triggerTextController.text);
                        triggerTextController.text = "";
                        //add it to the database here
                        print("Add pressed");
                        Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text("Trigger added"),
                            duration: Duration(milliseconds: 500)));
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlatButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Help ",
                            style: TextStyle(fontSize: 20, color: Colors.blue),
                          ),
                          Icon(
                            Icons.help,
                            color: Colors.blue,
                          ),
                          
                        ],
                      ),
                      onPressed: showHelp,
                    ),
                    FlatButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Next ',
                            style: TextStyle(fontSize: 20.0, color: Colors.blue),
                            key: Key("next-btn")
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.blue,
                          ),
                        ],
                      ),
                      onPressed: () => print("next pressed"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
