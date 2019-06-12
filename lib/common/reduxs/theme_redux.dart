import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

///通过 flutter_redux 的 combineReducers，实现 Reducer 方法
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
