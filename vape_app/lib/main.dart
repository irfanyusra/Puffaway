import 'package:flutter/material.dart';
import 'package:vape_app/pages/loading.dart';
import 'package:vape_app/pages/logging.dart';
import 'package:vape_app/pages/logging_trigger.dart';
import 'package:vape_app/pages/recommendation.dart';

void main() => runApp(
  MyApp(/*
    initialRoute : '/',
    routes: {
      '/': (context) => Loading(),
      '/logging': (context)=> Logging(),
      '/logging_trigger': (context)=> LoggingTrigger(),
      '/recommendations': (context)=> Recommendation(),
      //add more routes here
    },*/
  )
//    MyApp()
);

class MyApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    int selectedPage = 0;
    final pageOptions = [
      Logging(),
      LoggingTrigger(),
      Recommendation()
    ];

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Main'),),
        body: pageOptions[selectedPage],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedPage,
          onTap: (int index) {
            setState(() {
              selectedPage = index;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text('Home')
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.note_add),
                title: Text('Trigger')
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.assessment),
                //collections_bookmark, comment, book, import_contacts, note_add, settings
                title: Text('Recommendation')
            )
          ],
        ),
      ),
    );
    }
  }



//class MyHomePage extends StatefulWidget {
//  MyHomePage({Key key, this.title}) : super(key: key);
//  final String title;
//
//  @override
//  _MyHomePageState createState() => _MyHomePageState();
//}
//
//class _MyHomePageState extends State<MyHomePage> {
//  int _counter = 0;
//
//  void _incrementCounter() {
//    setState(() {
//      _counter++;
//    });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//
//    return Scaffold(
//      appBar: AppBar(
//        title: Text(widget.title),
//      ),
//      body: Center(
//        child: Column(
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: <Widget>[
//            Text(
//              'You have pushed the button this many times:',
//            ),
//            Text(
//              '$_counter',
//              style: Theme.of(context).textTheme.display1,
//            ),
//          ],
//        ),
//      ),
//      floatingActionButton: FloatingActionButton(
//        onPressed: _incrementCounter,
//        tooltip: 'Increment',
//        child: Icon(Icons.add),
//      ), // This trailing comma makes auto-formatting nicer for build methods.
//    );
//  }
//}*/
