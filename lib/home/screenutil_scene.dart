import 'package:flutter/material.dart';
import 'package:flutter_weekly/common/utils/screen.dart';


class ScreenUtilPage extends StatefulWidget {
  @override
  _ScreenUtilPageState createState() => _ScreenUtilPageState();
}

class _ScreenUtilPageState extends State<ScreenUtilPage> with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('屏幕尺寸信息'),
        centerTitle: true,
      ),
      body: new SingleChildScrollView(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildItemContent('当前设备宽度(dp): ', Screen.screenWidthDp,context),
            _buildItemContent('当前设备高度(dp): ', Screen.screenHeightDp,context),
            _buildItemContent('当前设备宽度(px): ', Screen.screenWidth,context),
            _buildItemContent('当前设备高度(px): ', Screen.screenHeight,context),
            _buildItemContent('当前设备像素密度: ', Screen.screenPixelRatio,context),
            _buildItemContent('当前设备状态栏高度(dp): ', Screen.topSafeHeight,context),
            _buildItemContent('当前设备底部安全高度(dp): ', Screen.bottomSafeHeight,context),
            _buildItemContent('当前设备字体缩放比例: ', Screen.textScaleFactory,context),
            _buildItemContent('NavigationBarHeight: ', Screen.navigationBarHeight,context),
            _buildItemContent('ToolBarHeight: ', Screen.toolBarHeight,context),
            _buildItemContent('实际的dp与设计稿px的宽比例: ', Screen.scaleWidth,context),
            _buildItemContent('实际的dp与设计稿px的高比例: ', Screen.scaleHeight,context),
          ],
        ),
      ),
    );
  }

  _buildItemContent(String label, double value,BuildContext context) {
    return new Container(
      color:Theme.of(context).primaryColor,
      height: Screen.setHeight(180),
      margin:  EdgeInsets.only(top:  Screen.setHeight(10)),
      alignment: Alignment.centerLeft,
      child: Text.rich(TextSpan(
          style: TextStyle(color: Colors.black),
          text: label,
          children: [
            TextSpan(
                style: TextStyle(color: Colors.white), text: value.toString())
          ])),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
