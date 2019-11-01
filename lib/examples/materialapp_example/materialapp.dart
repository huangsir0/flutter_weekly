import 'package:flutter/material.dart';


class MaterialMyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "我是Flutter标题",
      routes: <String,WidgetBuilder>{
        "/first":(BuildContext context)=>FirstPage(),
        "/second":(BuildContext context)=>SecondPage()
      },
      theme: ThemeData(
        primaryColor: Colors.redAccent,
      ),
      home:/*Center(
        child: Text("Hello Flutter",style: TextStyle(fontSize: 20),),
      )*/FirstPage()
     ,
      debugShowMaterialGrid: false,
    );
  }
}


class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("第一页"),
      ),
      body: Center(
        child: RaisedButton(onPressed:(){
          Navigator.pushNamed(context, '/second');
        },child: Text("跳转到第二页"),),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("第二页"),
      ),
      body: Center(
        child: RaisedButton(onPressed:(){
          Navigator.of(context).pop(context);
        },child: Text("返回到第一页"),),
      ),
    );
  }
}

///
/// 主页
///
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();

}

class _MyHomePageState extends State<MyHomePage>  {
  var _curIndex=0;


  var _pagerController =new PageController(initialPage: 0);

  List<String> _tabs=["Gank","Widgets","Example","Setting"];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new PageView.builder(itemBuilder: (BuildContext context,int index){
           return _buildPageItem(context,index);
      },
        itemCount: _tabs.length,
        controller: _pagerController,
        onPageChanged: (index){
           _onChangePageView(index);
        },

      ),
      bottomNavigationBar: BottomNavigationBar(items: [
        _buildBottomItem(Icons.home, _tabs[0]),
        _buildBottomItem(Icons.widgets, _tabs[1]),
        _buildBottomItem(Icons.ac_unit, _tabs[2]),
        _buildBottomItem(Icons.settings, _tabs[3]),
      ],
      currentIndex: _curIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (index){
        _pagerController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.ease);
      },),
    );
  }

  void _onChangePageView(int index) {
    setState(() {
      _curIndex=index;
    });
  }

  Widget _buildPageItem(BuildContext context, int index) {
     return ContentWidget(content:_tabs[index]);
  }

  BottomNavigationBarItem _buildBottomItem(IconData iconData, String tab) {
   return new BottomNavigationBarItem(icon: Icon(iconData),title: Text(tab));
  }


}


///
/// 内容页面
///
class ContentWidget extends StatefulWidget  {
   final String content;


  const ContentWidget({Key key, this.content}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new __ContentWidgetStage();
  }
}


class __ContentWidgetStage extends State<ContentWidget> with AutomaticKeepAliveClientMixin{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("initState===>"+this.widget.content);
  }
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title:Text(this.widget.content),),
      body:Center(
        child: Text(this.widget.content,style: TextStyle(color: Colors.redAccent),),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}


