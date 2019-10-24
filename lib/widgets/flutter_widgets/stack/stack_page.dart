import 'package:flutter/material.dart';

import 'position_page.dart';



class StackPage extends StatefulWidget {
  @override
  _StackPageState createState() => _StackPageState();
}

class _StackPageState extends State<StackPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Stack"),),
      body:new SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _exampleStack(),
            _alignStack(),
            _textLeftStack(),
            _textRightStack(),
            _fitStack(),
            _overflowVisibleStack(),
            _overClipStack(),
            _posStack(),
          ],
        ),
      ),//new StackWidget2() ,
    );
  }



  Widget _exampleStack()=>Container(
    constraints: BoxConstraints.expand(height: 180),
    child: new Stack(
      children: <Widget>[
        Container(color: Colors.black,margin:EdgeInsets.all(10)),
        Container(color: Colors.white,margin: EdgeInsets.all(20),),
        Container(color: Colors.black,margin:EdgeInsets.all(30),),
        Container(color: Colors.white,margin: EdgeInsets.all(40),),
        Container(color: Colors.black,margin:EdgeInsets.all(50),),
        Container(color: Colors.white,margin: EdgeInsets.all(60),),
        Container(color: Colors.black,margin:EdgeInsets.all(70),),
        Container(color: Colors.white,margin: EdgeInsets.all(80),),

      ],
    ),
  );

  Widget _alignStack()=>Container(
    margin: EdgeInsets.only(top: 10),
    color: Colors.lightBlueAccent,
    constraints: BoxConstraints.expand(height: 180),
    child: Stack(
      //子控件的对齐方式是Alignment.centerRight
      alignment: Alignment.centerRight,
      children: <Widget>[
        Container(alignment: Alignment.centerLeft,
        color: Colors.deepPurpleAccent,
        child: Text("Alignment.centerRight",style: TextStyle(color: Colors.white),),),
        Container(
          height: 100,
            width: 100,
          color: Colors.deepOrangeAccent,

        ),
        Container(height: 60,width: 60,color: Colors.white,)
      ],
    ),
  );


  Widget _textLeftStack()=>Container(
    margin: EdgeInsets.only(top: 10),
    color: Colors.green,
    padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
    constraints: BoxConstraints.expand(height: 180),
    child: Stack(
      textDirection: TextDirection.ltr,
      children: <Widget>[
        Text('left to rigt',style: TextStyle(color: Colors.purple),),
      ],
    ),
  );


  Widget _textRightStack()=>Container(
    margin: EdgeInsets.only(top: 10),
    constraints: BoxConstraints.expand(height: 180),
    color: Colors.lightBlueAccent,
    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
    child: Stack(
      textDirection: TextDirection.rtl,
      children: <Widget>[
        Text(' rigt to left',style: TextStyle(color: Colors.purple),),
      ],
    ),
  );


  Widget _fitStack()=>Container(
    color: Colors.purple,
    margin: EdgeInsets.only(top: 10),
    constraints: BoxConstraints.expand(height: 220),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 10),
          constraints: BoxConstraints.expand(height: 60),
          color: Colors.pinkAccent,
          child: Stack(
            fit: StackFit.loose,
            children: <Widget>[
              Container(
                color: Colors.blueAccent,
                child: Text('StackFit.loose',style: TextStyle(color: Colors.white,fontSize: 20),),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          constraints: BoxConstraints.expand(height: 60),
          color: Colors.pinkAccent,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Container(
                color: Colors.blueAccent,
                child: Text('StackFit.expand',style: TextStyle(color: Colors.white,fontSize: 20),),

              ),
            ],
          ),
        ),

        Container(constraints: BoxConstraints.expand(height:60),
        margin: EdgeInsets.only(top: 10),
        color: Colors.pinkAccent,
          child: Stack(
            fit: StackFit.passthrough,
            children: <Widget>[
              Container(
                color: Colors.blueAccent,
                child: Text('StackFit.passthrough',
                style: TextStyle(color: Colors.white,fontSize: 20),),
              ),
            ],
          ),
        ),
      ],
    ),
  );


  Widget _overflowVisibleStack()=>Container(
    margin:  EdgeInsets.only(top: 10),
    color: Colors.lightBlue,
    constraints: BoxConstraints.expand(height: 40),
    child: Stack(
      overflow: Overflow.visible,
      children: <Widget>[
        Positioned(
          top: 15,
          child: Text("Flutter 基础布局Widgets之Stack\nFlutter 基础布局Widgets之Stack",
            style: TextStyle(color: Colors.black),),
        ),
      ],
    ),
  );

  Widget _overClipStack()=>Container(
    margin:  EdgeInsets.only(top: 40),
    color: Colors.lightBlue,
    constraints: BoxConstraints.expand(height: 40),
    child: Stack(
      overflow: Overflow.clip,
      children: <Widget>[
        Positioned(
          top: 15,
          child: Text("Flutter 基础布局Widgets之Stack\nFlutter 基础布局Widgets之Stack",
            style: TextStyle(color: Colors.black),),
        ),
      ],
    ),
  );

  Widget _posStack() =>Container(
    margin: EdgeInsets.all( 40),
    constraints: BoxConstraints.expand(height: 40),
    color: Colors.teal,
    child: new RaisedButton(onPressed: (){
      Navigator.of(context).push(new MaterialPageRoute(builder: (context){
        return new PositionPage();
      }));
    },child: new Text("Postioned",style: TextStyle(fontSize: 22),),color: Colors.pinkAccent,),
  );
}


