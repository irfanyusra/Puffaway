import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:math';
import 'package:vape_app/pages/wrapper.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  static List<String> quotes = [
    'Everything you are and everything you have is because of a decision you once made. Decide to quit vaping, and nothing will stop you',
    'There will never be a perfect moment to quit smoking. Don’t wait for life to change, it won’t.',
    'Make a list of all the benefits you will gain by quitting vaping. And revisit it every morning until your mind starts liking the idea of becoming vape free',
    'A successful quit attempt starts with the decision to try. Making a firm decision to stop vaping will fuel you with determination and motivation',
    'Usually, what’s holding us back from quitting is our beliefs that quitting smoking is impossible or that we can’t quit. \n Believe in your potential, and you will be successful',
  ]; //list of motivational quotes
  int randInt = (new Random().nextInt(quotes.length));

  void waitLoading() async {
    //simulate app loading delay to show the quote
    await Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(context, new MaterialPageRoute<void>(
          builder: (context) => Wrapper()
      ));
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
