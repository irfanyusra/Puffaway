import 'package:firebase_auth/firebase_auth.dart';
import 'package:vape_app/services/database.dart';

//Service used for logs(thoughts and triggers) etc.
class LogsService{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // -----LOGS-----

  Future documentLog(String trigger,String thought) async{
    try{
        final FirebaseUser user = await _auth.currentUser();
        final uid = user.uid;
        await DatabaseService(uid:uid).createLog(trigger, thought);
    }catch(e){
        print(e.toString());
        return null;
    }
  }
  
  Future deleteLog(var documentID) async{
     try{
        final FirebaseUser user = await _auth.currentUser();
        final uid = user.uid;
        return await DatabaseService(uid:uid).deleteLog(documentID);
    }catch(e){
        print(e.toString());
        return null;
    }
  }


  // -----TRIGGERS-----
  
  //Used to create custom trigger
  Future createTrigger(String trigger)async{
      try{
        final FirebaseUser user = await _auth.currentUser();
        final uid = user.uid;
        return await DatabaseService(uid:uid).createTrigger(trigger);
    }catch(e){
        print(e.toString());
        return null;
    }
    
  }

  //Used to delete  trigger
  Future deleteTrigger(var documentID) async{
     try{
        final FirebaseUser user = await _auth.currentUser();
        final uid = user.uid;
        return await DatabaseService(uid:uid).deleteTrigger(documentID);
    }catch(e){
        print(e.toString());
        return null;
    }

  }

}