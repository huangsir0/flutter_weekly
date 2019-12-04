import 'package:flutter/material.dart';

import 'inheried_home_page.dart';



class InheriedWidgetApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: "InheriedWidgetApp",
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: InheriedHomePage(),
    );
  }
}