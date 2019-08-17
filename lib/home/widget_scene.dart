import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_weekly/common/global_stage.dart';
import 'package:flutter_weekly/common/utils/http_util.dart';
import 'package:flutter_weekly/common/utils/screen.dart';
import 'package:flutter_weekly/consts/config.dart';
import 'package:flutter_weekly/mvp/beans/item_widget_bean.dart';
import 'package:flutter_weekly/widgets/loading_widget.dart';

class WidgetsWidget extends StatefulWidget {
  @override
  _WidgetPageWidgetState createState() => _WidgetPageWidgetState();
}

class _WidgetPageWidgetState extends State<WidgetsWidget> {

  //条目数据
  List<ItemWidgetBean> _widgetDatas=new List();
  //网络请求实例
  var request=DioFactory.instance;

  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refreshData();
  }

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<GlobalStage>(
      builder: (context, store) {
        return new Scaffold(
          appBar: new AppBar(
            title: new Text("Widgets"),
            centerTitle: true,
          ),
          body: _widgetDatas.length==0?new WaitingWidget(store.state.themeData.primaryColor):
          ListView.builder(itemBuilder: (context,index){
            return _getDataItem(index,store.state.themeData.primaryColor);
          },itemCount: _widgetDatas.length,),
        );
      },
    );
  }


  ///内容条目
  Widget _getDataItem(int index,Color themeColor) {
    ItemWidgetBean data =_widgetDatas[index];
    return new Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top:10,left: 10,right: 10),
        child: SizedBox(
          height: Screen.setHeight(620),
          child: new Container(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  child: Text(data.title,
                      style: Theme.of(context).textTheme.title,maxLines: 1,),
                ),
                new Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Icon(Icons.pets,color: themeColor,size: 40,)
                ),

                new Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Text(data.description,
                        style: Theme.of(context).textTheme.body1)),
                new Padding(
                    padding: EdgeInsets.only(top: 30),
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          data.author,
                          style: Theme.of(context).textTheme.display3,
                        ),
                        SizedBox(width: 5,),
                        Text(
                          data.createTime,
                          style: Theme.of(context).textTheme.display3,
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ));
  }

  void _refreshData() async {
    List result= await request.localGet(Config.widgets);
    _widgetDatas.clear();
    _widgetDatas.addAll(
      result.map((data){
        return ItemWidgetBean.fromJson(data);
      }).toList()
    );
    if(mounted){
      setState(() {

      });
    }
  }

}

class WidgetsScene extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WidgetsWidget();
  }
}
