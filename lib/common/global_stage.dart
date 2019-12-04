//全局Redux store 的对象,保存Stage数据
import 'package:flutter/material.dart';
import 'package:flutter_weekly/common/reduxs/theme_redux.dart';
import 'package:flutter_weekly/common/utils/common_util.dart';


class GlobalStage {
  //主题
  ThemeData themeData;

  //颜色Gradient
  ColorGradient colorGradient;

  //构造
  GlobalStage({this.themeData,this.colorGradient});
}

//创建Reducer
//源码中 Reducer 是一个方法 typedef State Reducer<State>(State state, dynamic action);
//我们自定义了 appReducer 用于创建 store
GlobalStage appReducer(GlobalStage stage, action) {
  return new GlobalStage(
    ///通过 ThemeDataReducer 将 GSYState 内的 themeData 和 action 关联在一起
    themeData: ThemeDataReducer(stage.themeData, action),
    colorGradient: ColorGradientReducer(stage.colorGradient,action)
  );
}

