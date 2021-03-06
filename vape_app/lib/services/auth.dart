import 'package:firebase_auth/firebase_auth.dart';
import 'package:vape_app/Models/User.dart';
import 'package:vape_app/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

//Update the user data
  Future updateUserData(String name, String goal, String dob, String token) async {
    FirebaseUser user = await _auth.currentUser();
    return await DatabaseService(uid: user.uid)
        .updateUserData(name, goal, dob, token);
  }

//CreateDefaultTriggers is a function which adds default triggers to the database upon registration
  Future createDefaultTriggers(User user, List<String> triggers) async {
    for (String trigger in triggers)
      await DatabaseService(uid: user.uid).createTrigger(trigger);
  }

  // auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  //sign in
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;

      //Create a default user model upon registration
      await updateUserData('', '', '','');
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
