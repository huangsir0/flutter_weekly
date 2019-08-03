import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_weekly/common/global_stage.dart';
import 'package:flutter_weekly/mvp/beans/item_widget_bean.dart';

class WidgetExampleWidget extends StatefulWidget {
  @override
  _WidgetExampleState createState() => _WidgetExampleState();
}

class _WidgetExampleState extends State<WidgetExampleWidget> {





  @override
  Widget build(BuildContext context) {
    return StoreBuilder<GlobalStage>(
      builder: (context, store) {
        return new Scaffold(
          appBar: new AppBar(
            title: new Text("Examples"),
            centerTitle: true,
          ),
          body: new Center(
            child: Container(
              height: 300,
              width: 300,
              decoration:
                  BoxDecoration(gradient: store.state.colorGradient.gradient),
              child: Text("Examples"),
            ),
          ),
        );
      },
    );
  }
}

class WidgetExampleScene extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WidgetExampleWidget();
  }
}
