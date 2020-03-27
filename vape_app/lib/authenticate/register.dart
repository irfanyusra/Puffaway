import 'package:flutter/material.dart';
import 'package:vape_app/services/auth.dart';
import 'package:vape_app/services/pods.dart';
import 'package:vape_app/shared/constants.dart';
import 'package:vape_app/shared/loading.dart';
import 'package:vape_app/helper_functions/validation.dart';

class Register extends StatefulWidget {
  // function from authenticate file
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
  final AuthService _auth = AuthService();
  final PodService _pod = PodService();

  //Formkey used for form validation
  final _formKey = GlobalKey<FormState>();

  //Email and password from input field is stored here
  String email = '';
  String password = '';
  String error = '';

  //Used for loading screen that appears when user clicks on register
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    //layout builder used to put the content in the middle of the page
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
      //loding is used when the app is loading or retrieving data from the database
      return loading
          ? Loading()
          : Scaffold(
              appBar: AppBar(
                elevation: 0.0,
                title: Text('Register to Puffaway'),
                actions: <Widget>[
                  FlatButton.icon(
                      //Allows user to toggle between sign in and register page
                      icon: Icon(Icons.person),
                      label: Text('Sign in'),
                      onPressed: () {
                        //Toggle Register
                        widget.toggleView();
                      }),
                ],
              ),
              body: SingleChildScrollView(
                //used to put the context in this box in the middle of the screen
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: viewportConstraints.maxHeight,
                  ),
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          appIcon,
                          SizedBox(height: 20.0),
                          TextFormField(
                            key: Key('email-field'),
                            //Imported from constants file
                            style: fieldStyle,
                            //Imported from constants file and Adds the hint text based on coders preference
                            decoration:
                                textInputDecoration.copyWith(hintText: 'Email'),
                            //validator in the validation file
                            validator: EmailFieldValidator.validate,
                            onChanged: (val) {
                              setState(() => email = val);
                            },
                          ),
                          SizedBox(height: 20.0),
                          TextFormField(
                            key: Key('password-field'),
                            style: fieldStyle,
                            decoration: textInputDecoration.copyWith(
                                hintText: 'Password'),
                            validator: PasswordFieldValidator.validate,
                            obscureText: true,
                            onChanged: (val) {
                              setState(() => password = val);
                            },
                          ),
                          SizedBox(height: 20.0),
                          //from constant file 
                          buttonThemeAuth(
                            context,
                            RaisedButton(
                                key: Key("register-btn"),
                                elevation: 5.0,
                                color: Colors.blue[400],
                                child: Text('Register',
                                    textAlign: TextAlign.center,
                                    style: fieldStyle.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    setState(() {
                                      //set loading to true when user presses register button
                                      loading = true;
                                    });
                                    dynamic result = await _auth
                                        .registerWithEmailAndPassword(
                                            email, password);
                                    if (result == null) {
                                      setState(() {
                                        //Error as firebase returns an error
                                        error = 'Email already in use, please use a different email';
                                        //Loading is done after result is returned from firebase
                                        loading = false;
                                      });
                                    } else {
                                      await _pod.addPodFinishTime();
                                      await _auth.createDefaultTriggers(
                                          result, triggers);
                                    }
                                  }
                                }),
                          ),
                          SizedBox(height: 12.0),
                          Text(
                            error,
                            style: TextStyle(color: Colors.red, fontSize: 14.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
    });
  }
}
