import 'package:flutter/material.dart';
import 'package:flutter_weekly/common/utils/common_util.dart';
import 'dart:math' as math;

import 'package:flutter_weekly/common/utils/screen.dart';

class CircleColorsWidget extends StatefulWidget {
  @override
  _CircleColorsWidgetState createState() => _CircleColorsWidgetState();
}

class _CircleColorsWidgetState extends State<CircleColorsWidget> with SingleTickerProviderStateMixin {
  List<Color> _colors = CommonUtils.getThemeListColor();
  List<int> _indexAry = [0, 1, 2, 3, 4];
  List<double> _radiusAry = [5, 20, 40, 20, 5];//球半径

  AnimationController _animationController;
  Animation<double> _animation;

  double _targetOffsetX=100;//水平偏移量,要滑过10个单位才算切换小球成功。

  double _percent=0.0;//偏移量百分比

  double _preOffsetX=0.0;//
  double _endOffsetX=0.0;//

  bool _isSlideRight=true;

  double _singleWidth;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _singleWidth=Screen.screenWidthDp/_indexAry.length;
    _animationController=new AnimationController(vsync: this,duration: Duration(milliseconds: 200));
    print("initState");
  }

  ///循环下标
  void cricleMoveIndex(int moveX) {
    if (moveX.isNegative) {
      //往左滑动
      List<int> start = _indexAry.sublist(0, moveX.abs());
      List<int> end = _indexAry.sublist(moveX.abs());
      _indexAry.clear();
      List<int> tempList = new List()..addAll(end)..addAll(start);
      _indexAry.addAll(tempList);
    } else {
      //往右滑动
      List<int> start =
          _indexAry.sublist(0, _indexAry.length - moveX).reversed.toList();
      List<int> end =
          _indexAry.sublist(_indexAry.length - moveX).reversed.toList();
      _indexAry.clear();
      List<int> tempList = new List()..addAll(start)..addAll(end);
      _indexAry.addAll(tempList.reversed.toList());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lights'),
      ),
      body: Container(
        height: 100,
        width: Screen.screenWidthDp,
        margin: EdgeInsets.only(top: 500),
        color: Colors.grey,
        child: Stack(
          children: <Widget>[
            GestureDetector(
              onHorizontalDragUpdate: (DragUpdateDetails details) {
                _endOffsetX=details.globalPosition.dx;
                _percent=((_endOffsetX-_preOffsetX).abs()/_targetOffsetX)>=1?1:(_endOffsetX-_preOffsetX).abs()/_targetOffsetX;
                if((_endOffsetX-_preOffsetX).isNegative){
                  //往左滑
                  _isSlideRight=false;
                }else{
                  //往右滑
                   _isSlideRight=true;
                }
                if(_percent>0.8){
                  setState(() {
                    _preOffsetX=details.globalPosition.dx;
                    cricleMoveIndex(_isSlideRight?1:-1);
                  });
                }else{
                  setState(() {

                  });
                }
              },
              onHorizontalDragStart: (DragStartDetails details){
                _preOffsetX=details.globalPosition.dx;
              },
              onHorizontalDragEnd: (DragEndDetails details){
                _animation=new Tween<double>(begin: _percent,end: 0.0).animate(_animationController)..addListener(
                    (){
                      setState(() {
                        _percent=_animation.value;
                      });
                    }
                );
                _animationController.reset();
                _animationController.forward();
              },
            ),
            getPositioned(0,_isSlideRight,_percent),
            getPositioned(1,_isSlideRight,_percent),
            getPositioned(2,_isSlideRight,_percent),
            getPositioned(3,_isSlideRight,_percent),
            getPositioned(4,_isSlideRight,_percent),
          ],
        ),
      ),
    );
  }

  Widget getPositioned(int index,bool isToRight,double percent) {

    return  Positioned(
      child: Container(
        height: 100,
        width: _singleWidth,
       child: CircleBallView(_colors[_indexAry[index]], _radiusAry[index],isToRight,percent),
      ),
      left: index * _singleWidth-(index==1?20:0),
    );
  }
}



class CircleBallView extends StatefulWidget {
  final Color _color;
  final double _radius;
  final bool _isToRight;
  final double percent;
  CircleBallView(this._color, this._radius,this._isToRight, this.percent);

  @override
  _CircleBallViewState createState() => _CircleBallViewState();
}

class _CircleBallViewState extends State<CircleBallView> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: CustomPaint(
      painter: CircleBallPainter(this.widget._color, this.widget._radius,this.widget._isToRight, this.widget.percent),
    ));
  }
}

class CircleBallPainter extends CustomPainter {
  final Color _color;
  final double _radius;
  final double M = 0.551915024494;
  final bool _isToRight;
  final double percent;

  final double baseLineHeight = 0;//因为外层套了一个Center控件,所以此处为0

  Paint _circlePaint;

  Path _linePath = Path();

  Point offsetR; //圆最右侧的点
  Point offsetB; //圆最底下的点
  Point offsetL; //圆最左侧的点
  Point offsetT; //圆最上面的点

  double offsetRRadius;

  double offsetB4LeftRadius;
  double offsetB4RightRadius;
  double offsetLRadius;

  CircleBallPainter(this._color, this._radius,this._isToRight, this.percent) {
    _circlePaint = Paint()
      ..style = PaintingStyle.fill
      ..isAntiAlias = true
      ..color = this._color;
    //初始化圆上代表性的四个点,通过控制这些点去控制贝塞尔曲线
    offsetR = Point(dx:_radius, dy:baseLineHeight);//1
    offsetB = Point(dx:0, dy:_radius + baseLineHeight); //2
    offsetL = Point(dx:-_radius,dy: baseLineHeight);//3
    offsetT = Point(dx:0, dy:baseLineHeight - _radius);//4
  }

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint

    if (_isToRight) {
      offsetL.dx=offsetL.dx-percent*_radius;
    } else {
      offsetR.dx=offsetR.dx+percent*_radius;
    }
    offsetRRadius = offsetB.dy - offsetR.dy;
    offsetB4LeftRadius = offsetB.dx - offsetL.dx;
    offsetB4RightRadius = offsetR.dx - offsetB.dx;
    offsetLRadius = offsetB.dy - offsetL.dy;
    _linePath.moveTo(offsetR.dx, offsetR.dy);
    _linePath.cubicTo(offsetR.dx, offsetR.dy + offsetRRadius * M,
        offsetB.dx + offsetB4RightRadius * M, offsetB.dy, offsetB.dx, offsetB.dy);
    _linePath.cubicTo(offsetB.dx - offsetB4LeftRadius * M, offsetB.dy, offsetL.dx,
        offsetL.dy + offsetLRadius * M, offsetL.dx, offsetL.dy);
    _linePath.cubicTo(offsetL.dx, offsetL.dy - offsetLRadius * M,
        offsetT.dx - offsetB4LeftRadius * M, offsetT.dy, offsetT.dx, offsetT.dy);
    _linePath.cubicTo(offsetT.dx + offsetB4RightRadius * M, offsetT.dy, offsetR.dx,
        offsetR.dy - offsetRRadius * M, offsetR.dx, offsetR.dy);
    canvas.drawPath(_linePath, _circlePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }

}

//////辅助类,因为Offset类不支持属性修改
class Point {
  double dx;
  double dy;
  Point({this.dx,this.dy});
}
