import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_weekly/common/global_stage.dart';
import 'package:flutter_weekly/common/reduxs/theme_redux.dart';
import 'package:flutter_weekly/common/utils/common_util.dart';
import 'package:flutter_weekly/home/widget_test_a.dart';

class WidgetSettingPage extends StatefulWidget {
  @override
  _WidgetSettingPageState createState() => _WidgetSettingPageState();
}

class _WidgetSettingPageState extends State<WidgetSettingPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Settings"),
        centerTitle: true,
      ),
      body:  new StoreBuilder<GlobalStage>(
        builder: (context, store) {
          return new ListView(
            children: <Widget>[
              new Padding(
                padding:
                const EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0),
                child: new RaisedButton(
                  onPressed: () {
                    ThemeData themeData;
                    List<Color> colors = CommonUtils.getThemeListColor();
                    themeData =store.state.themeData.copyWith(primaryColor: colors[new Random().nextInt(colors.length)]) ;
                    store.dispatch(new RefreshThemeDataAction(themeData));
                  },
                  child: new Text("随机切换颜色"),
                ),
              ),
              new Padding(
                padding:
                const EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0),
                child: new RaisedButton(
                  onPressed: () {
                    Navigator.of(context).push(new MaterialPageRoute(builder: (context){
                      return new TestAWidget();
                    }));
                  },
                  child: new Text("跳转到TestA"),
                ),
              ),

            ],
          );
        },
      ),
    );
  }
}


class WidgetSettingScene extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WidgetSettingPage();
  }
}

