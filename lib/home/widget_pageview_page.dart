import 'package:flutter/material.dart';
import 'package:flutter_weekly/mvp/scenes/ganks_scene.dart';
import 'package:flutter_weekly/home/widget_b_page.dart';
import 'package:flutter_weekly/home/widget_c_page.dart';
import 'package:flutter_weekly/home/widget_d_page.dart';
import 'package:flutter_weekly/widgets/size_widget.dart';
import 'package:flutter_weekly/widgets/study_custompainter_widget.dart';


class HomePageViewWidget extends StatefulWidget {
  @override
  _HomePageViewWidgetState createState() => _HomePageViewWidgetState();
}

class _HomePageViewWidgetState extends State<HomePageViewWidget> {
  var _curIndex = 0;

  var _body;

  var _pageController = new PageController(initialPage: 0);

  final GlobalKey<SizeWidgetState> _sizeWidgetKey=new GlobalKey();

  List<String> Tabs = ["Gank", "Example", "Study", "Android"];

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

    bottomWidget=new SizeWidget(
      key: _sizeWidgetKey,
        child: new BottomNavigationBar(
          items: [
            _buildBottomItem(Icons.home, Tabs[0]),
            _buildBottomItem(Icons.phone_iphone, Tabs[1]),
            _buildBottomItem(Icons.ac_unit, Tabs[2]),
            _buildBottomItem(Icons.phone_android, Tabs[3]),
          ],
          currentIndex: _curIndex,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            _pageController.animateToPage(index,
                duration: const Duration(milliseconds: 300), curve: Curves.ease);
          },
        ));

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
    return new Scaffold(
      body: _body,
      bottomNavigationBar: bottomWidget,
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
        return new GanksScene(onScroll);
      case 1:
        return new TestBPageView();
      case 2:
        return new TimeClockWidget();
      case 3:
        return new PaintWidget();
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
