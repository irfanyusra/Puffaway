import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vape_app/Models/User.dart';
import 'package:vape_app/authenticate/authenticate.dart';
import 'package:vape_app/pages/Home.dart';
import 'package:vape_app/pages/setup.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  bool showSetup = false;

  void toggleSetup() {
    //Toggle with a not
    setState(() => showSetup = !showSetup);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return user == null ? Authenticate(toggleSetup: toggleSetup) : showSetup ? Setup(toggleSetup: toggleSetup) : Home();
  }
}
