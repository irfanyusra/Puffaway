import 'package:flutter/material.dart';
import 'package:vape_app/pages/all_logs.dart';
import 'package:vape_app/pages/loading.dart';
import 'package:vape_app/pages/logging_trigger.dart';
import 'package:vape_app/pages/recommendation_page.dart';
import 'package:vape_app/pages/reflections_page.dart';
import 'package:vape_app/pages/Home.dart';

void main() => runApp(App(
      /*initialRoute: '/',
      routes: {
        '/': (context) => Loading(),
        '/logging_trigger': (context) => LoggingTrigger(),
        '/recommendations': (context) => Recommendation(),
        '/reflections': (context) => Reflections(),
        '/all_logs': (context) => AllLogs(),
        //add more routes here
      },*/
    )
//    MyApp()
);

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}
/*class MyApp extends StatefulWidget{
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
    final List<Widget> pageOptions = [
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
}*/
