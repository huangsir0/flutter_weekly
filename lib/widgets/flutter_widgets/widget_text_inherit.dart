import 'package:flutter/material.dart';

class WidgetInheritTextPage extends StatefulWidget {
  @override
  _WidgetInheritPageState createState() => _WidgetInheritPageState();
}

class _WidgetInheritPageState extends State<WidgetInheritTextPage> {
  //在widget树中，文本的样式默认是可以被继承的，因此，如果在widget树的某一
  //个节点处设置一个默认的文本样式，那么该节点的子树中所有文本都会默认使用这个样式,例如 DefaultTextStyle
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("TextStyle的inherit属性"),),
      body:DefaultTextStyle(
        //1.设置文本默认样式
        style: TextStyle(
          color:Colors.teal,
          fontSize: 20.0,
        ),
        textAlign: TextAlign.start,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("hello world"),
            Text("你好世界"),
            Text("ni hao,shi jie,此处inherit=false,不再继承父节点的文本样式",
              style: TextStyle(
                  inherit: false, //2.不继承默认样式
                  color: Colors.grey
              ),
            ),
          ],
        ),
      ),);
  }
}
