import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoggingTrigger extends StatefulWidget {
  @override
  _LoggingTriggerState createState() => _LoggingTriggerState();
}

class _LoggingTriggerState extends State<LoggingTrigger> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Log your trigger'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(5, 10, 2, 0),
        child: Column(children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            //space evenly
            children: <Widget>[
              Container(
                child: Text(
                  'r1 c1 ',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ),
              Container(
                child: Text(
                  'r1c2',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                child: Text(
                  'r2',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ),
            ],
          ),
        ],
        ),
      ),
    );
  }
}
