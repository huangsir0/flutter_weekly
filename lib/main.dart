import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_weekly/home/widget_pageview_page.dart';

import 'package:redux/redux.dart';

import 'common/global_stage.dart';
import 'common/styles/color_style.dart';
import 'common/utils/common_util.dart';
import 'common/utils/screen.dart';
import 'example1/scroll_app.dart';

void main() {
  runApp(new FlutterReduxApp());
  //runApp(new ScrollApp());
}

class FlutterReduxApp extends StatelessWidget {
  //创建Store，引用Global 中的appReducer 创建Reducer
  //initialStage 初始化Stage
  final store = new Store<GlobalStage>(appReducer,
      initialState: new GlobalStage(
          themeData: CommonUtils.getThemeData(GlobalColors.primarySwatch)));

  FlutterReduxApp({Key key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    Screen.init();
    //通过 StoreProovider 应用store
    return new StoreProvider(
        store: store,
        child: new StoreBuilder<GlobalStage>(builder: (context, store) {
          return new MaterialApp(
              theme: store.state.themeData,
              home: new HomePageView()//new HomePage(),
          );
        }));
  }
}

//x