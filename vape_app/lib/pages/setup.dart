import 'package:flutter/material.dart';
import 'package:vape_app/shared/constants.dart';

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
      body: Padding(
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
                height: 20.0,
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
                  suffixIcon: IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        triggerTextController.text = "";
                        //add it to the database here
                      }),
                ),
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
                      style: new TextStyle(fontSize: 20.0, color: Colors.blue),
                    ),
                    Icon(Icons.arrow_forward_ios,
                    color: Colors.blue,),
                  ],
                ),
                onPressed: () => print("next pressed"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
