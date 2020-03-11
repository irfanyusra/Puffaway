
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vape_app/Models/User.dart';
import 'package:vape_app/authenticate/authenticate.dart';
import 'package:vape_app/authenticate/register.dart';
import 'package:vape_app/authenticate/sign_in.dart';
import 'package:vape_app/pages/Home.dart';


class Wrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
      final user = Provider.of<User>(context);
      print(user);
    return user==null?Authenticate():Home();
  }
}