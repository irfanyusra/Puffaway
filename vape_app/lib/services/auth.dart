import 'package:firebase_auth/firebase_auth.dart';
import 'package:vape_app/Models/User.dart';
import 'package:vape_app/services/database.dart';

class AuthService{
  //sign in anonymously
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User _userFromFirebaseUser(FirebaseUser user){
    return user!=null?User(uid:user.uid):null;
  }

  // auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged
      .map(_userFromFirebaseUser);
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

  //sign in
   Future signInWithEmailAndPassword(String email, String password)async{
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;

      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //Register with email and password
  Future registerWithEmailAndPassword(String email, String password)async{
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;

      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }
}