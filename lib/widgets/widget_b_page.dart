import 'package:flutter/material.dart';

class TestBPageWidget extends StatefulWidget {
  @override
  _TestBPageWidgetState createState() => _TestBPageWidgetState();
}

class _TestBPageWidgetState extends State<TestBPageWidget> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("TestBPageView"),
        centerTitle: true,
      ),
      body: new Center(
        child: new Text("TestBPageWidget"),
      ),
    );
  }
}

class TestBPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TestBPageWidget();
  }
}
