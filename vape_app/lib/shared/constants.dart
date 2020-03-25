import 'package:flutter/material.dart';
import 'package:vape_app/services/auth.dart';

final _auth = AuthService();
const Color red200 = Color(0xFFEF9A9A);

//Used to decorate form fields
//Decorated with a high sense of fashion
const textInputDecoration = InputDecoration(
    fillColor: Colors.white,
    filled: true,
    contentPadding: EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 15.0),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(32.0)),
      borderSide: BorderSide(color: Colors.grey, width: 2.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(32.0)),
      borderSide: BorderSide(color: Colors.blue, width: 2.0),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(32.0)),
      borderSide: BorderSide(color: red200, width: 2.0),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(32.0)),
    ));

final Widget logOutIcon = FlatButton.icon(
    icon: Icon(Icons.person),
    label: Text('Logout'),
    onPressed: () async {
      await _auth.signOut();
    });

final Widget appIcon = Container(
  height: 150.0,
  width: 150.0,
  child: Image(image: AssetImage('assets/icon.png')),
);

//for buttons
Widget buttonThemeAuth(context, child) {
  return ButtonTheme(
      minWidth: MediaQuery.of(context).size.width,
      padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: child);
}

//font style for text fields
final TextStyle fieldStyle = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
