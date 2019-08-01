import 'package:flutter/material.dart';
import 'package:flutter_weekly/home/widget_example_scene.dart';
import 'package:flutter_weekly/home/widget_scene.dart';
import 'package:flutter_weekly/mvp/scenes/ganks_scene.dart';
import 'package:flutter_weekly/home/widget_setting_scene.dart';
import 'package:flutter_weekly/widgets/flutter_bezier_widgets/widget_bezier_gesture.dart';
import 'package:flutter_weekly/widgets/flutter_bezier_widgets/widget_bezier_theme.dart';
import 'package:flutter_weekly/widgets/flutter_bezier_widgets/widget_circle_progress.dart';
import 'package:flutter_weekly/widgets/flutter_widgets/widget_container.dart';
import 'package:flutter_weekly/widgets/size_widget.dart';
import 'package:flutter_weekly/widgets/flutter_bezier_widgets/widget_study_bezierpainter.dart';
import 'package:flutter_weekly/widgets/flutter_timeclock_widget/widget_study_custompainter.dart';


class HomePageViewWidget extends StatefulWidget {
  @override
  _HomePageViewWidgetState createState() => _HomePageViewWidgetState();
}

class _HomePageViewWidgetState extends State<HomePageViewWidget> {
  var _curIndex = 0;

  var _body;


  var _pageController = new PageController(initialPage: 0);

  final GlobalKey<SizeWidgetState> _sizeWidgetKey=new GlobalKey();

  List<String> Tabs = ["Gank", "Widgets", "Example", "Settings"];

  //主要用于控制BottomNavigationBar显示隐藏
  SizeWidget bottomWidget;
  //是否显示底部
  bool isShowBottom = true;

  _initPageViews() {
    _body = new PageView.builder(
      itemBuilder: (BuildContext context, int index) {
        return _buildPageItem(context, index);
      },
      itemCount: Tabs.length,
      controller: _pageController,
      onPageChanged: (index) {
        _onChangePageView(index);
      },
    );


  }

  void onScroll(bool isUp) {
    if(!isUp==isShowBottom)return;
    //通过BottomInheritedContext显示隐藏
    isShowBottom=!isUp;
    if(isShowBottom){
      this._sizeWidgetKey.currentState.show();
    }else{
      this._sizeWidgetKey.currentState.hide();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initPageViews();
  }

  @override
  Widget build(BuildContext context) {
    bottomWidget=new SizeWidget(
        key: this._sizeWidgetKey,
        child: new BottomNavigationBar(
          items: [
            _buildBottomItem(Icons.home, Tabs[0]),
            _buildBottomItem(Icons.widgets, Tabs[1]),
            _buildBottomItem(Icons.ac_unit, Tabs[2]),
            _buildBottomItem(Icons.settings, Tabs[3]),
          ],
          currentIndex: _curIndex,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            _pageController.animateToPage(index,
                duration: const Duration(milliseconds: 300), curve: Curves.ease);
          },
        ));

    return new Scaffold(
      body: _body,
      bottomNavigationBar:  bottomWidget,
    );
  }



  void _onChangePageView(int index) {
    setState(() {
      if (_curIndex != index) {
        _curIndex = index;
      }
    });
  }

  Widget _buildPageItem(BuildContext context, int index) {
    switch (index) {
      case 0:
        return new CircleColorsWidget(); //new GanksScene(onScroll);
      case 1:
        return new CustomBezierWidget1();
      case 2:
        return new WidgetExampleScene();
      case 3:
        return new WidgetSettingScene();
    }
  }

  BottomNavigationBarItem _buildBottomItem(IconData iconData, String tab) {
    return new BottomNavigationBarItem(
        icon: new Icon(iconData), title: new Text(tab));
  }
}

class HomePageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return HomePageViewWidget();
  }
}
