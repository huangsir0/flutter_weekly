import 'package:flutter/material.dart';

class TestAPageWidget extends StatefulWidget {
  @override
  _TestAPageWidgetState createState() => _TestAPageWidgetState();
}

class _TestAPageWidgetState extends State<TestAPageWidget> {
  @override
  Widget build(BuildContext context) {
    print("llllllllllllllllll");
    return  new Scaffold(
      body: new Center(

        child: new Text("TestAPageWidget"),
      ),
    );
  }
}


class TestAPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TestAPageWidget();
  }
}

