import 'package:flutter/material.dart';
import 'package:flutter_weekly/consts/config.dart';
import 'package:flutter_weekly/mvp/beans/common_bean.dart';
import 'package:flutter_weekly/mvp/constract/commoncontract.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/ball_pulse_header.dart';
import '../common_presenter.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class CommonScene extends StatefulWidget {
  final String url;

  CommonScene(this.url);

  @override
  _CommonSceneState createState() => _CommonSceneState();
}

class _CommonSceneState extends State<CommonScene>
    with TickerProviderStateMixin
    implements ICommonView {
  GlobalKey<EasyRefreshState> _easyRefreshKey =
      new GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshHeaderState> _headerKey =
      new GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshFooterState> _footerKey =
      new GlobalKey<RefreshFooterState>();

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

  @override
  Widget build(BuildContext context) {
    return datas.length == 0
        ? Container()
        : Center(
            child: EasyRefresh(
              key: _easyRefreshKey,
              refreshHeader: BallPulseHeader(
                key: _headerKey,
              ),
              refreshFooter: BallPulseFooter(key: _footerKey),
              child: new ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return _getItemView(context, index);
                },
                itemCount: datas.length,
              ),
              onRefresh: _onRefresh,
              loadMore: _onLoadMore,
            ),
          );
  }

  @override
  void onLoadFail() {
    // TODO: implement onLoadFail
  }

  @override
  void onLoadSuc(List<CommonBean> domains) {
    // TODO: implement onLoadSuc
    datas.forEach((data){
      print("----"+data.toString());
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

  Future<Null> _onRefresh() {
    isLoadMore = false;
    pageNum = 1;
    commonPresenter.getDatas(this.widget.url, pageNum, itemCount);
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
    CommonBean data = datas[index];
    print("+++"+data.toString());
    return Container(
      alignment: Alignment.center,
      color: Colors.orange[200],
      margin: EdgeInsets.only(top: 10),
      child: SizedBox(
        height: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Padding(
              padding: EdgeInsets.only(left: 10, top: 10),
              child: Text(
                data.desc,
                style: Theme.of(context).textTheme.headline,
                maxLines: 2,
              ),
            ),
            new Padding(
              padding: EdgeInsets.only(left: 10, top: 15),
              child: Text(
                '作者:${data.who}',
                style: Theme.of(context).textTheme.display3,
              ),
            ),
            new Padding(
              padding: EdgeInsets.only(left: 10, top: 5),
              child: Text(
                '分类:${data.type}',
                style: Theme.of(context).textTheme.display3,
              ),
            ),
            new Padding(
              padding: EdgeInsets.only(left: 10, top: 20, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '${data.publishedAt}',
                    style: Theme.of(context).textTheme.display3,
                  ),
                  Text(
                    '来源:${data.source}',
                    style: Theme.of(context).textTheme.display3,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
