import 'package:flutter/material.dart';
import 'package:flutter_weekly/common/styles/color_style.dart';

class CommonUtils {
  static getThemeData(Color color) {
    var themData = ThemeData(
      primaryColor: color,
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
    return getColorGradients().map((ColorGradient gradient) {return gradient.color() ;}).toList();
  }

  static List<ColorGradient> getColorGradients() {
    return [
      ColorGradient(colorName: "0", colors: [
        Color.lerp(Color(0xFFABDCFF), Color(0xFF0396FF), 0.4),
        Color(0xFF0396FF)
      ]),
      ColorGradient(colorName: "1", colors: [
        Color.lerp(Color(0xFFFFF6B7), Color(0xFFF6416C), 0.4),
        Color(0xFFF6416C)
      ]),
      ColorGradient(colorName: "2", colors: [
        Color.lerp(Color(0xFFE2B0FF), Color(0xFF9F44D3), 0.4),
        Color(0xFF9F44D3)
      ]),
  /*    ColorGradient(colorName: "3", colors: [
        Color.lerp(Color(0xFF3C8CE7), Color(0xFF00EAFF), 0.8),
        Color(0xFF3C8CE7)
      ]),*/
      ColorGradient(colorName: "4", colors: [
        Color.lerp(Color(0xFFF6CEEC), Color(0xFFD939CD), 0.4),
        Color(0xFFD939CD)
      ]),
      ColorGradient(colorName: "5", colors: [
        Color.lerp(Color(0xFF90F7EC), Color(0xFF32CCBC), 0.4),
        Color(0xFF32CCBC)
      ]),
    ];
  }
}

//自定义Color类
class ColorGradient {
  final String colorName;

  final List<Color> colors;

  ColorGradient({this.colorName, this.colors});

  //Color
  Color color() => Color.lerp(this.colors[0], this.colors[1], 0.5);

  ///
  get gradient => LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: this.colors);
}
