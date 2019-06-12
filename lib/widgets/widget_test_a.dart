import 'package:flutter/material.dart';

class TestAWidget extends StatefulWidget {
  @override
  _TestAWidgetState createState() => _TestAWidgetState();
}

class _TestAWidgetState extends State<TestAWidget> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("TestAColor"),
        centerTitle: true,
      ),
      body: new Center(
        child: new Container(
          height: 100,
          width: 100,
          color: Theme.of(context).primaryColor,
          alignment: Alignment.center,
          child: new Text(
              "TestAPage",
              style: new TextStyle(color: Colors.white)
          ),
        ),
      ),
    );
  }
}
