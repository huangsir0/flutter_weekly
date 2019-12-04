import 'package:flutter/material.dart';

class InheriedHomePage extends StatefulWidget {
  @override
  _InheriedHomePageState createState() => _InheriedHomePageState();
}

class _InheriedHomePageState extends State<InheriedHomePage> {
  int _curIndex = 0;

  PageController _pageController;

  List<String> _tabs = ["View1", "View2"];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = new PageController(initialPage: _curIndex);
  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: AppBar(
        title: Text("InheriedDemo"),
      ),
      body: PageView(
        children: <Widget>[
          WidgetA(),
          WidgetB(),
        ],
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _curIndex = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: new Icon(Icons.tablet_android), title: new Text(_tabs[0])),
          BottomNavigationBarItem(
              icon: new Icon(Icons.tablet_mac), title: new Text(_tabs[1])),
        ],
        currentIndex: _curIndex,
        onTap: (index) {
          _curIndex = index;
          _pageController.animateToPage(index,
              duration: Duration(milliseconds: 100), curve: Curves.linear);
        },
      ),
    );
  }
}

//WidgetA
class WidgetA extends StatefulWidget {
  @override
  _WidgetAState createState() => _WidgetAState();
}

class _WidgetAState extends State<WidgetA> {
  Person person = new Person("小明", 24);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        //调用构造，在此节点共享了一个Person类型的数据
        child: InheriedDataWidget(
          person: person,
          child: WidgetA1(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            //在setState中刷新Person的值
            this.person=new Person(person.name, person.age+1);
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}



//控件WidgetA
class WidgetA1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Text(
            "A1 Widget",
            style: TextStyle(color: Colors.white,fontSize: 20),
          ),
          //调用InheriedDataWidget.of()获取数据，其实也就是调用了inheritFromWidgetOfExactType方法
          Text(
            "共享数据的信息: ${InheriedDataWidget.of(context).person.toString()}",
            style: TextStyle(color: Colors.white,fontSize: 20),
          ),
          Container(
            margin: EdgeInsets.only(top: 40),
            color: Colors.deepOrangeAccent,
            height: MediaQuery.of(context).size.height*0.5,
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                WidgetA1_1(),
                WidgetA1_2(),
                WidgetA1_3(),
              ],
            ),
          ),

        ],
      ),
    );
  }
}


class WidgetA1_1 extends StatefulWidget {
  @override
  _WidgetA1_1State createState() => _WidgetA1_1State();
}

class _WidgetA1_1State extends State<WidgetA1_1> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 140,
      width: MediaQuery.of(context).size.width/3-20,
      //引用共享数据
      child: Text("WidgetA1_1ful\n\n共享数据是：${InheriedDataWidget.of(context).person.toString()}"),
    );
  }


  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    //当WidgetA中Person数据发生改变时，此方法会被调用，前提是updateShouldNotify返回true
    print("WidgetA1_1ful===>didChangeDependencies");
  }
}


class WidgetA1_2 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 140,
      width: MediaQuery.of(context).size.width/3-20,
      child: Text("WidgetA1_2less\n\n共享数据是：${InheriedDataWidget.of(context).person.toString()}"),
    );;
  }

}


class WidgetA1_3 extends StatefulWidget {
  @override
  _WidgetA1_3State createState() => _WidgetA1_3State();
}

class _WidgetA1_3State extends State<WidgetA1_3> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 140,
      width: MediaQuery.of(context).size.width/3-20,
      child: Text("WidgetA1_3ful\n\n未引用共享数据信息"),
    );
  }


  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print("WidgetA1_3===>didChangeDependencies");
  }
}

//WidgetB
class WidgetB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    //此处将报错，因为WidgetB 与WidgetA 是兄弟节点，B中并未找到A中 InheriedDataWidget 的数据
    return Text(InheriedDataWidget.of(context).person.toString());
  }
}

//数据模型
class Person {
  String name;

  int age;

  Person(this.name, this.age);

  @override
  String toString() {
    // TODO: implement toString
    return "我叫${this.name},今年${this.age}了";
  }

}

class InheriedDataWidget extends InheritedWidget {
  final Person person; //需要在树中共享的数据

  InheriedDataWidget({@required this.person,Widget child})
      : super(child: child);

  //定义一个便捷方法，方便子树中的widget获取共享数据
  static InheriedDataWidget of(BuildContext context) {

    return context.inheritFromWidgetOfExactType(InheriedDataWidget);
  }

  @override
  bool updateShouldNotify(InheriedDataWidget oldWidget) {
    // TODO: implement updateShouldNotify
    //如果返回true，则子树中依赖(build函数中有调用)本widget的子widget的`state.didChangeDependencies`方法会被调用
    return this.person.name != oldWidget.person.name ||
        this.person.age != oldWidget.person.age;
  }
}
