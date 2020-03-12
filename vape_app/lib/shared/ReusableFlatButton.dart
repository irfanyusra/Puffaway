import 'package:flutter/material.dart';


//A reusable flat button as the name suggests
//Modular way of creating icons easily
class ResuableFlatButton extends StatelessWidget {
  final Icon icon;
  final Color iconColor;
  final Text label;
  final Function onPressed;

  const ResuableFlatButton({
    Key key,
    this.icon,
    this.iconColor,
    this.label,
    this.onPressed
    
  }) : super(key: key);
  //etc

  @override
  Widget build(BuildContext context) {
    return FlatButton.icon(
      icon: icon,
      color: iconColor,
      label: label,
      onPressed:onPressed);
      }
}