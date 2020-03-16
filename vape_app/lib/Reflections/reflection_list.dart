import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vape_app/Models/Reflection.dart';
import 'package:vape_app/services/reflections.dart';

import 'ReflectionTile.dart';

class ReflectionList extends StatefulWidget {
  
  @override
  _ReflectionListState createState() => _ReflectionListState();
}

class _ReflectionListState extends State<ReflectionList> {
  //removeReflection() is a function which removes a reflection once the reflection is swiped
  void removeReflection(var documentID, ReflectionsService reflection) async {
    await reflection.deleteReflection(documentID);
  }

  @override
  Widget build(BuildContext context) {
    final reflections = Provider.of<List<Reflection>>(context)??[];
    var getReflectionsLength = reflections.length;
    
    return ListView.builder(
      itemCount: getReflectionsLength,
      itemBuilder: (context, index) {
        return ReflectionTile(reflection:reflections[index],
        onDelete:(documentID,reflection)=>removeReflection(documentID,reflection));
      });
  }
}