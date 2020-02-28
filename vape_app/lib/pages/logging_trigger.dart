import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vape_app/services/logs.dart';

class LoggingTrigger extends StatefulWidget {
  @override
  _LoggingTriggerState createState() => _LoggingTriggerState();
}

class _LoggingTriggerState extends State<LoggingTrigger> {

  final LogsService _log = LogsService();
  @override
  List<String> triggers = [
    'Select one',
    'trigger1',
    'trigger2',
    'trigger3',
    'trigger4'
  ];

  List<DropdownMenuItem<String>> dropdownTriggerItems;
  String selectedTrigger;
  String thoughts;

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
    dropdownTriggerItems = buildDropdownTriggerItems(triggers);
    selectedTrigger = dropdownTriggerItems[0].value;
    super.initState();
  }

  List<DropdownMenuItem<String>> buildDropdownTriggerItems(List triggers) {
    List<DropdownMenuItem<String>> items = List();
    for (String t in triggers) {
      items.add(
        DropdownMenuItem(
          value: t,
          child: Text(t),
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Log your trigger'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                child: Text(
                  'To quit a habit, it is crucial that you practice self awareness. Please help us help you by logging what triggered your session',
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
              //TODO: Make the trigger drop down rounded rect
              Container(
                child: SizedBox(
                  width: 200,
                  child: Center(
                    child: DropdownButton(
                      value: selectedTrigger,
                      items: dropdownTriggerItems,
                      onChanged: onChangeDropdownTriggerItem,
                    ),
                  ),
                ),
                color: Colors.blue[100],
              ),
              SizedBox(
                height: 20.0,
              ),
              //TODO: remove text container later
              Container(child: Text('Selected: $selectedTrigger')),
              SizedBox(
                height: 25.0,
              ),
              Container(
                child: Text(
                  'Another important step is writing down your thoughts. If there is anything special about this session please feel free to log this as well',
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
//                color: Colors.grey[300],
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
              FlatButton(
                color: Colors.blue,
                child: Text('Next'),
                onPressed: () async {
                  dynamic result = await _log.loggingVape(selectedTrigger,thoughtTextController.text);
                  Navigator.pushNamed(context, '/recommendations', arguments: {
                    'thoughts': thoughtTextController.text,
                    'trigger': selectedTrigger,
                  });

//                  print(thoughtTextController.text);

                  //TODO: Remove when the thought display is removed
                  setState(() {
                    thoughtTextController.text = thoughtTextController.text;
                    thoughts = thoughtTextController.text;
                  });
                },
              ),
              Container(
                child: Text(
                  '${thoughtTextController.text}',
                  style: TextStyle(
                    color: Colors.black,
                    letterSpacing: 2.0,
                    fontSize: 18,
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
