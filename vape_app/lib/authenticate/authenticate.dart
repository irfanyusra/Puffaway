import 'package:flutter/material.dart';
import 'package:vape_app/authenticate/register.dart';
import 'package:vape_app/authenticate/sign_in.dart';

class Authenticate extends StatefulWidget {
  final Function toggleSetup;
  Authenticate({this.toggleSetup});

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  //Flag to show if someone toggled to the sign in page or register
  bool showSignIn = true;

  void toggleView() {
    //Toggle with a not
    setState(() => showSignIn = !showSignIn);
    widget.toggleSetup();
  }

  @override
  Widget build(BuildContext context) {
    //Display either page based on what was toggle and Pass the function as a parameter
    return showSignIn
        ? SignIn(toggleView: toggleView)
        : Register(toggleView: toggleView);
  }
}
