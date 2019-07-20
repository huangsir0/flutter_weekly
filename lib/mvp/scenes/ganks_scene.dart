import 'package:flutter/material.dart';
import 'package:flutter_weekly/common/utils/common_util.dart';
import 'package:flutter_weekly/consts/config.dart';
import 'package:flutter_weekly/mvp/constract/maincontract.dart';
import 'package:flutter_weekly/widgets/loading_widget.dart';
import '../main_presenter.dart';
import 'common_scene.dart';

class GanksScene extends StatefulWidget {
  ValueChanged<bool> onValueChange;

  GanksScene(this.onValueChange);

  @override
  _GanksSceneState createState() => _GanksSceneState();
}

class _GanksSceneState extends State<GanksScene>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin
    implements IMainView {
  List<String> tabs = new List();

  MainPresenter mainPresenter;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mainPresenter = new MainPresenter()..init(this);

    _init();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void _init() {
    mainPresenter.initTitles(Config.today);
  }

  @override
  Widget build(BuildContext context) {
    return tabs.length == 0
        ? WaitingWidget()
        : DefaultTabController(
            length: tabs.length,
            child: new Scaffold(
              body: new NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    new SliverAppBar(
                      //appbar标题
                      title: Text(
                        'Ganks',
                      ),
                      //列表在滚动的时候appbar是否一直保持可见
                      pinned: true,
                      flexibleSpace: FlexibleSpaceBar(
                          centerTitle: true,
                          background: Container(
                            width: double.infinity,
                          )),
                      forceElevated: innerBoxIsScrolled,
                      floating: true,
                      //与floating结合使用
                      snap: true,
                      //显示在appbar下方,通常是TabBar,且小部件必须实现[PreferredSizeWidget]
                      //才能在bottom中使用!!!!
                      bottom: new TabBar(
                        isScrollable: true,
                        //Tab选项卡小部件
                        tabs: tabs
                            .map((String name) => new Tab(text: name))
                            .toList(),
                      ),
                      //材料设计中控件的 z 坐标顺序，默认值为 4，对于可滚动的 SliverAppBar，
                      // 当 SliverAppBar 和内容同级的时候，该值为 0， 当内容滚动 SliverAppBar 变为 Toolbar 的时候，修改 elevation 的值
                      elevation: 1,
                      //展开高度
                      expandedHeight: 100,
                    ),
                  ];
                },
                body: new TabBarView(
                  children: tabs.map((String name) {
                    return new CommonScene(
                        Config.commonData + name, this.widget.onValueChange);
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
      titles.sort((String before, String behind) {
        return behind.startsWith('福利') ? 1 : -1; //把福利排最前面
      });
      tabs.addAll(titles);
      print(titles);
    });
  }

  @override
  void showLoading() {
    // TODO: implement showLoading
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
