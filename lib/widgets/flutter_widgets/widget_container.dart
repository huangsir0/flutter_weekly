import 'package:flutter/material.dart';

class WidgetContainerPage extends StatefulWidget {
  @override
  _ContainerPageState createState() => _ContainerPageState();
}

class _ContainerPageState extends State<WidgetContainerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Container控件"),
        ),
        body: new SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Text('Hello world'),
                color: Colors.orange[100],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                color: Theme.of(context).primaryColor,
                padding: EdgeInsets.only(
                    left: 10.0, right: 50.0, top: 10.0, bottom: 30),
                child: Container(
                  color: Colors.orange[100],
                  child: Text("this.padding"),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                color: Theme.of(context).primaryColor,
                padding: EdgeInsets.only(
                    left: 10.0, right: 50.0, top: 10.0, bottom: 30),
                child: Container(
                  color: Colors.orange[100],
                  child: Text("this.margin"),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                color: Theme.of(context).primaryColor,
                child: Container(
                  margin: const EdgeInsets.only(
                      left: 10.0, right: 50.0, top: 10, bottom: 30),
                  color: Colors.orange[100],
                  child: Text("this.margin"),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 200.0,
                height: 100.0,
                color: Colors.orange[100],
                child: Text('width = 200,height = 100'),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                color: Colors.orange[100],
                alignment: Alignment.bottomRight,
                height: 100,
                child: Text('Alignment.bottomRight'),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                color: Theme.of(context).primaryColor,
                height: 100.0,
                alignment: AlignmentDirectional.bottomEnd,
                child: Text(
                  "AlignmentDirectional.bottomEnd=>TextDirection.ltr",
                  textDirection: TextDirection.ltr,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                color: Colors.orange[100],
                height: 100.0,
                alignment: AlignmentDirectional.bottomEnd,
                child: Text(
                  "AlignmentDirectional.bottomEnd=>TextDirection.rtl",
                  textDirection: TextDirection.rtl,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                color: Theme.of(context).primaryColor,
                constraints: BoxConstraints.expand(height: 50.0),
                child: Text('BoxConstraints constraints'),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                constraints: BoxConstraints.expand(height: 100.0),
                padding: EdgeInsets.all(10.0),
                decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: Colors.orange[100],
                    shadows: [
                      BoxShadow(
                          color: Colors.red,
                          offset: Offset(0.1, 0.5),
                          blurRadius: 2.0),
                    ]),
                child: Text('ShapeDecoration'),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                constraints: BoxConstraints.expand(height: 200),
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Theme.of(context).primaryColor,
                      Colors.orange[100]
                    ]),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.red,
                          offset: Offset(0.1, 0.5),
                          blurRadius: 2.0),
                    ]),
                child: Text(
                  "BoxDecoration",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                constraints: BoxConstraints.expand(height: 100, width: 100),
                color: Colors.orange[100],
                child: Text('This.transform'),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.only(top: 10, left: 10),
                constraints: BoxConstraints.expand(width: 100, height: 100),
                color: Colors.orange[100],
                transform: Matrix4.rotationY(3.14 / 4)..rotateX(3.14 / 4),
                child: Text('this.transform'),
              ),
            ],
          ),
        ));
  }
}