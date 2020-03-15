import 'package:cloud_firestore/cloud_firestore.dart';

class Reflection {
  final String documentID;
  final String stressor;
  final String progress;
  final Timestamp dateTime;
  
  Reflection({this.documentID,this.stressor,this.progress,this.dateTime});

}
