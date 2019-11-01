import 'package:flutter/material.dart';

class PositionPage extends StatefulWidget {
  @override
  _PositionPageState createState() => _PositionPageState();
}

class _PositionPageState extends State<PositionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Position'),
      ),
      body: new StackWidget1(),
    );
  }
}

class StackWidget1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.expand(),
      child: new Stack(
        alignment: Alignment.center, //指定未定位或部分定位widget的对齐方式
        children: <Widget>[
          Container(
            child: Text(
              'positioned-null',
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.red,
          ),
          Positioned(
            left: 18.0,
            child: Text('left'),
          ),
          Positioned(
            top: 18,
            child: Text('top'),
          ),
          Positioned(
            bottom: 18,
            child: Text('bottom'),
          ),
          Positioned(
            right: 18,
            child: Text('right'),
          ),
        ],
      ),
    );
  }
}


class StackWidget3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child: Container(
          color: Colors.purple,
          constraints: BoxConstraints.expand(height: 100),
          child: Stack(
            children: <Widget>[
              Positioned(
                left: 10,
                top: 10,
                height: 60,
                width: 60,
                child: Container(
                  color: Colors.red,
                ),
              ),
              Positioned(
                right: 200,
                top: 30,
                height: 60,
                width: 60,
                child: Container(
                  color: Colors.blue,
                ),
              ),
              Positioned(
                right: 10,
                top: 10,
                height: 60,
                width: 60,
                child: Container(
                  color: Colors.green,
                ),
              ),
            ],
          ),
        ));
  }
}
