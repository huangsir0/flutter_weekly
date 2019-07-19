import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weekly/common/utils/screen.dart';
import 'package:flutter_weekly/widgets/flutter_widgets/widget_text_inherit.dart';

class WidgetTextPage extends StatefulWidget {
  @override
  _WidgetTextPageState createState() => _WidgetTextPageState();
}

final String content = 'Text，很常用的一个Widget。作为一个Android 开发者，我把它当成一个TextView来对待。';

class _WidgetTextPageState extends State<WidgetTextPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter•Text'),
        centerTitle: true,
      ),
      body: new Container(
          child: new Padding(
            padding: EdgeInsets.only(
                left: Screen.setWidth(0), right: Screen.setWidth(0)),
            child: new SingleChildScrollView(
              child: new Column(
                children: <Widget>[
                  _getItemWidget(Text(
                    content,
                    style: TextStyle(
                        inherit: false, fontSize: 16, color: Colors.white),
                  )),
                  _getItemWidget(Text(
                    content,
                    style: TextStyle(
                        inherit: false, fontSize: 16, color: Colors.white,height: 1.5),
                  )),
                  _getItemWidget(Text(
                    content,
                    style: TextStyle(
                        inherit: false,
                        color: Colors.black,
                        fontSize: 16,
                        background: Paint()
                          ..color = Colors.white
                          ..style = PaintingStyle.fill),
                  )),
                  _getItemWidget(Text(
                    content,
                    style: TextStyle(
                        inherit: false,
                        fontSize: 23,
                        foreground: Paint()
                          ..color = Colors.white
                          ..strokeWidth = 1
                          ..style = PaintingStyle.stroke),
                  )),
                  _getItemWidget(Text(
                    content,
                    style: TextStyle(
                      inherit: false,
                      fontSize: 23,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  )),
                  _getItemWidget(Text(
                    content,
                    style: TextStyle(
                      inherit: false,
                      fontSize: 23,
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
                    ),
                  )),
                  _getItemWidget(Text(
                    "TextStyle with letterSpacing 10",
                    style: TextStyle(
                        inherit: false,
                        fontSize: 16,
                        color: Colors.black,
                        fontStyle: FontStyle.italic,
                        background: Paint()..color = Colors.white,
                        letterSpacing: 10),
                  )),
                  _getItemWidget(Text(
                    "TextStyle with Shadow",
                    style: TextStyle(fontSize: 30, color: Colors.white, shadows: [
                      Shadow(color: Colors.white, offset: Offset(1, 2), blurRadius: 2)
                    ]),
                  )),
                  _getItemWidget(Text(
                    "TextStyle with decoration underline",
                    style: TextStyle(
                        fontSize: 16,
                        inherit: false,
                        color: Colors.black,
                        background: Paint()..color = Colors.white,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.red,
                        decorationStyle: TextDecorationStyle.wavy),
                  )),
                  _getItemWidget(Text(
                    "TextStyle with decoration lineThrough",
                    style: TextStyle(
                        inherit: false,
                        fontSize: 16,
                        color: Colors.black,
                        background: Paint()..color = Colors.white,
                        decoration: TextDecoration.lineThrough,
                        decorationColor: Colors.red,
                        decorationStyle: TextDecorationStyle.double),
                  )),
                  _getItemWidget(Container(
                    color: Colors.white,
                    constraints: BoxConstraints.expand(height: 40, width: 160),
                    child: Text(
                      "textDirection draw from right to left",
                      textDirection: TextDirection.rtl,
                      style: TextStyle(inherit: false, color: Colors.black),
                    ),
                  )),
                  _getItemWidget(Container(
                    color: Colors.white,
                    constraints: BoxConstraints.expand(height: 40, width: 160),
                    child: Text(
                      "textDirection draw from left to right",
                      textDirection: TextDirection.ltr,
                      style: TextStyle(inherit: false, color: Colors.black),
                    ),
                  )),
                  _getItemWidget(Container(
                    color: Colors.white,
                    constraints: BoxConstraints.expand(height: 40, width: 240),
                    child: Text(
                      "overflow TextOverflow.ellipsis: Text Text Text",
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(inherit: false, color: Colors.black),
                    ),
                  )),
                  _getItemWidget(Text(
                    "textScaleFactor = 1 fontSize = 16 ",
                    style: TextStyle(
                        inherit: false, fontSize: 16, color: Colors.white),
                    textScaleFactor: 1,
                  )),
                  _getItemWidget(Text(
                    "textScaleFactor = 1.2 fontSize = 16 ",
                    style: TextStyle(
                        fontSize: 16, inherit: false, color: Colors.white),
                    textScaleFactor: 1.2,
                  )),

                  _getItemWidget(new Text.rich(new TextSpan(
                    text: 'One: ',
                    style: new TextStyle(
                        fontSize: 40.0,
                        color: Colors.white,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.teal,
                        decorationThickness: 2,
                        decorationStyle: TextDecorationStyle.solid
                    ),
                    children: [
                      new TextSpan(
                          text: "http://127.0.0.1:8080",
                          style: new TextStyle(
                            fontSize: 20.0,
                            color: Colors.red,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.red,
                            decorationStyle: TextDecorationStyle.solid,
                          ),
                          recognizer: new TapGestureRecognizer()
                            ..onTap = () =>
                                print('http://127.0.0.1:8080')),
                    ],
                  ))),
                  _getItemWidget(  new Text.rich(new TextSpan(
                    text: 'Two: ',
                    style: new TextStyle(
                      fontSize: 40.0,
                      color: Colors.white,
                    ),
                    children: [
                      new TextSpan(
                        text: "没有账号?",
                        style: new TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ), ),

                      new TextSpan(
                        text: "立即注册",
                        style: new TextStyle(
                          fontSize: 20.0,
                          color: Colors.teal,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.red,
                          decorationStyle: TextDecorationStyle.solid,
                        ),
                        recognizer: new TapGestureRecognizer()
                          ..onTap = () =>
                              print('注册账号'),),
                    ],
                  ))),
                  _getItemWidget(  new Text.rich(new TextSpan(
                    text: 'Three: ',
                    style: new TextStyle(
                      fontSize: 30.0,
                      color: Colors.white,

                    ),
                    children: [
                      new TextSpan(
                        text: "inherit属性不懂?",
                        style: new TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                        ), ),

                      new TextSpan(
                        text: "立即了解",
                        style: new TextStyle(
                          fontSize: 16.0,
                          color: Colors.teal,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.red,
                          decorationStyle: TextDecorationStyle.solid,
                        ),
                        recognizer: new TapGestureRecognizer()
                          ..onTap = () =>
                              Navigator.of(context).push(new MaterialPageRoute(builder: (context){
                               return new WidgetInheritTextPage();
                              }) ),),
                    ],
                  ))),
                  _getItemWidget(Text(
                    "END ",
                    style: TextStyle(
                        inherit: false, fontSize: 16, color: Colors.white),
                    textScaleFactor: 1,
                  )),
                ],
              ),
            ),
          )),
    );
  }


  Widget _getItemWidget(Widget child) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 5, left: 5, right: 5),
      height: 80,
      color: Colors.grey,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: child,
      ),
    );
  }
}
