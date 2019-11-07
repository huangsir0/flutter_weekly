import 'package:flutter/material.dart';

class MyScaffold1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "我是标题",
      theme: ThemeData(
        primaryColor: Colors.redAccent
      ),
      home: HomePage(),
    );
  }
}


class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage>{
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int _curIndex=0;

  List<ContentPage> contents=new List();

  bool isNormalShow=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    contents.add(new ContentPage(content:"Home"));
    contents.add(new ContentPage(content:"Android"));
    contents.add(new ContentPage(content:"iOS"));
    contents.add(new ContentPage(content:"Setting"));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title:new Text("FlutterStudy"),
        centerTitle: true,
        actions: <Widget>[
         IconButton(icon: Icon(Icons.share), onPressed: (){
           _scaffoldKey.currentState.showSnackBar(SnackBar(content:Text("点击了分享！")));
         })
        ],
      ),
      drawer: new Drawer(
        child: new DrawerPage(),
      ),
      body: contents[_curIndex],
      bottomNavigationBar:isNormalShow? new BottomNavigationBar(
        items: [
          new BottomNavigationBarItem(
              icon: new Icon(Icons.home),
              title: new Text("Home")
          ),
          new BottomNavigationBarItem(
              icon: new Icon(Icons.phone_android),
              title: new Text("Android")
          ),
          new BottomNavigationBarItem(
              icon: new Icon(Icons.phone_iphone),
              title: new Text("iOS")
          ),
           new BottomNavigationBarItem(
              icon: new Icon(Icons.settings),
              title: new Text("Setting")
          ),

        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: _curIndex,
        onTap: (index){
          setState(() {
            _curIndex=index;
          });
        },
      ):BottomAppBar(
        color: Colors.white,
        shape: CircularNotchedRectangle(), // 底部导航栏打一个圆形的洞
        child: Row(
          children: [
            IconButton(icon: Icon(Icons.home),onPressed: (){
              setState(() {
                _curIndex=0;
              });
            },),
            IconButton(icon: Icon(Icons.phone_iphone),onPressed: (){
              setState(() {
                _curIndex=1;
              });
            },),
            SizedBox(), //中间位置空出
            IconButton(icon: Icon(Icons.phone_iphone),onPressed: (){

              setState(() {
                _curIndex=2;
              });
            },),
            IconButton(icon: Icon(Icons.settings),onPressed: (){
              setState(() {
                _curIndex=3;
              });
            },),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceAround, //均分底部导航栏横向空间
        ),
      ),
      floatingActionButton:isNormalShow?null: FloatingActionButton(onPressed: (){

      },backgroundColor: Colors.redAccent,
      child: Icon(Icons.add),),
      floatingActionButtonLocation:isNormalShow?null: FloatingActionButtonLocation.centerDocked,
    );
  }

}


class DrawerWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _DrawerWidgetStage();
  }
}

class _DrawerWidgetStage extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new ListView(
      padding: const EdgeInsets.only(),
      children: <Widget>[
        new UserAccountsDrawerHeader(
          accountName: new Text("HuangSir"),
          accountEmail: new Text("1244914544@qq.com"),
          currentAccountPicture: new CircleAvatar(
            backgroundImage: new NetworkImage(
                "http://img.52z.com/upload/news/image/20181108/20181108204521_83402.jpg"),
          ),
        ),
        _getListTitle("lifecycle 学习", "/LifecyclePage"),
        new Divider(),
        _getListTitle("Route 学习0", "/RoutePage0"),
        new Divider(),
        _getListTitle("Route 学习1", "/RoutePage1"),

      ],
    );
  }

  ListTile _getListTitle(String title, String route) {
    return new ListTile(
      title: new Text(title),
      trailing: new Icon(Icons.arrow_right),
      onTap: () {
        Navigator.of(context).pop();
        Navigator.pushNamed(context, route);
      },
    );
  }
}

class DrawerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      body: new DrawerWidget(),
    );
  }
}


//内容页
class ContentPage extends StatelessWidget {
  final String content;

  const ContentPage({Key key, this.content}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(this.content),
    );
  }
}
