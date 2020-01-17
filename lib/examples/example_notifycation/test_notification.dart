import 'package:flutter/material.dart';

class TestNotification extends Notification {
  final String msg;

  TestNotification(this.msg);
}

class TestNotificationPage extends StatefulWidget {
  @override
  _TestNotificationPageState createState() => _TestNotificationPageState();
}

class _TestNotificationPageState extends State<TestNotificationPage> {
  String msg = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener<TestNotification>(
        onNotification: (notification) {
          print(notification.msg);
          //能否打印取决于子监听中的onNotification返回值
          return true;
        },
        child: NotificationListener<TestNotification>(
            onNotification: (notification) {
              setState(() {
                msg += notification.msg + "\t";
              });
              //这里返回true，父节点的监听将收不到通知
              //返回false则可以
              return false;
            },
            child: Container(
              margin: EdgeInsets.only(top: 40),
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  RaisedButton(
                    //按钮点击时分发通知
                    onPressed: () =>
                        TestNotification("Hello").dispatch(context),
                    child: Text("无效的通知"),
                  ),
                  Builder(
                    builder: (context) {
                      return RaisedButton(
                        //按钮点击时分发通知
                        onPressed: () =>
                            TestNotification("Hello").dispatch(context),
                        child: Text("发送通知"),
                      );
                    },
                  ),
                  Text(msg)
                ],
              ),
            )),
      ),
    );
  }
}
