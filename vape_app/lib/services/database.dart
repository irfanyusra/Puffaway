
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{
  //collection reference
  final CollectionReference nameCollection = Firestore.instance.collection('names');
  final CollectionReference triggerCollection = Firestore.instance.collection('triggers');

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
        'dateTime':new DateTime.now(),
  });
  }

  //Get logs stream
  Stream<QuerySnapshot> get logs{
      return triggerCollection
      .where('uid',isEqualTo:uid )
      .orderBy('dateTime',descending: true)
      .snapshots();
    }
}