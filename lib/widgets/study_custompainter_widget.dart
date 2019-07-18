import 'dart:ui';
import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_weekly/common/utils/screen.dart';

class PaintWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(painter:CustomCirclesPainter(),
          ),
    );
  }
}

class StudyPainter extends CustomPainter {
  Paint _myPaint = new Paint()
    ..color = Colors.deepOrange
    ..strokeWidth = 2
    ..style = PaintingStyle.fill;
  Paint _myPaint1 = new Paint()
    ..color = Colors.green
    ..strokeWidth = 2
    ..style = PaintingStyle.fill;
  Paint _myPaint2 = new Paint()
    ..color = Colors.blue
    ..strokeWidth = 2
    ..style = PaintingStyle.fill;

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
    ..strokeWidth = 1.0;

  double radius = (Screen.screenWidthDp - 20) / 4;

  @override
  void paint(Canvas canvas, Size size) {
    int n = 20;
    var range = List<int>.generate(n, (i) => i + 1);
    for (int i in range) {
      double x = 2 * math.pi / n;
      double dx = radius * math.sin(i * x);
      double dy = radius * math.cos(i * x);
      print("dx${i.toString()}=>${dx.toString()}");
      print("dy${i.toString()}=>${dy.toString()}");
      canvas.drawCircle(Offset(dx, dy), radius, myPaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}



//////////////////////////////////////////////以下是时钟的代码///////////////////////
class TimeClockWidget extends StatefulWidget {
  @override
  _TimeClockWidgetState createState() => _TimeClockWidgetState();
}

class _TimeClockWidgetState extends State<TimeClockWidget> {

   Timer timer;


   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timer=Timer.periodic(Duration(seconds: 1), (timer){
      setState(() {
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
    return Center(
      child:  CustomPaint(painter: CustomTimeClock())
    );
  }


}



class CustomTimeClock extends CustomPainter {
  //大外圆
  Paint _bigCirclePaint = Paint()
    ..style = PaintingStyle.stroke
    ..isAntiAlias = true
    ..color = Colors.deepOrange
    ..strokeWidth = 4;

  //中心实心小圆
  Paint _centerCirclePaint = Paint()
    ..style = PaintingStyle.fill
    ..isAntiAlias = true
    ..color = Colors.deepOrange
    ..strokeWidth = 2;

  //粗刻度线
  Paint _linePaint = Paint()
    ..style = PaintingStyle.fill
    ..isAntiAlias = true
    ..color = Colors.deepOrange
    ..strokeWidth = 4;

  //圆心
  Offset _centerOffset = Offset(0, 0);

  //圆半径
  double _bigRadius =
      math.min(Screen.screenHeightDp / 3, Screen.screenWidthDp / 3);

  List<TextPainter> _textPaint=[
    _getTextPainter("12"),
    _getTextPainter("3"),
    _getTextPainter("6"),
    _getTextPainter("9"),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    print('_bigRadius: ${_bigRadius}');
    //绘制大圆
    canvas.drawCircle(_centerOffset, _bigRadius, _bigCirclePaint);
    //绘制圆心
    canvas.drawCircle(_centerOffset, _bigRadius / 20, _centerCirclePaint);
    //绘制刻度,秒针转一圈需要跳60下
    for (int i = 0; i < 60; i++) {
      _linePaint.strokeWidth = i % 5 == 0 ? (i % 3 == 0 ? 10 : 4) : 1;
      canvas.drawLine(
          Offset(0, _bigRadius - 10), Offset(0, _bigRadius), _linePaint);
      canvas.rotate(math.pi / 30); //2*math.pi/60
    }
    //绘制数字,此处暂时没想到更好的方法,TextPainter的绘制间距老有问题,不好控制
    _textPaint[0].layout();
    _textPaint[0].paint(canvas, new Offset(-12, -_bigRadius+20));
    _textPaint[1].layout();
    _textPaint[1].paint(canvas, new Offset(_bigRadius-30,-12));
    _textPaint[2].layout();
    _textPaint[2].paint(canvas, new Offset(-6,_bigRadius-40));
    _textPaint[3].layout();
    _textPaint[3].paint(canvas, new Offset(-_bigRadius+20,-12));

    //绘制指针
    int hours=DateTime.now().hour;
    int minutes=DateTime.now().minute;
    int seconds=DateTime.now().second;
    print("时: ${hours} 分：${minutes} 秒: ${seconds}");
    //时针角度//以下都是以12点为0°参照
    double hoursAngle=(minutes/60+hours-12)*math.pi/6;
    //分针走过的角度
    double minutesAngle=(minutes+seconds/60)*math.pi/30;
    //秒针走过的角度
    double secondsAngle = seconds * math.pi/30;
    //画时针
    _linePaint.strokeWidth=4;
    canvas.rotate(hoursAngle);
    canvas.drawLine(Offset(0, 0), new Offset(0, -_bigRadius+80), _linePaint);
    //画分针
    _linePaint.strokeWidth=2;
    canvas.rotate(-hoursAngle);
    canvas.rotate(minutesAngle);
    canvas.drawLine(Offset(0, 0), new Offset(0, -_bigRadius+60), _linePaint);
    //画秒针
    _linePaint.strokeWidth=1;
    canvas.rotate(-minutesAngle);
    canvas.rotate(secondsAngle);
    canvas.drawLine(Offset(0, 0), new Offset(0, -_bigRadius+30), _linePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }

  static TextPainter _getTextPainter(String msg) {
    return  new TextPainter(
        text: TextSpan(
            style: new TextStyle(color: Colors.deepOrange,fontSize: 22),
            text: msg),
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr);
  }


}
