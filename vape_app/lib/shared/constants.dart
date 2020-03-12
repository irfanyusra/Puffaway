import 'package:flutter/material.dart';
import 'package:vape_app/services/auth.dart';

final _auth = AuthService();
//Used to decorate form fields
//Decorated with a high sense of fashion
const textInputDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  contentPadding: EdgeInsets.all(12.0),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 2.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blue, width: 2.0),
  ),
);

final Widget logOutIcon = FlatButton.icon(
          icon:Icon(Icons.person),
          label:Text('Logout'),
          onPressed: () async {
            await _auth.signOut();
          });