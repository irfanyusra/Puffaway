import 'package:firebase_auth/firebase_auth.dart';
import 'package:vape_app/services/database.dart';
import 'package:vape_app/services/auth.dart';

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
  //sign out
}