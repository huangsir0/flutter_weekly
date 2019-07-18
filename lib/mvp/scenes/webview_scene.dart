import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {

   String title;

   String url;

  WebViewPage(this.title, this.url);

  @override
  _WebViewPageState createState() => _WebViewPageState();

}

class _WebViewPageState extends State<WebViewPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(this.widget.title),
      ),
      body:  Column(
        children: <Widget>[
          Expanded(child:  WebView(
            initialUrl: this.widget.url,
            javascriptMode: JavascriptMode.unrestricted,
            onPageFinished: (msg){
              print("=======================>"+msg);
            },
          )),
        ],
      ),
    );
  }
}
