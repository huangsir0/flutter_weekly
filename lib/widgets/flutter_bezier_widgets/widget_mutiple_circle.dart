import 'package:flutter/material.dart';
import 'dart:math' as math;

class MutilpeCirclesButton extends StatefulWidget {
  final double bigRadius;
  final Color color;
  final String label;

  final ValueChanged<Color> colorThemeChange;

  const MutilpeCirclesButton({Key key, this.bigRadius, this.color, this.label,this.colorThemeChange})
      : super(key: key);

  @override
  _MutilpeCirclesButtonState createState() => _MutilpeCirclesButtonState();
}

class _MutilpeCirclesButtonState extends State<MutilpeCirclesButton> {


  @override
  Widget build(BuildContext context) {
    return Container(
      height:
      this.widget.bigRadius+20,
      child: Stack(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              if(null!=this.widget.colorThemeChange){
                this.widget.colorThemeChange(this.widget.color);
              }
            },
          ),
          MutilpeWidget(bigRadius: this.widget.bigRadius,color: this.widget.color,label: this.widget.label,),
        ],
      ),
    );
  }
}

class MutilpeWidget extends StatefulWidget  {
  final double bigRadius;
  final Color color;
  final String label;


  const MutilpeWidget({Key key, this.bigRadius, this.color, this.label}) : super(key: key);

  @override
  _MutilpeWidgetState createState() => _MutilpeWidgetState();
}

class _MutilpeWidgetState extends State<MutilpeWidget> with SingleTickerProviderStateMixin {

  double midRadius ;
  double smallRadius;


  AnimationController _animationController;
  Animation<double> _rateAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    midRadius = this.widget.bigRadius - 10;
    smallRadius = this.widget.bigRadius - 20;
    _animationController=new AnimationController(vsync: this,duration: Duration(milliseconds: 4000));
    _rateAnimation=new Tween<double>(begin: 0,end: 15).animate(_animationController)..addListener((){
      setState(() {

      });
    })..addStatusListener((sataus){
      if(sataus==AnimationStatus.completed){
        _animationController.reverse();
      }else if(sataus==AnimationStatus.dismissed){
        _animationController.forward();
      }
    });
    _animationController.forward();
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
    return  Center(
      child: CustomPaint(
        painter: MutipleCircleView(
            this.widget.bigRadius+_rateAnimation.value/2,this.smallRadius+_rateAnimation.value, this.widget.color, this.widget.label,midRadius),
      ),
    );
  }
}

class MutipleCircleView extends CustomPainter {
  final double bigRadius;
  final Color color;
  final String label;

  Paint _bigPaint;

  Paint _smallPaint;

  //能缩放的
  Paint _midPaint;
  TextPainter _labelPaint;

  double smallRadius;

  //能缩放的
  double midRadius;

  Offset centerOffset;

  MutipleCircleView(this.bigRadius, this.smallRadius,this.color, this.label,this.midRadius) {

    _bigPaint = Paint()
      ..color = Colors.grey[200]
      ..isAntiAlias = true
      ..style = PaintingStyle.fill;
    _midPaint = Paint()
      ..color =Color.lerp(color, Colors.white, 0.5)
      ..isAntiAlias = true
      ..style = PaintingStyle.fill;
    _smallPaint = Paint()
      ..color = Color.lerp(color, Colors.white, 0.2)
      ..isAntiAlias = true
      ..style = PaintingStyle.fill;

    _labelPaint= new TextPainter(
        textAlign: TextAlign.left, textDirection: TextDirection.ltr)..text=TextSpan(style: TextStyle(color: Colors.white70,fontSize: 18),text: label);
    centerOffset = Offset(0, 0);
  }

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    canvas.drawCircle(centerOffset, bigRadius, _bigPaint);
    canvas.drawCircle(centerOffset, midRadius, _midPaint);
    canvas.drawCircle(centerOffset, smallRadius, _smallPaint);
    _labelPaint.layout();
    _labelPaint.paint(
        canvas, Offset(-_labelPaint.width / 2, -_labelPaint.height / 2));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
