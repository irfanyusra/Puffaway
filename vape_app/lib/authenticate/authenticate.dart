import 'package:flutter/material.dart';
import 'package:vape_app/authenticate/register.dart';
import 'package:vape_app/authenticate/sign_in.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  //Flag to show if someone toggled to the sign in page or register
  bool showSignIn = true;

  void toggleView(){
    //Toggle the bit by an eXor, each time someone clicks on the icon
    //setState(()=>showSignIn^=1);
    //Toggle with a not 
    setState(()=>showSignIn=!showSignIn);
  }
  @override
  Widget build(BuildContext context) {
    //Display either page based on what was toggled
    //Pass the function as a parameter
   return showSignIn?SignIn(toggleView:toggleView):Register(toggleView:toggleView);
  }
}