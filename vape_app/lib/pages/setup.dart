import 'package:flutter/material.dart';
import 'package:vape_app/shared/constants.dart';
//TODO: fix recommendations 
//TODO: fix textfield and buttons 
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
                  // style: new TextStyle(fontSize: 20.0),
                  key: Key('name-field'),
                  controller: nameTextController,
                  decoration: new InputDecoration(
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(20.0),
                      borderSide: new BorderSide(),
                    ),
                    hintText: 'Name',
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextField(
                  onTap: () => _selectDate(context),
                  // style: new TextStyle(fontSize: 20.0),
                  key: Key('dob-field'),
                  focusNode: AlwaysDisabledFocusNode(),
                  controller: dobTextController,
                  decoration: new InputDecoration(
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(20.0),
                      borderSide: new BorderSide(),
                    ),
                    hintText: 'Date of Birth',
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextField(
                  key: Key('goal-field'),
                  // style: new TextStyle(fontSize: 20.0),
                  keyboardType: TextInputType.number,
                  controller: goalTextController,
                  decoration: new InputDecoration(
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(20.0),
                      borderSide: new BorderSide(),
                    ),
                    hintText: 'Goal in days',
                  ),
                ),
                SizedBox(
                  height: 40.0,
                ),
                TextField(
                  key: Key('trigger-field'),
                  controller: triggerTextController,
                  decoration: new InputDecoration(
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(20.0),
                      borderSide: new BorderSide(),
                    ),
                    hintText: 'Add custom trigger',
                    // suffixIcon: IconButton(
                    //     icon: Icon(Icons.add),
                    //     onPressed: () {
                    //       triggerTextController.text = "";
                    //       //add it to the database here
                    //     }),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextField(
                  key: Key('recommendation-field'),
                  controller: recommendationTextController,
                  decoration: new InputDecoration(
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(20.0),
                      borderSide: new BorderSide(),
                    ),
                    hintText: 'Add custom recommendation',
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                FlatButton(
                  child: Text(
                    'Add ',
                    style: new TextStyle(fontSize: 20.0, color: Colors.blue),
                  ),
                  color: Colors.grey[200],
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                      side: BorderSide(color: Colors.blue)),
                  onPressed: () {
                    triggerTextController.text = "";
                    recommendationTextController.text = "";
                    print("Add pressed");
                    Scaffold.of(context)
                    .showSnackBar(SnackBar(content: Text("Trigger added"),duration:Duration(milliseconds: 500)));
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                FlatButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Next ',
                        style:
                            new TextStyle(fontSize: 20.0, color: Colors.blue),
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
          ),
        ),
      ),
    );
  }
}
