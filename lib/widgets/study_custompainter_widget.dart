import 'package:flutter/material.dart';
import 'dart:math';
class PaintWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(
        painter: CustomCirclesPainter(),
      ),
    );
  }
}


class StudyPainter extends CustomPainter{

  Paint _myPaint=new Paint()..color=Colors.deepOrange..strokeWidth=2..style=PaintingStyle.fill;
  Paint _myPaint1=new Paint()..color=Colors.green..strokeWidth=2..style=PaintingStyle.fill;
  Paint _myPaint2=new Paint()..color=Colors.blue..strokeWidth=2..style=PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    canvas.drawCircle(Offset(0.0, 0.0), 100, _myPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }



}
class CustomCirclesPainter extends CustomPainter {
  var myPaint = Paint()
    ..color = Colors.deepOrange
    ..style = PaintingStyle.stroke
    ..strokeWidth = 5.0;

  double radius = 90;

  @override
  void paint(Canvas canvas, Size size) {
    int n = 3;
    var range = List<int>.generate(n, (i) => i + 1);
    for (int i in range) {
      double x = 2 * pi / n;
      double dx = radius * sin(i * x);
      double dy = radius * cos(i * x);
      canvas.drawCircle(Offset(dx, dy), radius, myPaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}


