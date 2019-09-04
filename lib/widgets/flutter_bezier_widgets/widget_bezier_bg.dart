import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_weekly/common/utils/screen.dart';


class WidgetBezierBg extends StatefulWidget {
  final Widget baseChild;
  final Color color;

  const WidgetBezierBg({Key key, @required this.baseChild, @required this.color}) : super(key: key);

  @override
  _WidgetBezierBgState createState() => _WidgetBezierBgState();
}

class _WidgetBezierBgState extends State<WidgetBezierBg> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          widget.baseChild,
          CustomPaint(
            painter:BgPainter(widget.color, 200) ,
          ),
        ],
      ),
    );
  }
}


class BgPainter extends CustomPainter{

  final Color _color;

  final double _height;


  Paint _paint =Paint()..style=PaintingStyle.fill..isAntiAlias=true..strokeWidth=4;
  
  Offset offsetLeft;
  
  Offset offsetRight;
  
  Offset offsetCtrl;

  //路径
  Path _path=Path();

  BgPainter(this._color ,this._height){
   _paint..color=this._color;
   offsetLeft=Offset(-Screen.screenWidthDp/2-80, 0);
   offsetRight=Offset(Screen.screenWidthDp/2+80, 0);
   offsetCtrl=Offset(0,this._height);
  }

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
   _path.moveTo(offsetLeft.dx, offsetLeft.dy);
   _path.quadraticBezierTo(offsetCtrl.dx, offsetCtrl.dy, offsetRight.dx, offsetRight.dy);
   canvas.drawPath(_path, _paint);

  }

  @override
  bool shouldRepaint(BgPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return oldDelegate._color!=_color;
  }

}





