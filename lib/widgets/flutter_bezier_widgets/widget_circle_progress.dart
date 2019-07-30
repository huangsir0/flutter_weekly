import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_weekly/widgets/flutter_bezier_widgets/widget_study_bezierpainter.dart';

class WidgetCircleProgressWidget extends StatefulWidget {
  @override
  _WidgetCircleProgressWidgetState createState() =>
      _WidgetCircleProgressWidgetState();
}

class _WidgetCircleProgressWidgetState
    extends State<WidgetCircleProgressWidget> {
  Timer timer;

  double progress = 0;

  bool flag = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timer = Timer.periodic(Duration(milliseconds: 500), (timer) {
      setState(() {
        if (flag) {
          progress = progress - 1;
        } else {
          progress = progress + 1;
        }

        if (progress == 0) {
          flag = false;
        }

        if (progress == 100) flag = true;
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
    return CustomBezierWidget2(progress);
  }
}
