import 'package:flutter/material.dart';
import 'package:flutter_weekly/common/utils/common_util.dart';
import 'package:redux/redux.dart';

///通过 flutter_redux 的 combineReducers，实现 Reducer 方法
// ignore: non_constant_identifier_names
final ThemeDataReducer = combineReducers<ThemeData>([
  TypedReducer<ThemeData, RefreshThemeDataAction>(_refresh),
]);

class RefreshThemeDataAction {
  final ThemeData themeData;

  RefreshThemeDataAction(this.themeData);
}

///定义处理 Action 行为的方法，返回新的 State
ThemeData _refresh(ThemeData themeData, RefreshThemeDataAction action) {
  themeData = action.themeData;
  return themeData;
}



//
// ignore: non_constant_identifier_names
final ColorGradientReducer=combineReducers<ColorGradient>([
  TypedReducer<ColorGradient,RefreshColorGradientAction>(_refreshColorGradient),]
);



class RefreshColorGradientAction{
  final ColorGradient colorGradient;

  RefreshColorGradientAction(this.colorGradient);
}

///定义处理 Action 行为的方法，返回新的 State
ColorGradient _refreshColorGradient(ColorGradient colorGradient, RefreshColorGradientAction action) {
  colorGradient = action.colorGradient;
  return colorGradient;
}
