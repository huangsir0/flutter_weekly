import 'package:flutter/material.dart';
import 'package:flutter_weekly/common/utils/screen.dart';
import 'dart:math' as math;
class BezierGestureWidget extends StatefulWidget {
  @override
  _BezierGestureWidgetState createState() => _BezierGestureWidgetState();
}

class _BezierGestureWidgetState extends State<BezierGestureWidget> {
  int _bezierType = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('贝塞尔曲线演示视图'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              RaisedButton(
                child: Text("一阶贝塞尔"),
                onPressed: () {
                  setState(() {
                    _bezierType = 1;
                  });
                },
              ),
              RaisedButton(
                child: Text("二阶贝塞尔"),
                onPressed: () {
                  setState(() {
                    _bezierType = 2;
                  });
                },
              ),
              RaisedButton(
                child: Text("三阶贝塞尔"),
                onPressed: () {
                  setState(() {
                    _bezierType = 3;
                  });
                },
              ),
            ],
          ),
          Expanded(
            child: Container(
              child: GestureWidget(_bezierType),
            ),
            flex: 1,
          )
        ],
      ),
    );
  }
}

///演示控件
class GestureWidget extends StatefulWidget {
  final int _type;

  GestureWidget(this._type);

  @override
  _GestureWidgetState createState() => _GestureWidgetState();
}

class _GestureWidgetState extends State<GestureWidget> {
  Offset moveOffset=Offset(0, 0);
  ///贝塞尔曲线控制点,这里只演示三阶曲线
  Offset _ctrlOffset0;//控制点1
  Offset _ctrlOffset1;

  _GestureWidgetState(){
    if(_ctrlOffset0==null){
      print("_ctrlOffset0==null");
      _ctrlOffset0= Offset(90, Screen.screenHeightDp/3-60);
    }
    if(_ctrlOffset1==null){
      print("_ctrlOffset1==null");
      _ctrlOffset1=Offset(Screen.screenWidthDp-90, Screen.screenHeightDp/3-60);
    }
  } //控制点2



  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        GestureDetector(
          onPanUpdate: (DragUpdateDetails details) {
            setState(() {
              moveOffset =
              new Offset(details.globalPosition.dx, details.globalPosition.dy);
              ///这里可以看做是初始化的两个控制点
              //计算控制点距离控制点1,2的距离，以此判断手势想要移动哪个控制点
              double ctrl0Length=math.sqrt((math.pow((moveOffset.dx-_ctrlOffset0.dx).abs(), 2)+(math.pow((moveOffset.dy-_ctrlOffset0.dy).abs(), 2))));//勾股定理
              double ctrl1Length=math.sqrt((math.pow((moveOffset.dx-_ctrlOffset1.dx).abs(), 2)+(math.pow((moveOffset.dy-_ctrlOffset1.dy).abs(), 2))));//勾股定理
              if(ctrl0Length>ctrl1Length){
                ///控制的是 _ctrlOffset1 这个点
                _ctrlOffset1=moveOffset;
              }else{
                _ctrlOffset0=moveOffset;
              }

            });

          },
          onTapDown: (TapDownDetails details){
            setState(() {
              moveOffset =
              new Offset(details.globalPosition.dx, details.globalPosition.dy);

              //计算控制点距离控制点1,2的距离，以此判断手势想要移动哪个控制点
              double ctrl0Length=math.sqrt((math.pow((moveOffset.dx-_ctrlOffset0.dx).abs(), 2)+(math.pow((moveOffset.dy-_ctrlOffset0.dy).abs(), 2))));//勾股定理
              double ctrl1Length=math.sqrt((math.pow((moveOffset.dx-_ctrlOffset1.dx).abs(), 2)+(math.pow((moveOffset.dy-_ctrlOffset1.dy).abs(), 2))));//勾股定理
              if(ctrl0Length>ctrl1Length){
                ///控制的是 _ctrlOffset1 这个点
                _ctrlOffset1=moveOffset;
              }else{
                _ctrlOffset0=moveOffset;
              }
            });
          },
        ),
        BezierWidget(this.widget._type, moveOffset,_ctrlOffset0,_ctrlOffset1),
      ],
    );
  }
}

class BezierWidget extends StatefulWidget {
  final int _type;
  final Offset _moveOffset;

  final Offset _ctrlOffset0;//控制点1
  final Offset _ctrlOffset1;//控制点2

  BezierWidget(this._type, this._moveOffset, this._ctrlOffset0,
      this._ctrlOffset1);

  @override
  _BezierWidgetState createState() => _BezierWidgetState();
}

class _BezierWidgetState extends State<BezierWidget> {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: BezierExamplePainter(this.widget._type, this.widget._moveOffset,this.widget._ctrlOffset0,this.widget._ctrlOffset1),
    );
  }
}

class BezierExamplePainter extends CustomPainter {
  final int _type;
  final Offset _moveOffset;

  final Offset _ctrlOffset0;//控制点1
  final Offset _ctrlOffset1;//控制点2



  BezierExamplePainter(this._type, this._moveOffset, this._ctrlOffset0,
      this._ctrlOffset1);

  double _r=5;//点半径
  ///起始点和终止点设置不变
  Offset _startOffset;//起始点
  Offset _endOffset;//结束点



  ///设置画笔
  Paint _pathPaint=Paint()..isAntiAlias=true..strokeWidth=4..color=Colors.deepOrange..style=PaintingStyle.stroke;
  Paint _pointPaint=Paint()..isAntiAlias=true..strokeWidth=4..style=PaintingStyle.fill..color=Colors.green;
  Paint _ctrPaint=Paint()..isAntiAlias=true..strokeWidth=4..style=PaintingStyle.fill..color=Colors.blue;
  //路径
  Path _linePath=Path();

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    _startOffset=Offset(size.width+60, Screen.screenHeightDp/3);
    _endOffset=Offset(Screen.screenWidthDp-60, Screen.screenHeightDp/3);
    print("_startOffset： ${_startOffset.toString()}");
    canvas.drawCircle(_startOffset, _r, _pointPaint);
    canvas.save();
    canvas.restore();
    _linePath.reset();
    switch(_type){
      case 1:{
        canvas.drawLine(_startOffset, this._moveOffset, _pathPaint);
        canvas.drawCircle(_moveOffset, _r, _pointPaint);
        break;
      }
      case 2:{
        _linePath.moveTo(_startOffset.dx, _startOffset.dy);
        _linePath.quadraticBezierTo(this._moveOffset.dx, this._moveOffset.dy, _endOffset.dx, _endOffset.dy);
        canvas.drawCircle(_moveOffset, _r, _ctrPaint);
        canvas.drawCircle(_endOffset, _r, _pointPaint);
        canvas.drawPath(_linePath, _pathPaint);
        break;
      }
      case 3:
        {
           _linePath.moveTo(_startOffset.dx, _startOffset.dy);
          _linePath.cubicTo(_ctrlOffset0.dx, _ctrlOffset0.dy, _ctrlOffset1.dx, _ctrlOffset1.dy, _endOffset.dx, _endOffset.dy);
          canvas.drawCircle(_endOffset, _r, _pointPaint);
          canvas.drawCircle(_ctrlOffset0, _r, _ctrPaint);
          canvas.drawCircle(_ctrlOffset1, _r, _ctrPaint);
          canvas.drawPath(_linePath, _pathPaint);
          break;
        }

      default:
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
