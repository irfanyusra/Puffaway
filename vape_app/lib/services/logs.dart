import 'package:firebase_auth/firebase_auth.dart';
import 'package:vape_app/services/database.dart';

class LogsService{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future loggingVape(String trigger,String thought) async{
    try{
        final FirebaseUser user = await _auth.currentUser();
        final uid = user.uid;
        await DatabaseService(uid:uid).createTrigger(trigger, thought);
    }catch(e){
        print(e.toString());
        return null;
    }
  }

  Future loggingReflections(String stressor, String progress) async {
    try{
        final FirebaseUser user = await _auth.currentUser();
        final uid = user.uid;
        await DatabaseService(uid:uid).createReflection(stressor, progress);
    }catch(e){
        print(e.toString());
        return null;
    }
  }
  
  Future deleteLogging(var documentID) async{
     try{
        final FirebaseUser user = await _auth.currentUser();
        final uid = user.uid;
        return await DatabaseService(uid:uid).delete(documentID);
    }catch(e){
        print(e.toString());
        return null;
    }
  }
}