import 'package:flutter/material.dart';

class SizeWidget extends StatefulWidget {
 final Widget child;

 const SizeWidget({Key key, @required this.child})
      : assert(child != null),
        super(key: key);

  @override
  SizeWidgetState createState() => SizeWidgetState();
}

class SizeWidgetState extends State<SizeWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  Animation<double> animation;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController =
        new AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    animation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeOut);

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


  void show(){
    _animationController.reset();
    _animationController.forward();
  }



  void hide(){
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: animation,
      child: this.widget.child,
    );
  }
}
