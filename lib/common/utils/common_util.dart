import 'package:flutter/material.dart';
import 'package:flutter_weekly/common/styles/color_style.dart';

class CommonUtils {
  static getThemeData(Color color) {
    var themData = ThemeData(
      primarySwatch: color,
      fontFamily: null, //'XiaRiFengGe',//'''ZCOOLKuaiLe',
      backgroundColor: Colors.white,
      textTheme: TextTheme(
        title: TextStyle(fontSize: 24.0, color: Colors.grey[800]),
        headline: TextStyle(
            fontSize: 22, color: Colors.grey[800], letterSpacing: 1.2),
        body1: TextStyle(
            fontSize: 20, color: Colors.grey, letterSpacing: 1.2, height: 1.2),
        body2: TextStyle(fontSize: 20, color: Colors.grey, letterSpacing: 1.5),
        display1: TextStyle(
            fontSize: 16, color: Colors.grey, letterSpacing: 1.2, height: 1.5),
        display3: TextStyle(
          fontSize: 14,
          color: Colors.grey,
          letterSpacing: 1.2,
        ),
      ),
    );
    return themData;
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



 static   Map<int, Color> turnMaterialColor =
  {
    50:Color.fromRGBO(136,14,79, .1),
    100:Color.fromRGBO(136,14,79, .2),
    200:Color.fromRGBO(136,14,79, .3),
    300:Color.fromRGBO(136,14,79, .4),
    400:Color.fromRGBO(136,14,79, .5),
    500:Color.fromRGBO(136,14,79, .6),
    600:Color.fromRGBO(136,14,79, .7),
    700:Color.fromRGBO(136,14,79, .8),
    800:Color.fromRGBO(136,14,79, .9),
    900:Color.fromRGBO(136,14,79, 1),
  };
}
