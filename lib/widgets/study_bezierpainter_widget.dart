import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:flutter_weekly/common/utils/screen.dart';
class CustomBezierWidget extends StatefulWidget {


  @override
  _BezierWidgetState createState() {
    // TODO: implement createState
    return _BezierWidgetState();
  }
}

class _BezierWidgetState extends State<CustomBezierWidget> {
  Timer timer;

  int height=100;

  bool flag=true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timer = Timer.periodic(Duration(microseconds: 5000), (timer) {
      setState(() {
        if(flag){
          height=height-1;

        }else{
          height=height+1;
        }

        if(height==-100){
          flag=false;
        }

        if(height==100)flag=true;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: BezierPainter(height));
  }
}



class BezierPainter extends CustomPainter{

  final int height;

  BezierPainter(this.height);

  Paint _paint=Paint()..color=Colors.deepOrange..style=PaintingStyle.fill..isAntiAlias=true..strokeWidth=10;

  Path _path=Path();


  Offset offset1=Offset(0, Screen.screenHeightDp/2);

  Offset offset2=Offset(Screen.screenWidthDp/2, Screen.screenHeightDp/2);

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint

    _path.moveTo(0,Screen.screenHeightDp/2);
    _paint.color=Colors.deepOrange;
    //canvas.drawPoints(PointMode.points, [Offset(Screen.screenWidthDp,Screen.screenHeightDp/2),offset1,offset2], _paint);
    _path.quadraticBezierTo(Screen.screenWidthDp/4, Screen.screenHeightDp/2-this.height, Screen.screenWidthDp/2,Screen.screenHeightDp/2);

    canvas.save();
    canvas.restore();


    _path.moveTo(Screen.screenWidthDp/2,Screen.screenHeightDp/2);
    _path.quadraticBezierTo(Screen.screenWidthDp/4*3,  Screen.screenHeightDp/2+this.height, Screen.screenWidthDp,Screen.screenHeightDp/2);

    canvas.drawPath(_path, _paint);
    //canvas.drawLine(Offset(0, 0), Offset(0, 20), _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}