

import 'package:flutter/material.dart';
import 'package:flutter_weekly/common/styles/color_style.dart';

class CommonUtils{

  static getThemeData(Color color) {
    return ThemeData(primarySwatch: color, platform: TargetPlatform.android);
  }


  static List<Color> getThemeListColor() {
    return [
      GlobalColors.primarySwatch,
      Colors.brown,
      Colors.blue,
      Colors.teal,
      Colors.amber,
      Colors.blueGrey,
      Colors.deepOrange,
    ];
  }
}

