import 'package:flutter/material.dart';

class AlphaWidget extends StatefulWidget {

  final String dayTime;

  final String createTime;

  const AlphaWidget({Key key, this.dayTime, this.createTime}) : super(key: key);

  @override
  AlphaWidgetState createState() => AlphaWidgetState();
}

class AlphaWidgetState extends State<AlphaWidget> with SingleTickerProviderStateMixin {

  AnimationController _animationController;
  Animation<double> _alphaAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController=new AnimationController(vsync: this,duration: Duration(milliseconds: 800))..addListener((){
      setState(() {});
    });
    _alphaAnimation=new Tween<double>(begin:0,end:1).animate(_animationController);
    _animationController.forward();
  }
  void show(){
    _animationController?.reset();
    _animationController?.forward();
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    _animationController?.stop();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(opacity: _alphaAnimation.value,child:  Column(
      children: <Widget>[
        Text(
          widget.dayTime,
          style: TextStyle(color: Colors.white),
        ),
        Text(
          widget.createTime,
          style: TextStyle(
              color: Colors.white,
              fontSize: 14),
        )
      ],
    ),);
  }
}
