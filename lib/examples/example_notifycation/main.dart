import 'package:flutter/material.dart';
import 'package:flutter_weekly/examples/example_notifycation/test.dart';
import 'package:flutter_weekly/examples/example_notifycation/test_notification.dart';

void main() {
 // runApp(new NotificationApp());
  runApp(new ScrollApp());
}

class NotificationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      home: TestNotificationPage(),//NotificationPage(),//
    );
  }
}

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NotificationListener<ScrollEndNotification>(
            onNotification: (notification) {
              switch (notification.runtimeType) {
                case ScrollStartNotification:
                  print("ScrollStartNotification");
                  break;
                case ScrollUpdateNotification:
                  print("ScrollUpdateNotification");
                  break;
                case ScrollEndNotification:
                  print("ScrollEndNotification");
                  break;
                case OverscrollNotification:
                  print("OverscrollNotification");
                  break;
              }
              return false;
            },
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text("$index"),
                );
              },
              itemCount: 40,
            )));
  }
}
