import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vape_app/Models/User.dart';
import 'package:vape_app/pages/loading.dart';
import 'package:vape_app/pages/setup.dart';
import 'package:vape_app/services/auth.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Loading(),
      ),
    );
  }
}

//to do unit and widget test: flutter test
//for integration test: flutter drive --target=test_driver/app.dart
