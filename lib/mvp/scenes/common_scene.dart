import 'package:flutter/material.dart';
import 'package:flutter_weekly/mvp/beans/common_bean.dart';
import 'package:flutter_weekly/mvp/constract/commoncontract.dart';
import 'package:flutter_weekly/mvp/scenes/webview_scene.dart';
import 'package:flutter_weekly/widgets/beauty_widget.dart';
import 'package:flutter_weekly/widgets/loading_widget.dart';
import '../common_presenter.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'beautydetail_scene.dart';

class CommonScene extends StatefulWidget {
  final String url;

  ValueChanged<bool> onScrollAction;

  CommonScene(this.url, this.onScrollAction);

  @override
  _CommonSceneState createState() => _CommonSceneState();
}

class _CommonSceneState extends State<CommonScene>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin
    implements ICommonView {
  CommonPresenter commonPresenter;

  //数据源
  //第几页
  int pageNum = 1;

  //一次的请求条目
  int itemCount = 15;

  //数据
  List<CommonBean> datas = new List();

  bool isLoadMore = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    commonPresenter = new CommonPresenter()..init(this);
    _onRefresh();
  }

  _onScrollNotification(ScrollNotification scrollInfo) {
   // print("pixels=>" + scrollInfo.metrics.pixels.toString());
   // print("minScrollExtent=>" + scrollInfo.metrics.minScrollExtent.toString());
   // print("maxScrollExtent=>" + scrollInfo.metrics.maxScrollExtent.toString());
   // print("extentBefore=>" + scrollInfo.metrics.extentBefore.toString());
  //  print("extentAfter=>" + scrollInfo.metrics.extentAfter.toString());
    if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
      //滑到了底部
      _onLoadMore();
      if (this.widget.onScrollAction != null) {
        this.widget.onScrollAction(true);
      }
    }

    if (scrollInfo.metrics.extentBefore == 0.0) {
      //滑到头了
      if (this.widget.onScrollAction != null) {
        this.widget.onScrollAction(false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return datas.length == 0
        ? WaitingWidget()
        : Center(
            child: NotificationListener<ScrollNotification>(
              child: new RefreshIndicator(
                  child: MediaQuery.removePadding(
                    context: context,
                    child: _getViewType(this.widget.url),
                  ),
                  onRefresh: _onRefresh),
              onNotification: (ScrollNotification scrollInfo) =>
                  _onScrollNotification(scrollInfo),
            ),
          );
  }

  @override
  void onLoadFail() {
    // TODO: implement onLoadFail
  }

  @override
  Future onLoadSuc(List<CommonBean> domains) {
    // TODO: implement onLoadSuc
    datas.forEach((data) {
      print("----" + data.toString());
    });
    setState(() {
      if (isLoadMore) {
        datas.addAll(domains);
      } else {
        datas.clear();
        datas.addAll(domains);
      }
    });
  }

  Future<void> _onRefresh() async {
    isLoadMore = false;
    pageNum = 1;
    await commonPresenter.getDatas(this.widget.url, pageNum, itemCount);
  }

  Future<Null> _onLoadMore() {
    pageNum += 1;
    isLoadMore = true;
    commonPresenter.getDatas(this.widget.url, pageNum, itemCount);
    return null;
  }

  @override
  void showLoading() {
    // TODO: implement showLoading
  }

  Widget _getItemView(BuildContext context, int index) {
    if (index < datas.length) {
      CommonBean data = datas[index];
      switch (this.widget.url) {
        case 'data/福利':
          return BeautyHero(
            imageUrl: data.url,
            onTap: () {
             Navigator.of(context).push(new MaterialPageRoute(builder: (context){
               return BeautyDetailScene(des:data.type,imgUrl:data.url);
             }));
            },
          );
        default:
          return InkWell(
            onTap: () => _onItemClick(data),
            child: Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/item_bg.jpg'),
                      fit: BoxFit.fill)),
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: index == 0 ? 0 : 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Padding(
                    padding: EdgeInsets.only(left: 10, top: 15),
                    child: Text(
                      '${data.type}',
                      style: Theme.of(context)
                          .textTheme
                          .copyWith(
                              headline: TextStyle(
                                  color: Theme.of(context).primaryColor))
                          .headline,
                    ),
                  ),
                  new Padding(
                    padding: EdgeInsets.only(left: 10, top: 20, right: 60),
                    child: Text(
                      data.desc,
                      style: Theme.of(context).textTheme.headline,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  new Padding(
                    padding: EdgeInsets.only(left: 10, top: 80, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          '${data.publishedAt.substring(0, 10)}',
                          style: Theme.of(context).textTheme.display3,
                        ),
                        Text(
                          '作者:${data.who}',
                          style: Theme.of(context).textTheme.display3,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            splashColor: Theme.of(context).primaryColor,
          );
      }
    } else {
      return _getLoadMoreView();
    }
  }

  Widget _getLoadMoreView() {
    return Container(
      height: 60,
      width: double.infinity,
      alignment: Alignment.center,
      child: Opacity(
        opacity: isLoadMore ? 1.0 : 0.0,
        child: WaitingWidget(),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  void _onItemClick(CommonBean data) {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new WebViewPage(data.desc, data.url);
    }));
  }

  Widget _getViewType(String url) {
    switch (url) {
      case 'data/福利':
        //此处引用瀑布流布局
        return new StaggeredGridView.countBuilder(
          crossAxisCount: 2,
          itemBuilder: (BuildContext context, int index) {
            return _getItemView(context, index);
          },
          staggeredTileBuilder: (int index) {
            return StaggeredTile.fit(1);
          },
          itemCount: datas.length + 1,
          mainAxisSpacing: 20,
          crossAxisSpacing: 2,
        );
      default:
        return new ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return _getItemView(context, index);
          },
          itemCount: datas.length + 1, //+1为加载更多时候的视图
        );
    }
  }
}
