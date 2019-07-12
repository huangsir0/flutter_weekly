import 'package:flutter/material.dart';

class TestCPageWidget extends StatefulWidget {
  @override
  _TestCPageWidgetState createState() => _TestCPageWidgetState();
}

class _TestCPageWidgetState extends State<TestCPageWidget> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("TestCPageView"),
        centerTitle: true,
      ),
      body: new Center(
        child: new Text("TestCPageWidget"),
      ),
    );
  }
}


class TestCPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TestCPageWidget();
  }
}

