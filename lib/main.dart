import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_weekly/home/widget_pageview_scene.dart';
import 'package:flutter_weekly/widgets/flutter_widgets/column_row/column_row_widgets.dart';
import 'package:flutter_weekly/widgets/flutter_widgets/stack/stack_page.dart';
import 'package:flutter_weekly/widgets/flutter_widgets/textfield/textfield_widgets.dart';
import 'package:flutter_weekly/widgets/flutter_widgets_details/widget_circle_details.dart';
import 'package:flutter_weekly/widgets/flutter_widgets_details/widget_wave_detail.dart';
import 'package:redux/redux.dart';
import 'common/global_stage.dart';
import 'common/utils/common_util.dart';
import 'common/utils/screen.dart';
import 'dart:math' as math;
import 'consts/config.dart';
import 'examples/example1/scroll_app.dart';
import 'examples/example2/imageapp.dart';
import 'examples/example_internationalize_normal/flutter_internationalize_normal.dart';
import 'examples/materialapp_example/materialapp.dart';
import 'widgets/flutter_bezier_widgets/widget_bezier_gesture.dart';
import 'widgets/flutter_bezier_widgets/widget_bezier_theme.dart';
import 'widgets/flutter_timeclock_widget/widget_timeclock.dart';
import 'widgets/flutter_widgets/widget_container.dart';
import 'widgets/flutter_widgets/widget_text.dart';

void main() {
  //runApp(new FlutterStudyApp());
 // runApp(new ScrollApp());
  //runApp(new MyApp());
//runApp(new MaterialMyApp());
runApp(new AppNationalizeNormal());
}

class FlutterStudyApp extends StatelessWidget {
  //创建Store，引用Global 中的appReducer 创建Reducer
  //initialStage 初始化Stage
  static final index = 2;
  final store = new Store<GlobalStage>(appReducer,
      initialState: new GlobalStage(
          themeData:
              CommonUtils.getThemeData(CommonUtils.getThemeListColor()[index]),
          colorGradient: CommonUtils.getColorGradients()[index]));

  FlutterStudyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Screen.init();
    //通过 StoreProvider 应用store
    return new StoreProvider(
        store: store,
        child: new StoreBuilder<GlobalStage>(builder: (context, store) {
          return new MaterialApp(
            theme: store.state.themeData,
            home: new HomePageView(), //new HomePage(),
            routes: <String, WidgetBuilder>{
              PageRoutes.widgetTextPage:(BuildContext context)=>new WidgetTextPage(),
              PageRoutes.widgetContainerPage:(BuildContext context)=>new WidgetContainerPage(),
              PageRoutes.widgetStackPage:(BuildContext context)=>new StackPage(),
              PageRoutes.widgetColumnAndRowPage:(BuildContext context)=>new RowColunmPage(),
              PageRoutes.widgetTextFieldPage:(BuildContext context)=>new TextFieldWidget(),
              PageRoutes.widgetPainterTimeClockPage:(BuildContext context)=>new TimeClockWidgetPage(),
              PageRoutes.widgetBezierGesturePage:(BuildContext context)=>new BezierGesturePage(),
              PageRoutes.widgetCircleProgressPage:(BuildContext context)=>new WidgetWavePage(),
              PageRoutes.widgetBezierThemePage:(BuildContext context)=>new WidgetCircleDetailPage(),
            },
          );
        }));
  }
}
