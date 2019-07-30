import 'package:flutter/material.dart';

class ScrollApp extends StatelessWidget {
  ScrollApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: ThemeData.light(),
      home: new ScrollHomeView(),
    );
  }
}

class ScrollHomeView extends StatefulWidget {
  @override
  _ScrollHomeViewState createState() => _ScrollHomeViewState();
}

class _ScrollHomeViewState extends State<ScrollHomeView>
    with SingleTickerProviderStateMixin {
  List<String> tabs = ["红色", "橙色", "黄色", "蓝色", "紫色"];

  TabController tabController;

  List<ContentPage> contentPages=new List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = new TabController(length: tabs.length, vsync: this);
    print("sssssssssssssssssssssssssssssssssss");
    contentPages.addAll([
      new ContentPage(tabs[0],this.context),
      new ContentPage(tabs[1],this.context),
      new ContentPage(tabs[2],this.context),
      new ContentPage(tabs[3],this.context),
      new ContentPage(tabs[4],this.context),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                title: Text(
                  'NestedScrollView',
                  style: TextStyle(color: Colors.deepOrange),
                ),
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  background: Image.network(
                    'https://cdn.duitang.com/uploads/item/201408/11/20140811200850_LUY5c.png',
                    fit: BoxFit.cover,
                  ),
                ),
                expandedHeight: 200,
                forceElevated: innerBoxIsScrolled,
                floating: true,
                bottom: new TabBar(
                    controller: tabController,
                    indicatorColor: Colors.deepOrange,
                    labelColor: Colors.deepOrange,
                    tabs: tabs
                        .map((String name) => new Tab(
                              text: name,
                            ))
                        .toList()),
              )
            ];
          },
          body: new TabBarView(
            controller: tabController,
            children: contentPages,
          )),
    );
  }
}

class ContentPage extends StatefulWidget {
  final String content;

  final BuildContext context;
  ContentPage( this.content,this.context);

  @override
  ContentPageState createState() => ContentPageState(this.context);
}

class ContentPageState extends State<ContentPage> {
  ContentPageState(this.context);
  final BuildContext context;


  List<String> datas = new List();

  int itemCount = 10;

  Widget divider1 = Divider(
    color: Colors.blue,
  );
  Widget divider2 = Divider(color: Colors.red);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("initState===========>${this.widget.content}");
    initData();
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    print("deactivate===========>${this.widget.content}");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print("dispose===========>${this.widget.content}");
  }

  Future<Null> _onRefresh() async {
    if (!mounted) return null;
    await Future.delayed(Duration(seconds: 2));
    initData();
    setState(() {});
    return null;
  }

  void initData() {
    datas.clear();
    for (int i = 0; i < itemCount; i++) {
      datas.add(this.widget.content + i.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return datas.length == 0
        ? Center(
            key: this.widget.key,
            child: CircularProgressIndicator(
              backgroundColor: Colors.deepOrange,
              strokeWidth: 2,
            ),
          )
        : Center(
            key: this.widget.key,
            child: new RefreshIndicator(
                child: Column(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            ListView.separated(
                              itemBuilder: (BuildContext context, int index) {
                                return _itemView(context, index);
                              },
                              itemCount: datas.length,
                              separatorBuilder: (BuildContext context, int index) {
                                return index % 2 == 0 ? divider1 : divider2;
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                onRefresh: _onRefresh),
          );
  }

  Widget _itemView(BuildContext context, int index) {
    return Container(
      alignment: Alignment.center,
      height: 80,
      child: Text(datas[index]),
    );
  }

}
