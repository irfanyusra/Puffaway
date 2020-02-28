import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddTrigger extends StatefulWidget {
  @override
  _AddTriggerState createState() => _AddTriggerState();
}

class _AddTriggerState extends State<AddTrigger> {

  final addTriggerTextController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    addTriggerTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text('Add Trigger'),
    centerTitle: true,
    ),
    body: Center(child: SafeArea(
    child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Container(
        child: Text(
          'Add a new Trigger: ',
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
                  controller: addTriggerTextController,
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
      SizedBox(
        height: 20.0,
      ),
      Container(
        child: Text(
          'Adding: ${addTriggerTextController.text}',
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
    FlatButton(
    color: Colors.blue,
    child: Text('Add trigger'),
      onPressed: () {
        setState(() {
          addTriggerTextController.text = addTriggerTextController.text;
        });
      },
    ),
    ]
    ))
    ));
  }
}
