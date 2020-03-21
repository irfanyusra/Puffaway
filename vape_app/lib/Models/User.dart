
import 'package:cloud_firestore/cloud_firestore.dart';

class User{
  final String uid;
  User({this.uid});
}

class UserData{
  final String uid;
  final String name;
  final String goal;
  final Timestamp dob;
  UserData({this.uid,this.name,this.goal,this.dob});
}