import 'package:flutter/material.dart';
import 'package:flutter_weekly/mvp/scenes/common_scene.dart';
import 'package:flutter_weekly/mvp/scenes/ganks_scene.dart';
import 'package:flutter_weekly/widgets/widget_b_page.dart';
import 'package:flutter_weekly/widgets/widget_c_page.dart';
import 'package:flutter_weekly/widgets/widget_d_page.dart';
import 'package:flutter_weekly/widgets/widget_home_page.dart';


class HomePageViewWidget extends StatefulWidget {
  @override
  _HomePageViewWidgetState createState() => _HomePageViewWidgetState();
}

class _HomePageViewWidgetState extends State<HomePageViewWidget> {
  var _curIndex = 0;

  var _body;

  var _pageController = new PageController(initialPage: 0);

  String _title="HomePage";

  List<String> Tabs = ["Gank", "Example", "Study", "Android"];



  //当前ListView(Ganks里面的ListView)是否是在底部
  bool isBottom=false;

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


  void onScroll(bool isUp){
    print(isUp ? "上滑" : "下滑");
    setState(() {
      isBottom=isUp;
    });
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
      appBar: null,
      body: _body,
      bottomNavigationBar:isBottom?null: new BottomNavigationBar(items: [
        _buildBottomItem(Icons.home, Tabs[0]),
        _buildBottomItem(Icons.phone_iphone, Tabs[1]),
        _buildBottomItem(Icons.ac_unit, Tabs[2]),
        _buildBottomItem(Icons.phone_android, Tabs[3]),
      ],
        currentIndex:_curIndex ,
        type: BottomNavigationBarType.fixed,
        onTap: (index){
          print("hahahhaha{$index}");
          _pageController.animateToPage(index,duration: const  Duration(milliseconds: 300), curve:Curves.ease);
        },
      ),
    );
  }

  void _onChangePageView(int index) {
    setState(() {
      if (_curIndex != index) {
        _curIndex = index;
        _title=Tabs[index];
      }
    });
  }

  Widget _buildPageItem(BuildContext context, int index) {
    switch (index) {
      case 0:
        return  new GanksScene(onScroll);
      case 1:
        return new TestBPageView();
      case 2:
        return new TestCPageView();
      case 3:
        return new TestDPageView();
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

