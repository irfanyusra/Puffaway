
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vape_app/Models/Log.dart';
import 'package:vape_app/Models/Reflection.dart';
import 'package:vape_app/Models/pod.dart';
import 'package:vape_app/pages/reflections_page.dart';

class DatabaseService{
  //collection reference
  final CollectionReference nameCollection = Firestore.instance.collection('names');//Not needed anymore
  final CollectionReference triggerCollection = Firestore.instance.collection('triggers');
  final CollectionReference reflectionCollection = Firestore.instance.collection('reflections');
  final CollectionReference podCollection = Firestore.instance.collection('pod');

  final String uid;
  DatabaseService({this.uid});
  Future updateUserData(String name) async{
    return await nameCollection.document(uid).setData({
      'name':name,
    });
  }

//Function to update the pod finish time once clicked
  Future addPodFinishTime() async{
    return await podCollection.document().setData({
      'uid':uid,
      'dateTime':new DateTime.now(),
    });
  }

  Future createTrigger(String trigger, String thought) async{
      return await triggerCollection.document().setData({

        'uid':uid,
        'trigger':trigger,
        'thought':thought,
        'dateTime':DateTime.now(),
  });
  }

  Future createReflection(String stressor,String progress) async {
    return await reflectionCollection.document().setData({
      'uid':uid,
      'stressor':stressor,
      'progress':progress,
      'dateTime':DateTime.now()
    });
  }

  Future deleteReflection(var documentID)async{
    return await reflectionCollection.document(documentID).delete();
  }
  
  Future delete(var documentID  )async{
    return await triggerCollection.document(documentID ).delete();
  }

  List<Log> _logListFromSnapshot(QuerySnapshot snapshot){

    return snapshot.documents.map((doc){
      return Log(
        documentID:doc.documentID,
        trigger:doc.data['trigger']?? '',
        thought:doc.data['thought']??'',
        dateTime: doc.data['dateTime']

      );
    }).toList();
  }


  List<Reflection> _reflectionListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Reflection(
        documentID:doc.documentID,
        stressor:doc.data['stressor']?? '',
        progress:doc.data['progress']??'',
        dateTime: doc.data['dateTime']

      );
    }).toList();
  }

  //Get reflections stream
  Stream<List<Reflection>> get reflections{
      return reflectionCollection
      .where('uid',isEqualTo:uid )
      .orderBy('dateTime',descending: true)
      .snapshots().map(_reflectionListFromSnapshot);
    }
  //Get logs stream
  Stream<List<Log>> get logs{
      return triggerCollection
      .where('uid',isEqualTo:uid )
      .orderBy('dateTime',descending: true)
      .snapshots().map(_logListFromSnapshot);
  }

    //Map pod to a list and prepare it for return
  List<Pod> _podListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Pod(
        dateTime: doc.data['dateTime']

      );
    }).toList();
  }

  //Get information about pod
  Stream<List<Pod>> get pods{
    return triggerCollection
        .where('uid',isEqualTo:uid )
        .orderBy('dateTime',descending: true)
        .snapshots().map(_podListFromSnapshot);
  }

}