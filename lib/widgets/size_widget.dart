import 'package:flutter/material.dart';
import 'package:flutter_weekly/home/widget_pageview_page.dart';


class SizeWidget extends StatefulWidget {
  Key key;
  Widget child;

  SizeWidget({Key key, @required this.child})
      : assert(child != null),
        super(key: key);

  @override
  _SizeWidgetState createState() => _SizeWidgetState();
}

class _SizeWidgetState extends State<SizeWidget>
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


  @override
  Widget build(BuildContext context) {
    bool isShow=BottomInheritedContext.of(context).isShow;
    if(isShow){
      _animationController.reset();
      _animationController.forward();
    }else{
      _animationController.reverse();
    }
    return SizeTransition(
      sizeFactor: animation,
      child: this.widget.child,
    );
  }
}
