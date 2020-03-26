import 'package:firebase_auth/firebase_auth.dart';
import 'package:vape_app/services/database.dart';

class PodService{
  final FirebaseAuth _auth = FirebaseAuth.instance;


  //Add pod finish time when pressed
  Future addPodFinishTime() async{
    try{
        final FirebaseUser user = await _auth.currentUser();
        final uid = user.uid;
        await DatabaseService(uid:uid).addPodFinishTime();
    }catch(e){
        print(e.toString());
        return null;
    }

  }

}