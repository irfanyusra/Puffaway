import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PodPainter extends CustomPainter{

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    //top black part
    paint.color= Colors.black;
    var pathTop = Path();
    pathTop.lineTo(0, size.height*0.45);
    pathTop.lineTo(size.width*0.1, size.height*0.45);
    pathTop.lineTo(size.width*0.25, size.height*0.375);
    pathTop.lineTo(size.width*0.75, size.height*0.375);
    pathTop.lineTo(size.width*0.9, size.height*0.45);
    pathTop.lineTo(size.width, size.height*0.45);
    pathTop.lineTo(size.width, 0);
    pathTop.lineTo(0, 0);
    pathTop.close();
    canvas.drawPath(pathTop, paint);

    paint.color=Colors.grey.withOpacity(0.5);
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