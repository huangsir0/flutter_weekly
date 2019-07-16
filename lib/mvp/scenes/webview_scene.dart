import 'package:flutter/material.dart';
import 'package:flutter_weekly/common/utils/screen.dart';

import 'package:webview_flutter/webview_flutter.dart';
class WebViewPage extends StatefulWidget {
  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Opacity(opacity: 0.0,child: Container(height: Screen.topSafeHeight,width: double.infinity,),),
        Expanded(child: const WebView(
          initialUrl: 'https://www.baidu.com',
          javascriptMode: JavascriptMode.unrestricted,
        )),
      ],
    );
  }
}
