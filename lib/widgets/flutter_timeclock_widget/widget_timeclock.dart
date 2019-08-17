import 'dart:ui';
import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_weekly/common/utils/screen.dart';

import '../flip_card_widget.dart';

class TimeClockWidgetPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //这里因为画笔本身定义的是以（0,0）点为中心点，所以此处用Center
    //前
    var frontWidget = Container(
      height: Screen.screenHeightDp - 200,
      width: Screen.screenWidthDp - 40,
      child: Card(
        color: Theme.of(context).primaryColor,
        child: TimeClockWidget(Colors.white),
      ),
    );
    //后
    var backWidget = Container(
      height: Screen.screenHeightDp - 200,
      width: Screen.screenWidthDp - 40,
      child: Card(
        color: Theme.of(context).primaryColor,
        child: Center(
            child:CustomPaint(
              painter: CustomCirclesPainter(Colors.white),
            )),
      ),
    );

    return Scaffold(
        appBar: AppBar(
          title: Text("TimeClock"),
        ),
        body: Center(
          child: FlipCardWidget(
            frontWidget: frontWidget,
            backWidget: backWidget,
          ),
        ));
  }
}

class CustomCirclesPainter extends CustomPainter {
  Paint myPaint = Paint()
    ..color = Colors.deepOrange
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1.0;

  double radius = (Screen.screenWidthDp - 100) / 4;

  CustomCirclesPainter(Color color) {
    myPaint.color = color;
  }

  @override
  void paint(Canvas canvas, Size size) {
    int n = 20;
    var range = List<int>.generate(n, (i) => i + 1);
    for (int i in range) {
      double x = 2 * math.pi / n;
      double dx = radius * math.sin(i * x);
      double dy = radius * math.cos(i * x);
      //  print("dx${i.toString()}=>${dx.toString()}");
      //print("dy${i.toString()}=>${dy.toString()}");
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
  final Color color;

  TimeClockWidget(this.color);

  @override
  _TimeClockWidgetState createState() => _TimeClockWidgetState();
}

class _TimeClockWidgetState extends State<TimeClockWidget> {
  Timer timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {});
    });
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    print("deactivate");
    timer.cancel();
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
        child: CustomPaint(painter: CustomTimeClock(this.widget.color)));
  }
}

class CustomTimeClock extends CustomPainter {
  CustomTimeClock(this.color) {
    //大外圆
    _bigCirclePaint = Paint()
      ..style = PaintingStyle.stroke
      ..isAntiAlias = true
      ..color = color
      ..strokeWidth = 4;

    //粗刻度线
    _linePaint = Paint()
      ..style = PaintingStyle.fill
      ..isAntiAlias = true
      ..color = color
      ..strokeWidth = 4;
  }

  final Color color;

  //大外圆
  Paint _bigCirclePaint;

  //粗刻度线
  Paint _linePaint;

  //圆心
  Offset _centerOffset = Offset(0, 0);

  //圆半径
  double _bigRadius =
      math.min(Screen.screenHeightDp / 3, Screen.screenWidthDp / 3);

  final int lineHeight = 10;

  //文字画笔
  TextPainter _textPainter = new TextPainter(
      textAlign: TextAlign.left, textDirection: TextDirection.ltr);

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    // print('_bigRadius: ${_bigRadius.toString()}');
    //绘制大圆
    canvas.drawCircle(_centerOffset, _bigRadius, _bigCirclePaint);
    //绘制圆心
    canvas.drawCircle(_centerOffset, _bigRadius / 20, _linePaint);
    //绘制刻度,秒针转一圈需要跳60下,这里只画6点整的刻度线，但是由于每画一条刻度线之后，画布都会旋转60°(转为弧度2*pi/60)，所以画出60条刻度线
    for (int i = 0; i < 60; i++) {
      _linePaint.strokeWidth = i % 5 == 0 ? (i % 3 == 0 ? 10 : 4) : 1; //设置线的粗细
      canvas.drawLine(Offset(0, _bigRadius - lineHeight), Offset(0, _bigRadius),
          _linePaint);
      canvas.rotate(math.pi / 30); //2*math.pi/60
    }
    //绘制数字,
    for (int i = 0; i < 12; i++) {
      canvas.save();
      canvas.translate(0.0, -_bigRadius + 30);
      _textPainter.text = TextSpan(
          style: new TextStyle(color: color, fontSize: 22), text: i.toString());
      canvas.rotate(-deg2Rad(30) * i);
      _textPainter.layout();
      _textPainter.paint(
          canvas, Offset(-_textPainter.width / 2, -_textPainter.height / 2));
      canvas.restore();
      canvas.rotate(deg2Rad(30));
    }
    //绘制指针,这个也好理解
    int hours = DateTime.now().hour;
    int minutes = DateTime.now().minute;
    int seconds = DateTime.now().second;
    /*print(
        "时: ${hours.toString()} 分：${minutes.toString()} 秒: ${seconds.toString()}");*/
    //时针角度//以下都是以12点为0°参照
    //12小时转360°所以一小时30°
    double hoursAngle =
        (minutes / 60 + hours - 12) * math.pi / 6; //把分钟转小时之后*（2*pi/360*30）
    //分针走过的角度,同理,一分钟6°
    double minutesAngle =
        (minutes + seconds / 60) * math.pi / 30; //(2*pi/360*6)
    //秒针走过的角度,同理,一秒钟6°
    double secondsAngle = seconds * math.pi / 30;
    //画时针
    _linePaint.strokeWidth = 4;
    canvas.rotate(hoursAngle);
    canvas.drawLine(Offset(0, 0), new Offset(0, -_bigRadius + 80), _linePaint);
    //画分针
    _linePaint.strokeWidth = 2;
    canvas.rotate(-hoursAngle); //先把之前画时针的角度还原。
    canvas.rotate(minutesAngle);
    canvas.drawLine(Offset(0, 0), new Offset(0, -_bigRadius + 60), _linePaint);
    //画秒针
    _linePaint.strokeWidth = 1;
    canvas.rotate(-minutesAngle); //同理
    canvas.rotate(secondsAngle);
    canvas.drawLine(Offset(0, 0), new Offset(0, -_bigRadius + 30), _linePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }

  static TextPainter _getTextPainter(String msg) {
    return new TextPainter(
        text: TextSpan(
            style: new TextStyle(color: Colors.deepOrange, fontSize: 22),
            text: msg),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);
  }

  //角度转弧度
  num deg2Rad(num deg) => deg * (math.pi / 180.0);
}
