import 'package:flutter/material.dart';

//A reusable flat button as the name suggests
//Modular way of creating icons easily
class ResuableFlatButton extends StatelessWidget {
  final Icon icon;
  final Color iconColor;
  final Text label;
  final Function onPressed;
  final Widget child;

  const ResuableFlatButton(
      {Key key,
      this.icon,
      this.iconColor,
      this.label,
      this.onPressed,
      this.child})
      : super(key: key);
  //etc

  @override
  Widget build(BuildContext context) {
    return icon == null
        ? FlatButton(color: iconColor, child: child, onPressed: onPressed)
        : FlatButton.icon(
            icon: icon, color: iconColor, label: label, onPressed: onPressed);
  }
}
