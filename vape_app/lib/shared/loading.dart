//used for loading screens, shared between files
//Used anytime time the user has to waitt between screens

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

//Custom loading widget, spinkitchasing dots is the package that displays the rotating loading icon

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: SpinKitChasingDots(
          color: Colors.blue,
          size: 50.0,
        ),
      ),
    );
  }
}
