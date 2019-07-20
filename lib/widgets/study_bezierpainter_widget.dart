import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:flutter_weekly/common/utils/screen.dart';
class CustomBezierWidget extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return CustomPaint(
    painter: BezierPainter(),
    );
  }
}



class BezierPainter extends CustomPainter{

  Paint _paint=Paint()..color=Colors.deepOrange..style=PaintingStyle.fill..isAntiAlias=true..strokeWidth=1;

  Path _path=Path();


  Offset offset1=Offset(10, Screen.screenHeightDp-80);

  Offset offset2=Offset(Screen.screenWidthDp, Screen.screenHeightDp-80);

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    _path.lineTo(100, 200);
    canvas.drawPoints(PointMode.points, [Offset(100,100)], _paint);
    canvas.drawPath(_path, _paint);
    _path.moveTo(offset1.dx,offset1.dy);
    _paint.color=Colors.deepOrange;
    _path.cubicTo(offset1.dx, offset1.dy, Screen.screenWidthDp/6,Screen.screenHeightDp/2+100, offset2.dx, offset2.dy);
    canvas.drawPath(_path, _paint);
    _path.cubicTo(offset1.dx, offset1.dy, Screen.screenWidthDp/6,Screen.screenHeightDp/2+100, offset2.dx, offset2.dy);
    canvas.drawPath(_path, _paint);
    //canvas.drawLine(Offset(0, 0), Offset(0, 20), _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}