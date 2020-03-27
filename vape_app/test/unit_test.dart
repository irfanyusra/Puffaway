import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vape_app/helper_functions/validation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/rxdart.dart';
import 'package:vape_app/user_repository/user_repository.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}
class MockFirebaseUser extends Mock implements FirebaseUser {}
class MockAuthResult extends Mock implements AuthResult {}

void main() {
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
    test('bad email format returns error string ', () {
      var result = EmailFieldValidator.validate('@gmail.com');
      expect(result, 'Enter a Valid Email');
    });
    //good test
    test('correct email format', () {
      var result = EmailFieldValidator.validate('test@test.com');
      expect(result, null);
    });

    test('correct email format - subdomain', () {
      var result = EmailFieldValidator.validate('test@gmail.co.uk');
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

   group('Goal', () {
    //bad or boundy test
    test('goal value equal to 0 returns error', () {
      var result = GoalFieldValidator.validate('0');
      expect(result, '');
    });
     test('goal value less than 1 returns error', () {
      var result = GoalFieldValidator.validate('-1');
      expect(result, '');
    });
    //good test
    test('goal value equal to 1 returns null', () {
      var result = GoalFieldValidator.validate('1');
      expect(result, null);
    });
    test('goal value greater than 1 returns null', () {
      var result = GoalFieldValidator.validate('2');
      expect(result, null);
    });
  });

//Authentication testing
  MockFirebaseAuth _auth = MockFirebaseAuth();
  BehaviorSubject<MockFirebaseUser> _user = BehaviorSubject<MockFirebaseUser>();
  when(_auth.onAuthStateChanged).thenAnswer((_) {
    return _user;
  });
  UserRepository _repo = UserRepository.instance(auth: _auth);
  group('user repository test', () {
    when(_auth.signInWithEmailAndPassword(
            email: "travisscott@email.com", password: "Kylie123"))
        .thenAnswer((_) async {
      _user.add(MockFirebaseUser());
      return MockAuthResult();
    });
    when(_auth.signInWithEmailAndPassword(
            email: "travisscott@email.com", password: "Kendall123"))
        .thenThrow(() {
      return null;
    });
    test("sign in with email and password", () async {
      bool signedIn = await _repo.signIn("travisscott@email.com", "Kylie123");
      expect(signedIn, true);
      expect(_repo.status, Status.Authenticated);
    });

    test("sign in fails with incorrect email and password", () async {
      bool signedIn = await _repo.signIn("travisscott@email.com", "Kendall123");
      expect(signedIn, false);
      expect(_repo.status, Status.Unauthenticated);
    });

    test('sign out', () async {
      await _repo.signOut();
      expect(_repo.status, Status.Unauthenticated);
    });
  });
}
