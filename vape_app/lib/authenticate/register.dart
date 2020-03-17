import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vape_app/services/auth.dart';
import 'package:vape_app/shared/constants.dart';
import 'package:vape_app/pages/Home.dart';
import 'package:vape_app/shared/loading.dart';
import 'package:vape_app/helper_functions/validation.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  //Default triggers
  List<String> triggers = [
    'Time of day',
    'Wake-up routine',
    'Boredom',
    'Vape smell',
    'Stress',
    'Seeing someone vaping',
    'Fatigue',
    'Partying',
    'Sex'
  ];
  //Formkey used for form validation
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  //Text field state
  //Email and password from input field is stored here
  String email = '';
  String password = '';
  String error = '';

  bool loading =
      false; //Used for loading screen that appears when user clicks on register
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              title: Text('Register to Puffaway'),
              actions: <Widget>[
                FlatButton.icon(
                    //Allows user to toggle between pages
                    icon: Icon(Icons.person),
                    label: Text('Sign in'),
                    onPressed: () {
                      //Toggle Register
                      widget.toggleView();
                    }),
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    TextFormField(
                      key: Key('email-field'),
                      //Imported from constants file
                      //Adds the hint text based on coders preference
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Email'),
                      validator: EmailFieldValidator.validate,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      key: Key('password-field'),
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Password'),
                      validator: PasswordFieldValidator.validate,
                      obscureText: true,
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                    ),
                    SizedBox(height: 20.0),
                    RaisedButton(
                        key: Key("register-btn"),
                        color: Colors.blue[400],
                        child: Text(
                          'Register',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              //set loading to true when user presses register button
                              loading = true;
                            });
                            dynamic result = await _auth
                                .registerWithEmailAndPassword(email, password);
                            if (result == null) {
                              setState(() {
                                //Error as firebase returns an error
                                error = 'Please enter a valid email';
                                loading =
                                    false; //Loading is done after result is returned from firebase
                              });
                            } else {
                              await _auth.createDefaultTriggers(
                                  result, triggers);
                              await _auth.createDefaultUser();
                            }
                          }
                        }),
                    SizedBox(height: 12.0),
                    Text(error,
                        style: TextStyle(color: Colors.red, fontSize: 14.0))
                  ],
                ),
              ),
            ),
          );
  }
}
