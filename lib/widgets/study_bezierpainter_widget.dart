import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:math' as math;
import 'package:flutter_weekly/common/utils/screen.dart';

import 'delay_tween.dart';

///贝塞尔曲线示例一
class CustomBezierWidget extends StatefulWidget {
  @override
  _BezierWidgetState createState() {
    // TODO: implement createState
    return _BezierWidgetState();
  }
}

class _BezierWidgetState extends State<CustomBezierWidget> {
  Timer timer;

  int height = 100;

  bool flag = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timer = Timer.periodic(Duration(microseconds: 5000), (timer) {
      setState(() {
        if (flag) {
          height = height - 1;
        } else {
          height = height + 1;
        }

        if (height == -100) {
          flag = false;
        }

        if (height == 100) flag = true;
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

class BezierPainter extends CustomPainter {
  final int height;

  BezierPainter(this.height);

  Paint _paint = Paint()
    ..color = Colors.deepOrange
    ..style = PaintingStyle.fill
    ..isAntiAlias = true
    ..strokeWidth = 10;

  Paint _pointPaint = Paint()
    ..color = Colors.teal
    ..strokeWidth = 10
    ..isAntiAlias = true
    ..style = PaintingStyle.fill;

  Path _path = Path();

  Offset offset1 = Offset(0, Screen.screenHeightDp / 2);

  Offset offset2 = Offset(Screen.screenWidthDp / 2, Screen.screenHeightDp / 2);

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    print('Size.width==>${size.width} Size.height==>${size.height}');
    print(
        'Screen.width==>${Screen.screenWidthDp} Screen.height==>${Screen.screenHeightDp}');
    _path.moveTo(0, Screen.screenHeightDp / 2);
    _paint.color = Colors.deepOrange;

    _path.quadraticBezierTo(
        Screen.screenWidthDp / 4,
        Screen.screenHeightDp / 2 - this.height,
        Screen.screenWidthDp / 2,
        Screen.screenHeightDp / 2);
    canvas.save();
    canvas.restore();

    _path.moveTo(Screen.screenWidthDp / 2, Screen.screenHeightDp / 2);
    _path.quadraticBezierTo(
        Screen.screenWidthDp / 4 * 3,
        Screen.screenHeightDp / 2 + this.height,
        Screen.screenWidthDp,
        Screen.screenHeightDp / 2);

    canvas.drawPath(_path, _paint);

    //描绘控制点
    canvas.drawPoints(
        PointMode.points,
        [
          Offset(0, Screen.screenHeightDp / 2),
          Offset(Screen.screenWidthDp / 4,
              Screen.screenHeightDp / 2 - this.height),
          Offset(Screen.screenWidthDp / 2, Screen.screenHeightDp / 2)
        ],
        _pointPaint);
    canvas.drawPoints(
        PointMode.points,
        [
          Offset(Screen.screenWidthDp / 2, Screen.screenHeightDp / 2),
          Offset(Screen.screenWidthDp / 4 * 3,
              Screen.screenHeightDp / 2 + this.height),
          Offset(Screen.screenWidthDp, Screen.screenHeightDp / 2)
        ],
        _pointPaint);
    //canvas.drawLine(Offset(0, 0), Offset(0, 20), _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}

///贝塞尔曲线示例二
class CustomBezierWidget1 extends StatefulWidget {
  @override
  _CustomBezierWidget1State createState() => _CustomBezierWidget1State();
}

class _CustomBezierWidget1State extends State<CustomBezierWidget1>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;

  Animation<double> animation;

  final double _waveLength = 300; //波浪长

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 600));
    animation = Tween<double>(begin: 0, end: 300).animate(animationController)
      ..addListener(() {
        setState(() {});
      });
    animationController.repeat();
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    animationController.stop();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: BezierPainter1(animation.value, _waveLength),
    );
  }
}

class BezierPainter1 extends CustomPainter {
  final double myOffsetX; //平移量
  final int _waveHeight = 30; //波浪高
  final double waveLength; //一个波浪的长度

  Paint _pointPaint; //点画笔
  Paint _pathPaint; //线画笔
  Paint _whitePaint; //空白画笔
  double _screenHeight; //屏幕高
  double _screenWidth; //屏幕宽
  double _centerY; //屏幕中间Y坐标

  int _waveCount; //波浪个数

  Path _path = Path(); //路径

  BezierPainter1(this.myOffsetX, this.waveLength) {
    _pointPaint = Paint()
      ..color = Colors.teal
      ..strokeWidth = 4
      ..isAntiAlias = true
      ..style = PaintingStyle.fill;
    _pathPaint = Paint()
      ..color = Colors.deepOrange
      ..style = PaintingStyle.fill
      ..isAntiAlias = true
      ..strokeWidth = 1;

    _whitePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill
      ..isAntiAlias = true
      ..strokeWidth = 1;
  }

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    _screenHeight = size.height;
    _screenWidth = size.width;
    _waveCount = (_screenWidth / waveLength + 1.5).round();
    _centerY = _screenHeight / 2;
    _path.moveTo(-waveLength + this.myOffsetX, _centerY); //Y移到屏幕中间

    for (int i = 0; i < _waveCount; i++) {
      canvas.save();
      canvas.restore();
      _path.quadraticBezierTo(
          -waveLength / 4 * 3 + (waveLength * i) + this.myOffsetX,
          _centerY + _waveHeight,
          -waveLength / 2 + (waveLength * i) + this.myOffsetX,
          _centerY);
      _path.quadraticBezierTo(
          -waveLength / 4 + (waveLength * i) + this.myOffsetX,
          _centerY - _waveHeight,
          0 + waveLength * i + this.myOffsetX,
          _centerY);

      //控制点绘画
/*      canvas.drawPoints(PointMode.points, [
        Offset(-waveLength/4*3+(waveLength*i)+this.myOffsetX, _centerY+_waveHeight),
        Offset(-waveLength/2+(waveLength*i)+this.myOffsetX, _centerY),
        Offset(-waveLength/4+(waveLength*i)+this.myOffsetX, _centerY-_waveHeight),
        Offset(0+waveLength*i+this.myOffsetX, _centerY),
      ], _pointPaint);*/
      canvas.drawPath(_path, _whitePaint);
    }
    _path.lineTo(_screenWidth, _screenHeight);
    _path.lineTo(0, _screenHeight);
    _path.close();
    canvas.drawPath(_path, _pathPaint);

    /* canvas.save();
     canvas.restore();
    _path.quadraticBezierTo(-_waveLength/4*3, _centerY+_waveHeight, -_waveLength/2, _centerY);

    canvas.save();
    canvas.restore();
    _path.moveTo(-_waveLength/2, _centerY);
    _path.quadraticBezierTo(-_waveLength/4, _centerY-_waveHeight, 0, _centerY);

    canvas.save();
    canvas.restore();
    _path.moveTo(0, _screenHeight / 2);
    _path.quadraticBezierTo(_waveLength/4, _centerY+_waveHeight, _waveLength/2, _centerY);

    canvas.save();
    canvas.restore();
    _path.moveTo(_waveLength/2, _centerY);
    _path.quadraticBezierTo(_waveLength/4*3, _centerY-_waveHeight, _waveLength, _centerY);

    canvas.drawPath(_path, _pathPaint);*/
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}

/// 贝塞尔曲线示例三
class CustomBezierWidget2 extends StatefulWidget {
  @override
  _CustomBezierWidget2State createState() => _CustomBezierWidget2State();
}

class _CustomBezierWidget2State extends State<CustomBezierWidget2>
    with SingleTickerProviderStateMixin {


  Timer timer;

  int height = 20;

  bool flag = true;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timer = Timer.periodic(Duration(microseconds: 12000), (timer) {
      setState(() {
        if (flag) {
          height = height - 1;
        } else {
          height = height + 1;
        }

        if (height == -20) {
          flag = false;
        }

        if (height == 20) flag = true;
      });
    });


  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer.cancel();

  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: BezierPainter2(40,height.toDouble()),
    );
  }
}

class BezierPainter2 extends CustomPainter {
  final double waveHeight; //波浪高
  final double progress; //进度

  double waveLength; //一个波浪的长度

  Offset _progressOffset; //延竖直Y轴进度的Y轴
  double _progressXianXLength; //移动中半弦的长度,
  double _progressY; //移动中Y的坐标
  double _progressX; //移动中X的坐标

  Paint _pointPaint; //点画笔
  Paint _pathPaint; //线画笔
  Paint _whitePaint; //空白画笔

  Path _path = Path(); //路径

  Offset centerOffset; //圆心
  double _r; //半径


  double tranlateX=-160;

  BezierPainter2(this.progress, this.waveHeight) {
    _pointPaint = Paint()
      ..color = Colors.teal
      ..strokeWidth = 4
      ..isAntiAlias = true
      ..style = PaintingStyle.stroke;
    _pathPaint = Paint()
      ..color = Colors.deepOrange
      ..style = PaintingStyle.fill
      ..isAntiAlias = true
      ..strokeWidth = 1;
    _whitePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..isAntiAlias = true
      ..strokeWidth = 1;
    centerOffset = Offset(Screen.screenWidthDp / 2, Screen.screenHeightDp / 2);
    _r = Screen.screenWidthDp / 3;
  }

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint

    _path.addArc(Rect.fromCircle(center: centerOffset, radius: _r), 0, 360);
    canvas.clipPath(_path); //把画布裁剪成一个圆形,这样怎么画都是圆。
    canvas.drawCircle(centerOffset, _r, _pointPaint); //画圆
    _path.reset();

    _progressXianXLength = math.sqrt(math.pow(_r, 2) -
        math.pow((_r - _r / 50 * this.progress), 2)); //三角形勾股定理

    waveLength = _progressXianXLength; //弦长为波长,_progressXianXLength为半弦
    _progressY = centerOffset.dy + (_r - _r / 50 * this.progress); //算出Y点的坐标
    _progressX = centerOffset.dx; //算出X点的坐标
    _progressOffset =
        Offset(_progressX, _progressY); //此坐标即是第一个贝塞尔曲线的终点，也是第 二个贝塞尔曲线的起点

    //print("移动中的坐标点: ${_progressOffset.toString()}");
    //print("centerOffset: ${centerOffset.toString()}");
    //画弦
    _path.moveTo(_progressOffset.dx - waveLength, _progressOffset.dy);

    for(int i=0;i<2;i++){

      _path.quadraticBezierTo(
          _progressOffset.dx - waveLength / 4*3+waveLength*i,
          _progressOffset.dy - waveHeight,
          _progressOffset.dx-waveLength/2+waveLength*i,
          _progressOffset.dy);
      _path.moveTo( _progressOffset.dx-waveLength/2+waveLength*i, _progressOffset.dy);
      _path.quadraticBezierTo(
          _progressOffset.dx - waveLength / 4+waveLength*i,
          _progressOffset.dy + waveHeight,
          _progressOffset.dx +waveLength*i,
          _progressOffset.dy);
    }


    //封闭圆
    if (this.progress <= 50) {
      //封闭下半圆
      _path.moveTo(
          _progressOffset.dx + _progressXianXLength, _progressOffset.dy); //
      _path.lineTo(_progressOffset.dx + _progressXianXLength,
          _progressOffset.dy + _progressXianXLength);
      _path.lineTo(_progressOffset.dx - _progressXianXLength,
          _progressOffset.dy + _progressXianXLength);
      _path.lineTo(
          _progressOffset.dx - _progressXianXLength, _progressOffset.dy);
    } else {
      //封闭上半圆
      _path.moveTo(_progressOffset.dx + _r, _progressOffset.dy);
      _path.lineTo(_progressOffset.dx + _r, centerOffset.dy + _r);
      _path.lineTo(_progressOffset.dx - _r, centerOffset.dy + _r);
      _path.lineTo(_progressOffset.dx - _r, _progressOffset.dy);
    }
    _path.close();
    canvas.drawPath(_path, _pathPaint);
    canvas.save();
    canvas.restore();
    if(tranlateX+40>=0){
      tranlateX=-160;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}



