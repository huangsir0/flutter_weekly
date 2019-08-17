import 'package:flutter/material.dart';

import '../../consts/config.dart';

class WidgetSceneDetailPage extends StatefulWidget {
  @override
  _WidgetSceneDetailPageState createState() => _WidgetSceneDetailPageState();
}

class _WidgetSceneDetailPageState extends State<WidgetSceneDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter * Widgets"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(PageRoutes.widgetTextPage);
              },
              child: Text(PageRoutes.widgetTextPage),
            ),

            RaisedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(PageRoutes.widgetContainerPage);
              },
              child: Text(PageRoutes.widgetContainerPage),
            ),

            RaisedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(PageRoutes.widgetPainterTimeClockPage);
              },
              child: Text(PageRoutes.widgetPainterTimeClockPage),
            ),

            RaisedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(PageRoutes.widgetBezierGesturePage);
              },
              child: Text(PageRoutes.widgetBezierGesturePage),
            ),

            RaisedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(PageRoutes.widgetCircleProgressPage);
              },
              child: Text(PageRoutes.widgetCircleProgressPage),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(PageRoutes.widgetBezierThemePage);
              },
              child: Text(PageRoutes.widgetBezierThemePage),
            ),
          ],
        ),
      ),
    );
  }
}
