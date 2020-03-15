import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PodLevel extends CustomPainter{

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();

    paint.color=Colors.amberAccent;
    var pathB = Path();
    pathB.moveTo(0, 0.45);
    pathB.lineTo(size.width*0.1, size.height*0.45);
    pathB.lineTo(size.width*0.25, size.height*0.375);
    pathB.lineTo(size.width*0.75, size.height*0.375);
    pathB.lineTo(size.width*0.9, size.height*0.45);
    pathB.lineTo(size.width, size.height*0.45);
    pathB.lineTo(size.width, size.height*0.875);
    pathB.lineTo(size.width*0.85, size.height);
    pathB.lineTo(size.width*0.15, size.height);
    pathB.lineTo(0, size.height*0.875);
    pathB.lineTo(0, size.height*0.45);
    pathB.lineTo(size.width*0.1, size.height*0.45);
    pathB.close();
    canvas.drawPath(pathB, paint);

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}