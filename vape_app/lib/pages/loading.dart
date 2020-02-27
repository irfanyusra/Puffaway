import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  void waitLoading () async{

      await Future.delayed(Duration(seconds: 3),() {
        print("deeee");
        Navigator.pushReplacementNamed(context, '/logging');
      });
      print("delayeeddd");
  }

  @override
  void initState (){
    super.initState();
    print("ddd");
    waitLoading();


//    Navigator.pushReplacementNamed(context, '/logging');
//    Navigator.push(context,
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
         body: Center(
             child: SafeArea(
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.center,
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: <Widget>[
                 Text (
                 'Loading...',
                 style: TextStyle(
                   fontSize: 20,
                   letterSpacing: 2.0,
                 ) ,
               ),
               SizedBox(height: 20),
               Text (
                 'Quote...',
                 style: TextStyle(
                   fontSize: 20,
                   letterSpacing: 2.0,
                 ) ,
               ),
                 ],
               ),

//

             ),
         ),
    );
  }
}
