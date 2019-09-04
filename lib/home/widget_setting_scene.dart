import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_weekly/common/global_stage.dart';
import 'package:flutter_weekly/common/reduxs/theme_redux.dart';
import 'package:flutter_weekly/common/utils/common_util.dart';
import 'package:flutter_weekly/common/utils/screen.dart';
import 'package:flutter_weekly/widgets/flutter_bezier_widgets/widget_bezier_theme.dart';
import 'package:flutter_weekly/widgets/flutter_bezier_widgets/widget_mutiple_circle.dart';


class WidgetSettingPage extends StatefulWidget {
  @override
  _WidgetSettingPageState createState() => _WidgetSettingPageState();
}

class _WidgetSettingPageState extends State<WidgetSettingPage> {

   int _themeIndex=2;

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Settings"),
        centerTitle: true,
      ),
      body:  new StoreBuilder<GlobalStage>(
        builder: (context, store) {
          return  Column(
            children: <Widget>[
               new Container(
                  margin: EdgeInsets.only(top: (Screen.screenHeightDp-Screen.navigationBarHeight*2)/2-120),
                  child: MutilpeCirclesButton(bigRadius: 80,color: CommonUtils.getThemeListColor()[_themeIndex],label:"主题更新",colorThemeChange:(_color){
                    ThemeData themeData=store.state.themeData.copyWith(primaryColor: _color) ;
                    store.dispatch(new RefreshColorGradientAction(CommonUtils.getColorGradients()[_themeIndex]));
                    store.dispatch(new RefreshThemeDataAction(themeData));
                  },
                  ),
                ),
                SizedBox(height:80,width:Screen.screenWidthDp),
              CircleColorsWidget(themeChangeAction: (index){
                setState(() {
                  _themeIndex=index;
                });
              }
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

