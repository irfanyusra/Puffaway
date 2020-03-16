import 'package:firebase_auth/firebase_auth.dart';
import 'package:mockito/mockito.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth{}
class MockFirebaseUser extends Mock implements FirebaseUser{
  @override
   String get uid => 'uid';
}
class MockAuthResult extends Mock implements AuthResult {
  @override
  MockFirebaseUser get user=>MockFirebaseUser();
}