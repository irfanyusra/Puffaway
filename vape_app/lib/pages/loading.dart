import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:math';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  static List<String> quotes = [
    'fdfdfdfdfdf',
    'fdfdwwwwwww',
    'rereererere',
    'rereqqqqqq',
    'It\'s addictive but you can overcome it',
  ]; //list of motivational quotes
  int randInt = (new Random().nextInt(quotes.length));

  void waitLoading() async {
    //simulate app loading delay to show the quote
    await Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/logging');
    });
  }

  @override
  void initState() {
    super.initState();
    waitLoading();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Loading...',
                style: TextStyle(
                  fontSize: 20,
                  letterSpacing: 2.0,
                ),
              ),
              SizedBox(height: 20),
              //TODO: send the quote in for the log in page (or do we want different quotes)
              Text(
                '${quotes[randInt]}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  letterSpacing: 2.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
