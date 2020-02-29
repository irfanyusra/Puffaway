
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vape_app/Models/Log.dart';

class DatabaseService{
  //collection reference
  final CollectionReference nameCollection = Firestore.instance.collection('names');
  final CollectionReference triggerCollection = Firestore.instance.collection('triggers');
  final CollectionReference reflectionCollection = Firestore.instance.collection('reflections');

  final String uid;
  DatabaseService({this.uid});
  Future updateUserData(String name) async{
    return await nameCollection.document(uid).setData({
      'name':name,
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

  List<Log> _logListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Log(
        trigger:doc.data['trigger']?? '',
        thought:doc.data['thought']??'',
        dateTime: doc.data['dateTime']

      );
    }).toList();
  }
  //Get logs stream
  Stream<List<Log>> get logs{
      return triggerCollection
      .where('uid',isEqualTo:uid )
      .orderBy('dateTime',descending: true)
      .snapshots().map(_logListFromSnapshot);
    }
}