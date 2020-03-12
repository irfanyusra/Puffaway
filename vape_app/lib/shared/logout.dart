import 'package:flutter/material.dart';
import 'package:vape_app/services/auth.dart';

//Extension to app bar widget (Display logout on all screens) and title if user chooses to do it using this widget
class LogOutAppBar extends AppBar{
  //Optional fields, auth is used to allow users to sign out
  //My own custom app bar
  LogOutAppBar({Key key,Widget title,bool centerTitle,AuthService auth,}):super(key:key,title:title,centerTitle:centerTitle,actions: <Widget>[
    FlatButton.icon(
          icon:Icon(Icons.person),
          label:Text('Logout'),
          onPressed: () async {
            await auth.signOut();
          })
  ]);
}