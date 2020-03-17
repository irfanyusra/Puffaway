import 'package:firebase_auth/firebase_auth.dart';
import 'package:vape_app/Models/User.dart';
import 'package:vape_app/services/database.dart';

class AuthService{
  //sign in anonymously
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User _userFromFirebaseUser(FirebaseUser user){
    return user!=null?User(uid:user.uid):null;
  }

//Update name of user
  Future updateUsername(String name) async {
   FirebaseUser user = await _auth.currentUser();
    return await DatabaseService(uid:user.uid).updateUsername(name);
  }

//Update goal of user
  Future updateUserGoal(int goal) async {
   FirebaseUser user = await _auth.currentUser();
    return await DatabaseService(uid:user.uid).updateUserGoal(goal);
  }

//CreateDefaultuser is a function that initializes the user collection upon registration
Future createDefaultUser()async{
   FirebaseUser user = await _auth.currentUser();
  await DatabaseService(uid: user.uid).createDefaultUser('', 0);
}
 

//CreateDefaultTriggers is a function which adds default triggers to the database upon registration
Future createDefaultTriggers(User user,List<String> triggers) async{
  for(String trigger in triggers)
    await DatabaseService(uid:user.uid).createTrigger(trigger);
}
  // auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged
      .map(_userFromFirebaseUser);
  }

//Not used anymore
  Future signInAnon(String name) async {
    try{
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;

      await DatabaseService(uid:user.uid).updateUsername(name);
      
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