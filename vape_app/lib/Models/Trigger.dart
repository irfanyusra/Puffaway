
import 'package:cloud_firestore/cloud_firestore.dart';

class Trigger {
  final String documentID;
  final String trigger;
  final Timestamp dateTime;

  Trigger({this.documentID,this.trigger,this.dateTime});
}
