import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vape_app/Models/Reflection.dart';
import 'package:vape_app/Models/User.dart';
import 'package:vape_app/pages/reflection_list.dart';
import 'package:vape_app/services/database.dart';
import 'package:provider/provider.dart';

class AllReflections extends StatefulWidget {
  final Function toggleDiary;
  AllReflections({this.toggleDiary});
  @override
  _AllReflectionsState createState() => _AllReflectionsState();
}

class _AllReflectionsState extends State<AllReflections> {
  //TODO: delete btn
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamProvider<List<Reflection>>.value(
          value:DatabaseService(uid:user.uid).reflections,
          child: Scaffold(
        appBar: AppBar(
          title: Text('All Reflections'),
          centerTitle: true,
        ),
        body:ReflectionList()),
     
    );
  }
}
