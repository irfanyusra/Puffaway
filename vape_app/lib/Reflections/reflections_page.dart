//TODO: mmodularize text fields and btns
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vape_app/services/reflections.dart';
import 'package:vape_app/shared/constants.dart';

class Reflections extends StatefulWidget {
  @override
  _ReflectionsState createState() => _ReflectionsState();
}

class _ReflectionsState extends State<Reflections> {
  final stressorTextController = TextEditingController();
  final progressTextController = TextEditingController();

  void dispose() {
    // Clean up the controller when the widget is disposed.
    stressorTextController.dispose();
    progressTextController.dispose();
    super.dispose();
  }

  Map data = {};

  final ReflectionsService _reflection = ReflectionsService();
  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Reflection'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                child: Text(
                  'Every so often we need to revalue the things we do in our lives. Please take this time to write your thoughts about the prompts below',
                  style: TextStyle(
                    color: Colors.black,
                    letterSpacing: 2.0,
                    fontSize: 18,
                  ),
                ),
              ),
              SizedBox(height: 15.0),
              Container(
                child: Text(
                  'What stressors did you feel today?',
                  style: TextStyle(
                    color: Colors.black,
                    letterSpacing: 2.0,
                    fontSize: 18,
                  ),
                ),
              ),
              Container(
                height: 150,
                padding: EdgeInsets.all(10.0),
                child: new ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 130.0,
                  ),
                  child: new Scrollbar(
                    child: new SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      reverse: true,
                      child: SizedBox(
                        height: 130.0,
                        child: new TextField(
                          key: Key('stressors-field'),
                          controller: stressorTextController,
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
              SizedBox(height: 10.0),
              Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    'How do you feel about your progress so far?',
                    style: TextStyle(
                      color: Colors.black,
                      letterSpacing: 2.0,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              Container(
                height: 150,
                padding: EdgeInsets.all(10.0),
                child: new ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 120.0,
                  ),
                  child: new Scrollbar(
                    child: new SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      reverse: true,
                      child: SizedBox(
                        height: 120.0,
                        child: new TextField(
                          key: Key('progress-field'),
                          controller: progressTextController,
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
              SizedBox(height: 5.0),
              Container(
                alignment: Alignment.bottomCenter,
                margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: buttonThemeAuth(
                  context,
                  FlatButton(
                    key: Key('save-reflection-btn'),
                    color: Colors.blue,
                    child: Text('Save Reflection',
                        style: fieldStyle.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                    onPressed: () async {
                      await _reflection.documentReflection(
                          stressorTextController.text,
                          progressTextController.text);
                      setState(() {
                        progressTextController.text = "";
                        stressorTextController.text = "";
                      });
                      Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text("Reflection added"),
                          duration: Duration(milliseconds: 1000)));
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
