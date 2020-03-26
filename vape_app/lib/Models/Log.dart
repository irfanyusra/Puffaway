
import 'package:cloud_firestore/cloud_firestore.dart';

class Log {
  final String documentID;
  final String trigger;
  final String thought;
  final Timestamp dateTime;
  Log({this.documentID,this.trigger,this.thought,this.dateTime});

}
