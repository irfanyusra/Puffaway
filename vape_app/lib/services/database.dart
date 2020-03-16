import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vape_app/Models/Log.dart';
import 'package:vape_app/Models/Reflection.dart';
import 'package:vape_app/Models/Trigger.dart';
import 'package:vape_app/Models/pod.dart';

class DatabaseService {
  //collection reference
  final CollectionReference nameCollection =
      Firestore.instance.collection('Names'); //Not needed anymore
  final CollectionReference logCollection =
      Firestore.instance.collection('Logs');
  final CollectionReference reflectionCollection =
      Firestore.instance.collection('Reflections');
  final CollectionReference podCollection =
      Firestore.instance.collection('Pods');
  final CollectionReference triggerCollection =
      Firestore.instance.collection('triggers');

  final String uid;
  DatabaseService({this.uid});
  Future updateUserData(String name) async {
    return await nameCollection.document(uid).setData({
      'name': name,
    });
  }

//Function to add custom trigger
  Future createTrigger(String trigger) async {
    return await triggerCollection.document().setData(
        {'uid': uid, 'trigger': trigger, 'dateTime': new DateTime.now()});
  }

//Function to update the pod finish time once clicked
  Future addPodFinishTime() async {
    return await podCollection.document().setData({
      'uid': uid,
      'dateTime': new DateTime.now(),
    });
  }

//Function to add custom log
  Future createLog(String trigger, String thought) async {
    return await logCollection.document().setData({
      'uid': uid,
      'trigger': trigger,
      'thought': thought,
      'dateTime': DateTime.now(),
    });
  }

  Future createReflection(String stressor, String progress) async {
    return await reflectionCollection.document().setData({
      'uid': uid,
      'stressor': stressor,
      'progress': progress,
      'dateTime': DateTime.now()
    });
  }

  Future deleteReflection(var documentID) async {
    return await reflectionCollection.document(documentID).delete();
  }

  Future deleteLog(var documentID) async {
    return await logCollection.document(documentID).delete();
  }

  List<Reflection> _reflectionListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Reflection(
          documentID: doc.documentID,
          stressor: doc.data['stressor'] ?? '',
          progress: doc.data['progress'] ?? '',
          dateTime: doc.data['dateTime']);
    }).toList();
  }

  //Get reflections stream
  Stream<List<Reflection>> get reflections {
    return reflectionCollection
        .where('uid', isEqualTo: uid)
        .orderBy('dateTime', descending: true)
        .snapshots()
        .map(_reflectionListFromSnapshot);
  }

  List<Log> _logListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Log(
          documentID: doc.documentID,
          trigger: doc.data['trigger'] ?? '',
          thought: doc.data['thought'] ?? '',
          dateTime: doc.data['dateTime']);
    }).toList();
  }

  //Get logs stream
  Stream<List<Log>> get logs {
    return logCollection
        .where('uid', isEqualTo: uid)
        .orderBy('dateTime', descending: true)
        .snapshots()
        .map(_logListFromSnapshot);
  }

  //Map pod to a list and prepare it for return
  List<Pod> _podListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Pod(dateTime: doc.data['dateTime']);
    }).toList();
  }

  //Get information about pod
  Stream<List<Pod>> get pods {
    return podCollection
        .where('uid', isEqualTo: uid)
        .orderBy('dateTime', descending: true)
        .snapshots()
        .map(_podListFromSnapshot);
  }

  //Map triggers to a list
  List<Trigger> _triggerListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Trigger( documentID: doc.documentID,
          trigger: doc.data['trigger'] ?? '',
          dateTime: doc.data['dateTime']);
    }).toList();
  }

  //Get all triggers
  Stream<List<Trigger>> get triggers {
    return triggerCollection
        .where('uid', isEqualTo: uid)
        .orderBy('dateTime', descending: true)
        .snapshots()
        .map(_triggerListFromSnapshot);
  }

}
