import 'package:flutter/material.dart';

class Logging extends StatefulWidget {
  @override
  _LoggingState createState() => _LoggingState();
}

class _LoggingState extends State<Logging> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.pushNamed(context, '/logging_trigger');
            },
            color: Colors.blue,
            child: Text('Log your trigger'),
          ),
          FlatButton(
            color: Colors.blue,
            child: Text('All Logs'),
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/all_logs',
              );
            },

          ),
          FlatButton(
            color: Colors.blue,
            child: Text('Add trigger'),
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/add_trigger',
              );
            },

          ),
        ],
      )),
    ));
  }
}
