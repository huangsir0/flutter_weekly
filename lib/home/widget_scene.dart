import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_weekly/blocs/widget_scene_blocs/widget_scene_bloc.dart';
import 'package:flutter_weekly/common/global_stage.dart';
import 'package:flutter_weekly/common/utils/screen.dart';
import 'package:flutter_weekly/blocs/widget_scene_blocs/models/item_widget_model.dart';
import 'package:flutter_weekly/widgets/flutter_bezier_widgets/widget_bezier_bg.dart';
import 'package:flutter_weekly/widgets/helper_widgets/alpha_widget.dart';
import 'package:flutter_weekly/widgets/helper_widgets/loading_widget.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:toast/toast.dart';

class WidgetsWidget extends StatefulWidget {
  @override
  _WidgetPageWidgetState createState() => _WidgetPageWidgetState();
}

class _WidgetPageWidgetState extends State<WidgetsWidget> with AutomaticKeepAliveClientMixin {
  WidgetSceneBloc widgetBloc = new WidgetSceneBloc();

  //ViewPager 相关
  var _pageController = new PageController(initialPage: 0);

  //color
  PaletteGenerator paletteGenerator;
 GlobalKey<AlphaWidgetState> _key=new GlobalKey();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _updateCgColor();
    widgetBloc.fetchWidgetItems();
  }

  Future<void> _updateCgColor() async {
    paletteGenerator = await PaletteGenerator.fromImageProvider(
        AssetImage('images/widget_scene_example.jpg'));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StoreBuilder<GlobalStage>(
      builder: (context, store) {
        return new Scaffold(
          body: StreamBuilder(
            stream: widgetBloc.widgetItems,
            builder: (context, AsyncSnapshot<List<ItemWidgetModel>> snapshot) {
              if (snapshot.hasData) {
                return Container(
                  child: Column(
                    children: <Widget>[
                      StreamBuilder(
                          stream: widgetBloc.itemDatas,
                          builder:
                              (context, AsyncSnapshot<ItemWidgetModel> model) {
                            return WidgetBezierBg(
                              baseChild: Container(
                                color: store.state.themeData.primaryColor,
                                height: 120,
                                padding:
                                    EdgeInsets.only(top: Screen.topSafeHeight),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: <Widget>[
                                    Positioned(
                                      child:  AlphaWidget(
                                         key: _key,
                                          dayTime: model.hasData
                                              ? model.data.dayTime
                                              : snapshot.data[0].dayTime,
                                          createTime: model.hasData
                                              ? model.data.createTime
                                              : snapshot.data[0].createTime),
                                      left: 10,
                                    ),
                                    Positioned(
                                      child: Row(
                                        children: <Widget>[
                                          IconButton(
                                            icon: Icon(Icons.more_vert),
                                            onPressed: () {
                                              Toast.show("点我显示更多...", context,
                                                  duration: Toast.LENGTH_LONG,
                                                  gravity: Toast.BOTTOM);
                                            },
                                            iconSize: 32,
                                            color: Colors.white,
                                          )
                                        ],
                                      ),
                                      right: 10,
                                    ),
                                  ],
                                ),
                              ),
                              color: store.state.themeData.primaryColor,
                            );
                          }),
                      Container(
                        height: Screen.screenHeightDp - 220,
                        child: PageView.builder(
                          itemBuilder: (context, index) {
                            return _getDataItem(snapshot.data[index],
                                store.state.themeData.primaryColor);
                          },
                          itemCount: snapshot.data.length,
                          controller: _pageController,
                          onPageChanged: (index) {
                            widgetBloc.dispatcherData(snapshot.data[index]);
                            _key.currentState.show();
                          },
                        ),
                      )
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('error!');
              }
              return WaitingWidget(store.state.themeData.primaryColor);
            },
          ),
        );
      },
    );
  }

  ///内容条目
  Widget _getDataItem(ItemWidgetModel data, Color themeColor) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(data.pageRoute);
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            shape: BoxShape.rectangle),
        margin: EdgeInsets.only(left: 10, right: 10),
        child: new Container(
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 220,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/widget_scene_example.jpg'),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Text(
                  data.title,
                  style: Theme.of(context).textTheme.title,
                  maxLines: 1,
                ),
              ),
              new Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Text(data.author,
                      style: Theme.of(context).textTheme.subtitle)),
              new Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Text(data.description,
                      style: Theme.of(context).textTheme.body1,maxLines: 6,overflow: TextOverflow.ellipsis,)),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    widgetBloc.dispose();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class WidgetsScene extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WidgetsWidget();
  }
}
