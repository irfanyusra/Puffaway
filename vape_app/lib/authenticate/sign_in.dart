import 'package:flutter/material.dart';
import 'package:vape_app/services/auth.dart';
import 'package:vape_app/pages/Home.dart';
class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();

  //Text field state
  String name = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        backgroundColor: Colors.blue[600],
        elevation: 0.0,
        title: Text('Sign in to Puffaway'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            child: Column(
              children: <Widget>[
                SizedBox(height:20.0),
                TextFormField(
                  onChanged: (val) {
                    setState(()=> name = val);
                  }),
                    SizedBox(height:20.0),
                    RaisedButton(
                      color:Colors.pink[400],
                      child:Text(
                        'Sign in',
                        style: TextStyle(color:Colors.white),
                        ),
                        onPressed: () async{
                          dynamic result = await _auth.signInAnon(name);
                          Navigator.pushReplacement(context, new MaterialPageRoute<void>(
                          builder: (context) => Home()
                          ));
                        }
            )
              ],)
          ),
        
   

      ),
    );
  }
}