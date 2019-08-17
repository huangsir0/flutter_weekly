import 'package:flutter/material.dart';

import '../flutter_bezier_widgets/widget_bezier_theme.dart';
import '../flutter_bezier_widgets/widget_mutiple_circle.dart';

class WidgetCircleDetailPage extends StatefulWidget {
  @override
  _WidgetCircleDetailPageState createState() => _WidgetCircleDetailPageState();
}

class _WidgetCircleDetailPageState extends State<WidgetCircleDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Circles"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 50),
                child: MutilpeCirclesButton(
                    color: Theme.of(context).primaryColor,
                    bigRadius: 80,
                    label: "Test"),
              ),
              Container(
                margin: const EdgeInsets.only(top: 80),
                child: CircleColorsWidget(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
