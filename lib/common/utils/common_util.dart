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


  static List<ColorGradient> getColorGradients(){
    return[
      ColorGradient(colorName:"1",colors: [Color(0xFFABDCFF),Color(0xFF0396FF)]),
    ];
  }


}



//自定义Color类
class ColorGradient{
  final String colorName;

  final List<Color> colors;

  ColorGradient({this.colorName, this.colors});

  ///
  get  gradient =>LinearGradient(colors: this.colors);

}