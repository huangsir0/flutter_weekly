import 'package:flutter/material.dart';
import 'package:flutter_weekly/consts/config.dart';
import 'package:flutter_weekly/mvp/constract/maincontract.dart';
import 'package:flutter_weekly/common/utils/screen.dart';

import '../main_presenter.dart';
import 'common_scene.dart';

class GanksScene extends StatefulWidget {
  @override
  _GanksSceneState createState() => _GanksSceneState();
}


class _GanksSceneState extends State<GanksScene>
    with TickerProviderStateMixin
    implements IMainView {

  List<String> tabs = new List();

  TabController _tabController;
  MainPresenter mainPresenter;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mainPresenter = new MainPresenter()
      ..init(this);
    _init();
  }


  void _init() {
    mainPresenter.initTitles(Config.today);
  }


  @override
  Widget build(BuildContext context) {
    return tabs.length == 0 ? Container(

    ) : new Center(
      child: new DefaultTabController(
        //选项卡数量
        length: tabs.length,
        child: new NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              new SliverOverlapAbsorber(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                child: new SliverAppBar(
                  //appbar标题
                  title: const Text('Ganks'),
                  //列表在滚动的时候appbar是否一直保持可见
                  pinned: true,
                  floating: false,

                  //强制appbar下面有阴影
                  forceElevated: true,

                  //显示在appbar下方,通常是TabBar,且小部件必须实现[PreferredSizeWidget]
                  //才能在bottom中使用!!!!
                  bottom: new TabBar(
                    isScrollable:true,
                    //Tab选项卡小部件
                    tabs: tabs.map((String name) => new Tab(text: name)).toList(),
                  ),
                ),
              ),
            ];
          },

          body: new TabBarView(
            ///下面是选项卡视图的内容列表,自己任意发挥即可
            children: tabs.map((String name) {
              return new SafeArea(
                top: false,
                bottom: false,
                child: new Builder(
                  ///这个Builder需要提供一个BuildContext，
                  ///它“在”NestedScrollView中，
                  ///以便SliverOverlapAbsorberHandleFor()可以找到NestedScrollView。
                  builder: (BuildContext context) {
                    return new CommonScene(Config.commonData+name);
                  },
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );

  }


  @override
  void onLoadFail() {
    // TODO: implement onLoadFail
  }

  @override
  void onLoadSuc(List<String> titles) {
    // TODO: implement onLoadSuc
    setState(() {
      tabs.clear();
      tabs.addAll(titles);
      _tabController = new TabController(length: tabs.length, vsync: this);
      print(titles);
    });
  }

  @override
  void showLoading() {
    // TODO: implement showLoading
  }
}
