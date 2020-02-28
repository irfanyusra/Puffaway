import 'package:firebase_auth/firebase_auth.dart';
import 'package:vape_app/Models/User.dart';
import 'package:vape_app/services/database.dart';

class AuthService{
  //sign in anonymously
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User _userFromFirebaseUser(FirebaseUser user){
    return user!=null?User(uid:user.uid):null;
  }
  Future signInAnon(String name) async {
    try{
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;

      await DatabaseService(uid:user.uid).updateUserData(name);
      return _userFromFirebaseUser(user);
    }catch(e){  
      print(e.toString());
      return null;
    }
  }
  //sign out
}