import 'package:flutter/material.dart';

class Logging extends StatefulWidget {
  @override
  _LoggingState createState() => _LoggingState();
}

class _LoggingState extends State<Logging> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: SafeArea(child: FlatButton(
        color:  Colors.blue,
        child: Text('Log your trigger'),
      ),),),
    );
  }
}
