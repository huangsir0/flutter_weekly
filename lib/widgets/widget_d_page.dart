import 'package:flutter/material.dart';

class TestDPageWidget extends StatefulWidget {
  @override
  _TestDPageWidgetState createState() => _TestDPageWidgetState();
}

class _TestDPageWidgetState extends State<TestDPageWidget> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("TestDPageView"),
        centerTitle: true,
      ),
      body: new Center(
        child: new Text("TestDPageWidget"),
      ),
    );
  }
}


class TestDPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TestDPageWidget();
  }
}

