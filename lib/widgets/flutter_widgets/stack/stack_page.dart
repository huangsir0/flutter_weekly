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
            _simpleStack(),
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



  Widget _simpleStack()=>Container(
    constraints: BoxConstraints.expand(height: 160),
    child: new Stack(
      children: <Widget>[
        Container(color: Colors.red,),
        Container(margin: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
        color: Colors.blue,),
        Container(color: Colors.purple,margin: EdgeInsets.symmetric(vertical: 30,horizontal: 60),),
        Container(color: Colors.yellow,margin: EdgeInsets.symmetric(vertical: 50,horizontal: 80),),
      ],
    ),
  );

  Widget _alignStack()=>Container(
    margin: EdgeInsets.only(top: 10),
    color: Colors.lightBlueAccent,
    constraints: BoxConstraints.expand(height: 160),
    child: Stack(
      alignment: Alignment.centerRight,
      children: <Widget>[
        Container(
          height: 100,
            width: 100,
          color: Colors.white,
        ),
        Container(height: 60,width: 60,color: Colors.black45,)
      ],
    ),
  );


  Widget _textLeftStack()=>Container(
    margin: EdgeInsets.only(top: 10),
    color: Colors.green,
    padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
    constraints: BoxConstraints.expand(height: 60),
    child: Stack(
      textDirection: TextDirection.ltr,
      children: <Widget>[
        Text('Flutter Open drawed from left to rigt',style: TextStyle(color: Colors.purple),),
      ],
    ),
  );


  Widget _textRightStack()=>Container(
    margin: EdgeInsets.only(top: 10),
    constraints: BoxConstraints.expand(height: 60),
    color: Colors.lightBlueAccent,
    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
    child: Stack(
      textDirection: TextDirection.rtl,
      children: <Widget>[
        Text('Flutter Open drawed from rigt to left',style: TextStyle(color: Colors.purple),),
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
          constraints: BoxConstraints.expand(height: 60),
          color: Colors.red,
          child: Stack(
            fit: StackFit.loose,
            children: <Widget>[
              Container(
                color: Colors.blueAccent,
                child: Text('StackFit.loose',style: TextStyle(color: Colors.black45,fontSize: 20),),
              ),
            ],
          ),
        ),
        Container(
          constraints: BoxConstraints.expand(height: 60),
          color: Colors.green,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Container(
                child: Text('StackFit.expand',style: TextStyle(color: Colors.black45,fontSize: 20),),
                color: Colors.blue,
              ),
            ],
          ),
        ),
        SizedBox(height: 10,),
        Container(constraints: BoxConstraints.expand(height:60),
        color: Colors.yellow,
          child: Stack(
            fit: StackFit.passthrough,
            children: <Widget>[
              Container(
                child: Text('StackFit.passthrough',
                style: TextStyle(color: Colors.deepOrangeAccent,fontSize: 20),),
                color: Colors.black45,
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
          child: Text("Flutter Open is too long to draw here, it will be visible.\n666666666666666666666666666666666",
            style: TextStyle(color: Colors.black),),
        ),
      ],
    ),
  );

  Widget _overClipStack()=>Container(
    margin:  EdgeInsets.only(top: 10),
    color: Colors.lightBlue,
    constraints: BoxConstraints.expand(height: 40),
    child: Stack(
      overflow: Overflow.clip,
      children: <Widget>[
        Positioned(
          top: 15,
          child: Text("Flutter Open is too long to draw here, it will be visible.\n666666666666666666666666666666666",
            style: TextStyle(color: Colors.black),),
        ),
      ],
    ),
  );

  Widget _posStack() =>Container(
    margin: EdgeInsets.only(top: 10),
    constraints: BoxConstraints.expand(height: 40),
    color: Colors.teal,
    child: new RaisedButton(onPressed: (){
      Navigator.of(context).push(new MaterialPageRoute(builder: (context){
        return new PositionPage();
      }));
    },child: new Text("Postioned",style: TextStyle(fontSize: 22),),),
  );
}


