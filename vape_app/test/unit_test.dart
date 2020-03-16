import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rxdart/rxdart.dart';
import 'package:vape_app/Models/User.dart';
import 'package:vape_app/helper_functions/validation.dart';
import 'package:vape_app/services/auth.dart';
import 'package:mockito/mockito.dart';
import 'model/MockFirebase.dart';

void main() {
  //Initialize
  TestWidgetsFlutterBinding.ensureInitialized();
  group('Email', () {
    //boundry test
    test('Empty email returns error string', () {
      var result = EmailFieldValidator.validate('');
      expect(result, 'Enter an email');
    });
    // bad test
    test('bad email format returns error string ', () {
      var result = EmailFieldValidator.validate('test');
      expect(result, 'Enter a Valid Email');
    });
    //good test
    test('correct email format', () {
      var result = EmailFieldValidator.validate('test@test.com');
      expect(result, null);
    });
  });
  group('Password', () {
    //bad or boundy test
    test('password less than 6 characters returns error string', () {
      var result = PasswordFieldValidator.validate('');
      expect(result, 'Enter a password longer than 6 characters');
    });
    //good test
    test('password with more than or equal to 6 charaters returns null', () {
      var result = PasswordFieldValidator.validate('password');
      expect(result, null);
    });
  });

  //Authentication testing
  MockFirebaseAuth _auth = MockFirebaseAuth();
  BehaviorSubject<MockFirebaseUser> _user = BehaviorSubject<MockFirebaseUser>();
  final MockAuthResult signInAuthentication =MockAuthResult();
  when(_auth.onAuthStateChanged).thenAnswer((_) {
    return _user;
  });

  AuthService authService = AuthService(auth: _auth);

  group('AuthService', () {
    when(_auth.signInWithEmailAndPassword(
              email: "travisscott@email.com", password: "Kylie123"))
          .thenAnswer((_) async {
          _user.add(MockFirebaseUser());
        return signInAuthentication;
      });
    test('sign in with email and password', () async {
        dynamic signedIn = await authService.signInWithEmailAndPassword("travisscott@email.com", "Kylie123");
        expect(signedIn.uid,'uid');
    });
    when(_auth.signInWithEmailAndPassword(email: "travisscott@email.com", password: "Kendall123"))
        .thenThrow(() {
      return null;
    });

    test("Sign in with incorrect email and password fails", () async {
      dynamic signedIn =
      await authService.signInWithEmailAndPassword("travisscott@email.com", "Kendall123");
      expect(signedIn, null);
    });

    //Test logging out
    test('sign out',() async{
     await authService.signOut();
    });
  });
}
