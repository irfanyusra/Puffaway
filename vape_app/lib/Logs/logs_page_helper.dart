import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:vape_app/Models/Trigger.dart';
import 'package:vape_app/pages/recommendation_page.dart';
import 'package:vape_app/services/auth.dart';
import 'package:vape_app/shared/ReusableFlatButton.dart';
import 'package:vape_app/services/logs.dart';
import 'package:vape_app/shared/constants.dart';

class LogsPageHelper extends StatefulWidget {
  @override
  LogsPageHelperState createState() => LogsPageHelperState();
}

class LogsPageHelperState extends State<LogsPageHelper> {
  final LogsService _log = LogsService();

  // List<String> triggers = [
  //   'Select one',
  //   'Time of day',
  //   'Wake-up routine',
  //   'Boredom',
  //   'Vape smell',
  //   'Stress',
  //   'Seeing someone vaping',
  //   'Fatigue',
  //   'Partying',
  //   'Sex'
  // ];

  List<DropdownMenuItem<String>> dropdownTriggerItems;
  String selectedTrigger;

  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final thoughtTextController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    thoughtTextController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // dropdownTriggerItems = buildDropdownTriggerItems(triggers);
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

  Widget build(BuildContext context) {
    //Retrieve trigger using getter function
    final triggers = Provider.of<List<Trigger>>(context) ?? [];
    final _auth = AuthService();

    dropdownTriggerItems = buildDropdownTriggerItems(triggers);

    return Scaffold(
      appBar: AppBar(
        key: Key('log-trigger-page'),
        title: Text('Log Session'),
        centerTitle: true,
        // actions: <Widget>[
        //   ResuableFlatButton(
        //       icon: Icon(Icons.person),
        //       label: Text('Logout'),
        //       onPressed: () async {
        //         await _auth.signOut();
        //       }), //signout button
        // ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                child: Text(
                  'To quit a habit, it is crucial that you practice self awareness.',
                  style: TextStyle(
                    color: Colors.black,
                    letterSpacing: 2.0,
                    fontSize: 18,
                  ),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Container(
                child: Text(
                  'What triggered your session?',
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
              Container(
                child: Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      color: Colors.blue[100],
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(
                          color: Colors.blue[100],
                          style: BorderStyle.solid,
                          width: 0.80),
                    ),
                    child: DropdownButton(
                        value: selectedTrigger,
                        items: dropdownTriggerItems,
                        onChanged: onChangeDropdownTriggerItem,
                        hint: new Text("Select one")),
                  ),
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
              Container(
                child: Text(
                  'What were you thinking or feeling?', //If there is anything special about this session please feel free to log this as well
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

              Container(
                height: 170,
                padding: EdgeInsets.all(10.0),
                child: new ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 150.0,
                  ),
                  child: new Scrollbar(
                    child: new SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      reverse: true,
                      child: SizedBox(
                        height: 150.0,
                        child: new TextField(
                          key: Key('thought-field'),
                          controller: thoughtTextController,
                          maxLines: 10,
                          decoration: new InputDecoration(
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(25.0),
                              borderSide: new BorderSide(),
                            ),
                            hintText: 'Add your text here',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: buttonThemeAuth(
                  context,
                  FlatButton(
                    
                    key: (Key('save-trigger-btn')),
                    color: Colors.blue,
                    child: Text('Log Trigger',
                        textAlign: TextAlign.center,
                        style: fieldStyle.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                    onPressed: () async {
                      dynamic result = await _log.documentLog(
                          selectedTrigger, thoughtTextController.text);
                      Navigator.push(
                          context,
                          new MaterialPageRoute<void>(
                              builder: (context) => Recommendation()));

                      setState(() {
                        thoughtTextController.text = "";
                        selectedTrigger = dropdownTriggerItems[0].value;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
