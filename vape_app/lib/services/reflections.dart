import 'package:firebase_auth/firebase_auth.dart';
import 'package:vape_app/services/database.dart';

//Service used for reflections
//Provides functions 
class ReflectionsService{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future documentReflection(String stressor, String progress) async {
    try{
        final FirebaseUser user = await _auth.currentUser();
        final uid = user.uid;
        await DatabaseService(uid:uid).createReflection(stressor, progress);
    }catch(e){
        print(e.toString());
        return null;
    }
  }


//Function to delete the reflection
  Future deleteReflection(var documentID) async{
     try{
        final FirebaseUser user = await _auth.currentUser();
        final uid = user.uid;
        return await DatabaseService(uid:uid).deleteReflection(documentID);
    }catch(e){
        print(e.toString());
        return null;
    }
  }
}