import 'package:flutter/material.dart';
import 'package:flutter_weekly/mvp/beans/common_bean.dart';
import 'package:flutter_weekly/mvp/constract/commoncontract.dart';
import 'package:flutter_weekly/widgets/loading_widget.dart';
import '../common_presenter.dart';


class CommonScene extends StatefulWidget {
  final String url;

  ValueChanged<bool> onScrollAction;

  CommonScene(this.url, this.onScrollAction);

  @override
  _CommonSceneState createState() => _CommonSceneState();
}

class _CommonSceneState extends State<CommonScene>
    with TickerProviderStateMixin,AutomaticKeepAliveClientMixin
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
    print("pixels=>"+scrollInfo.metrics.pixels.toString());
    print("minScrollExtent=>"+scrollInfo.metrics.minScrollExtent.toString());
    print("maxScrollExtent=>"+scrollInfo.metrics.maxScrollExtent.toString());

    if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {

      //滑到了底部
      _onLoadMore();
      if(this.widget.onScrollAction!=null){
        this.widget.onScrollAction(true);
      }
    }

    if(scrollInfo.metrics.atEdge&&scrollInfo.metrics.pixels==0.0){
       //滑到头了
      if(this.widget.onScrollAction!=null){
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
                  child: new ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return _getItemView(context, index);
                    },
                    itemCount: datas.length+1,//+1为加载更多时候的视图
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

  Future<Null> _onRefresh() async {
    isLoadMore = false;
    pageNum = 1;
    await commonPresenter.getDatas(this.widget.url, pageNum, itemCount);
    return null;
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
    if(index<datas.length){
      CommonBean data = datas[index];
      return Container(
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('images/item_bg.png'))),
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: index == 0 ? 0 : 20),
        child: SizedBox(
          height: 200,
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
                      headline:
                      TextStyle(color: Theme.of(context).primaryColor))
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
      );
    }else{
      return _getLoadMoreView();
    }

  }

  Widget _getLoadMoreView() {
    return Container(
      height: 60,
      width: double.infinity,
      alignment: Alignment.center,
      child: Opacity(opacity: isLoadMore?1.0:0.0,
      child: WaitingWidget(),),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
