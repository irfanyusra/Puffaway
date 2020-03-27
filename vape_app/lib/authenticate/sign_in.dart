import 'package:flutter/material.dart';
import 'package:vape_app/services/auth.dart';
import 'package:vape_app/shared/constants.dart';
import 'package:vape_app/shared/loading.dart';
import 'package:vape_app/helper_functions/validation.dart';

class SignIn extends StatefulWidget {
  // function from authenticate file
  final Function toggleView;
  SignIn({this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  //Private variable calls functions from AuthService()
  final AuthService _auth = AuthService();
  //Used to identify the forms and hence validate it
  final _formKey = GlobalKey<FormState>();
  bool loading = false; // Anytime a sign in is clicked show the loading widget

  //Used to to retrieve email and password from text fields
  String email = '';
  String password = '';
  //Used for displaying errors retrieved from firebase
  String error = '';

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
                title: Text('Sign in to Puffaway'),
                //Widget used to allow user to toggle between register and sign in
                actions: <Widget>[
                  FlatButton.icon(
                      icon: Icon(Icons.person),
                      label: Text('Register', key: Key("register-btn")),
                      onPressed: () {
                        //Toggle register screen
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
                            //Decorate text field from constants file
                            style: fieldStyle,
                            //Decorate text field from constants file
                            //Text hint is email(the text that will hint to the user to type in email)
                            decoration:
                                textInputDecoration.copyWith(hintText: 'Email'),
                            //Used to validate email if it is empty from validation file
                            validator: EmailFieldValidator.validate,
                            onChanged: (val) {
                              //Retrieves the email from the form
                              setState(() => email = val);
                            },
                          ),
                          SizedBox(height: 20.0),
                          TextFormField(
                            key: Key('password-field'),
                            style: fieldStyle,
                            //Decorate text field from constants file
                            //Text hint is password(the text that will hint to the user to type in password)
                            decoration: textInputDecoration.copyWith(
                                hintText: 'Password'),
                            //Again, more boring validation
                            validator: PasswordFieldValidator.validate,
                            obscureText: true,
                            onChanged: (val) {
                              //retrieves the stupid password from the form
                              setState(() => password = val);
                            },
                          ),
                          SizedBox(height: 20.0),
                          //from constant file
                          buttonThemeAuth(
                            context,
                            RaisedButton(
                                elevation: 5.0,
                                key: Key('signin-btn'),
                                color: Colors.blue[400],
                                child: Text('Sign In',
                                    textAlign: TextAlign.center,
                                    style: fieldStyle.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                                onPressed: () async {
                                  //Waits for validation from firebase then signs in user
                                  if (_formKey.currentState.validate()) {
                                    setState(() {
                                      loading =
                                          true; //Set the loading to true while waiting for firebases response
                                    });
                                    dynamic result =
                                        await _auth.signInWithEmailAndPassword(
                                            email, password);
                                    if (result == null) {
                                      setState(() {
                                        //Error as firebase returns an error
                                        error =
                                            'Vaping makes you forget, please try again and change your habit';
                                        //Toggle it off after checking is complete
                                        loading = false;
                                      });
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
