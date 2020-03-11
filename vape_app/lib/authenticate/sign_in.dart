import 'package:flutter/material.dart';
import 'package:vape_app/services/auth.dart';
import 'package:vape_app/pages/Home.dart';
import 'package:vape_app/shared/constants.dart';
import 'package:vape_app/shared/loading.dart';
class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {


  final AuthService _auth = AuthService();//Private variable calls functions from AuthService()
  final _formKey = GlobalKey<FormState>();//Used to identify the forms and hence validate it 
  bool loading = false; // Anytime a sign in is clicked show the loading widget

  //Text field state

  //Used to to retrieve email and password from text fields
  String email = '';
  String password = '';
  String error = '';//Used for displaying errors retrieved from firebase

  @override
  Widget build(BuildContext context) {
    return loading?Loading():Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text('Sign in to Puffaway'),
        //Widget used to allow user to toggle between register and sign in
        actions: <Widget>[
            FlatButton.icon(
            icon:Icon(Icons.person),
            label:Text('Register'),
            onPressed:(){
              //Toggle register screen
              widget.toggleView();
              }),
    ],
      ),
       body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key:_formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                //Decorate text field from constants file
                //Text hint is email(the text that will hint to the user to type in email)
                decoration: textInputDecoration.copyWith(hintText:'Email'),
                //Used to validate email if it is empty
                validator:(val)=>val.isEmpty?'Enter an email':null 
                ,
                onChanged: (val) {
                  //Retrieves the email from the form
                  setState(() => email = val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                //Decorate text field from constants file
                //Text hint is password(the text that will hint to the user to type in password)
                decoration: textInputDecoration.copyWith(hintText:'Password'),
                //Again, more boring validation
                validator:(val)=>val.length<6?'Enter a password longer than 6 characters':null,
                obscureText: true,
                onChanged: (val) {
                  //retrieves the stupid password from the form
                  setState(() => password = val);
                },
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                color: Colors.pink[400],
                child: Text(
                  'Sign In',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  //Waits for validation from firebase then signs in user
                    if(_formKey.currentState.validate()){
                      setState(() {
                        loading = true;//Set the loading to true while waiting for firebases response
                      });
                    dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                    if(result==null){
                      setState(() {
                        //Change this later
                        //Error
                        // error = 'Incorrect credentials';
                        error = 'Vaping makes you forget, change your habit';
                        loading = false;//Toggle it off after checking is complete
                      });
                }}}
              ),
              SizedBox(height:12.0),
              Text(
                error,
                style:TextStyle(color:Colors.red,fontSize:14.0)
              )
            ],
          ),
        ),
      ),
    );
  }
}