import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:math' as math;
import 'package:flutter_weekly/common/utils/screen.dart';

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
  final int height; //波的高度

  BezierPainter(this.height);

  //路径画笔
  Paint _paint = Paint()
    ..color = Colors.deepOrange
    ..style = PaintingStyle.fill
    ..isAntiAlias = true
    ..strokeWidth = 10;

  //点画笔
  Paint _pointPaint = Paint()
    ..color = Colors.teal
    ..strokeWidth = 10
    ..isAntiAlias = true
    ..style = PaintingStyle.fill;

  //曲线路径
  Path _path = Path();

  ///屏幕左上脚的坐标顶点对应着(0,0)点
  //屏幕中左侧点
  Offset offset1 = Offset(0, Screen.screenHeightDp / 2);

  //屏幕终点
  Offset offset2 = Offset(Screen.screenWidthDp / 2, Screen.screenHeightDp / 2);

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    print('Size.width==>${size.width} Size.height==>${size.height}');
    print(
        'Screen.width==>${Screen.screenWidthDp} Screen.height==>${Screen.screenHeightDp}');
    _path.moveTo(offset1.dx, offset1.dy);

    ///假设,整个波长=屏幕宽度=M,画的是一条正弦
    ///绘制波峰
    ///波峰控制点就在(M/4,centerY-波纹高度),终点在屏幕中点
    _path.quadraticBezierTo(
        Screen.screenWidthDp / 4,
        Screen.screenHeightDp / 2 - this.height,
        Screen.screenWidthDp / 2,
        Screen.screenHeightDp / 2);

    ///绘制波谷,此时画笔的起点已经在屏幕中心
    ///波谷控制点就在(3M/4,centerY+波纹高度),终点在屏幕中线终点
    _path.quadraticBezierTo(
        Screen.screenWidthDp / 4 * 3,
        Screen.screenHeightDp / 2 + this.height,
        Screen.screenWidthDp,
        Screen.screenHeightDp / 2);

    ///绘制,可以把style = PaintingStyle.fill换成stoke看看效果
    canvas.drawPath(_path, _paint);

    //描绘辅助控制点
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
    _screenHeight = size.height; //屏幕高,这里不是一直成立,像当有Center 父控件的时候就不成立
    _screenWidth = size.width; //屏幕宽
    _waveCount = (_screenWidth / waveLength)
        .round(); //根据波长算出波的个数,这里的波浪个数多一点,这样可以在屏幕内看到更完整的波浪
    _centerY = _screenHeight / 2; //中心高度的值
    _path.moveTo(
        -waveLength + this.myOffsetX, _centerY); //把画笔的起点移到屏幕外的一个波长处,Y轴在屏幕中间
    //this.myOffsetX水平方向的偏移量
    for (int i = 0; i < _waveCount; i++) {
      canvas.save();
      canvas.restore();
      //绘制波谷,控制点在(-3M/4,_centerY),结束点在(-waveLength / 2,_centerY)
      //此处可以先把(waveLength * i) + this.myOffsetX 这段代码移除,所画的就是一个波谷,屏幕外的波谷
      _path.quadraticBezierTo(
          -waveLength / 4 * 3 + (waveLength * i) + this.myOffsetX,
          _centerY + _waveHeight,
          -waveLength / 2 + (waveLength * i) + this.myOffsetX,
          _centerY);
      //绘制波峰,控制点在(-M/4,_centerY),结束点在(0,_centerY)
      //此处可以先把(waveLength * i) + this.myOffsetX 这段代码移除,所画的就是一个波峰,屏幕外的波峰
      _path.quadraticBezierTo(
          -waveLength / 4 + (waveLength * i) + this.myOffsetX,
          _centerY - _waveHeight,
          0 + waveLength * i + this.myOffsetX,
          _centerY);
      canvas.drawPath(_path, _whitePaint); //绘制
    }

    ///封闭绘制区域,构成“深水面”
    _path.lineTo(_screenWidth, _screenHeight); //将画笔从当前位置画到屏幕最右下角
    _path.lineTo(0, _screenHeight); //画到屏幕左下角
    _path.close();
    canvas.drawPath(_path, _pathPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}

/// 贝塞尔曲线示例三

class CustomBezierWidget2 extends StatefulWidget {
  final double progress;

  CustomBezierWidget2(this.progress);

  @override
  _CustomBezierWidget2State createState() => _CustomBezierWidget2State();
}

class _CustomBezierWidget2State extends State<CustomBezierWidget2>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  Animation<double> _animationTranslate;

  double _moveX; //移动的X,此处变化一个波长
  double _r; //半径
  double waveLength; //波长

  double _waveCount = 2;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _r = Screen.screenWidthDp / 3;
    waveLength = 2 * _r / _waveCount;
    _animationController =
        new AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animationTranslate =
        Tween<double>(begin: 0, end: waveLength).animate(_animationController)
          ..addListener(() {
            setState(() {});
          });
    _animationController.repeat();
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    _animationController.stop();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: BezierPainter2(
          progress: this.widget.progress,
          waveHeight: 15,
          moveX: _animationTranslate.value,
          r: _r,
          waveLength: waveLength),
    );
  }
}

class BezierPainter2 extends CustomPainter {
  final double progress; //进度
  final double waveHeight; //波浪高
  final double moveX; //移动的X,此处变化一个波长
  final double r; //半径
  final double waveLength; //一个波浪的长度
  final waveCount = 2; //波浪个数

  double _progressY; //移动中Y的坐标

  Paint _pointPaint; //点画笔
  Paint _pathPaint; //线画笔
  Paint _whitePaint; //空白画笔

  Path _path = Path(); //路径

  Offset centerOffset; //圆心

  BezierPainter2(
      {this.progress, this.waveHeight, this.moveX, this.r, this.waveLength}) {
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
  }

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    //centerOffset圆心
    _path.addArc(Rect.fromCircle(center: centerOffset, radius: r), 0, 360);
    canvas.clipPath(_path); //把画布裁剪成一个圆形,这样怎么画都是圆。
    canvas.drawCircle(centerOffset, r, _pointPaint); //画圆
    _path.reset(); //重置路径
    //this.progress的范围是0-100。
    _progressY = centerOffset.dy + (r - r / 50 * this.progress); //算出Y点的坐标
    //将画笔移动至屏幕外
    _path.moveTo(-waveLength + moveX, _progressY);
    //这里的波峰波谷稍微多点,所以waveCount*2
    for (int i = 0; i < waveCount * 2; i++) {
      canvas.save();
      canvas.restore();
      //绘制波谷,同上
      _path.quadraticBezierTo(
          -waveLength / 4 * 3 + (waveLength * i) + moveX,
          _progressY + waveHeight,
          -waveLength / 2 + (waveLength * i) + moveX,
          _progressY);
      //绘制波峰,同上
      _path.quadraticBezierTo(-waveLength / 4 + (waveLength * i) + moveX,
          _progressY - waveHeight, 0 + waveLength * i + moveX, _progressY);
    }
    print("_moveX=${moveX.toString()}");
    //封闭圆
    _path.moveTo(centerOffset.dx + r, _progressY);
    _path.lineTo(centerOffset.dx + r, centerOffset.dy + r);
    _path.lineTo(centerOffset.dx - r, centerOffset.dy + r);
    _path.lineTo(centerOffset.dx - r, _progressY);
    _path.close();
    canvas.drawPath(_path, _pathPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
