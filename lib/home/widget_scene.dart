import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_weekly/common/global_stage.dart';

class WidgetsWidget extends StatefulWidget {
  @override
  _WidgetPageWidgetState createState() => _WidgetPageWidgetState();
}

class _WidgetPageWidgetState extends State<WidgetsWidget> {
  @override
  Widget build(BuildContext context) {
    return StoreBuilder<GlobalStage>(
      builder: (context, store) {
        return new Scaffold(
          appBar: new AppBar(
            title: new Text("Widgets"),
            centerTitle: true,
          ),
          body: new Center(
            child: Container(
              height: 300,
              width: 300,
              decoration:
                  BoxDecoration(gradient: store.state.colorGradient.gradient),
              child: Text("Widgets"),
            ),
          ),
        );
      },
    );
  }
}

class WidgetsScene extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WidgetsWidget();
  }
}
