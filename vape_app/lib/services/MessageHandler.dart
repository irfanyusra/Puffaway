import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vape_app/services/auth.dart';
import '../Models/User.dart';

class MessageHandler extends StatefulWidget {
  @override
  _MessageHandlerState createState() => _MessageHandlerState();
}

class _MessageHandlerState extends State<MessageHandler> {
  final Firestore _db = Firestore.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();

    _saveDeviceToken();

    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async { //when the app is open and running in the foreground
        print("onMessage: $message");
      },
      onLaunch: (Map<String, dynamic> message) async { //if the app is fully terminated and notification is clicked
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async { //if the app is closed but still running in the background and notification is clicked
        print("onResume: $message");
      },
    );
  }

  _saveDeviceToken() async {
    // Get the current user
    FirebaseUser user = await _auth.currentUser();

    // Get the token for this device
    String fcmToken = await _fcm.getToken();

    // Save it to Firestore
    if (fcmToken != null) {
      var tokens = _db
          .collection('Users')
          .document(user.uid);


      await tokens.updateData({
        'token': fcmToken
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return Container();
  }
}
