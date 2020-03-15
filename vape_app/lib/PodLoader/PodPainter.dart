import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PodPainter extends CustomPainter{

  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint();
    //top black part
    paint1.color= Colors.black;
    var pathTop = Path();
    pathTop.lineTo(0, 100*0.45);
    pathTop.lineTo(50*0.1, 100*0.45);
    pathTop.lineTo(50*0.25, 100*0.375);
    pathTop.lineTo(50*0.75, 100*0.375);
    pathTop.lineTo(50*0.9, 100*0.45);
    pathTop.lineTo(50, 100*0.45);
    pathTop.lineTo(50, 0);
    pathTop.lineTo(0, 0);
    pathTop.close();
    canvas.drawPath(pathTop, paint1);

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}