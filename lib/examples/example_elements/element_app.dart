import 'package:flutter/material.dart';

class ElementApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: OpacityHome(),theme: ThemeData.light(),);
  }
}



class OpacityHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("flutter绘制机制"),),
      body: Center(
        child: Opacity(opacity: 0.5,child: Container(
          width: 100,
          color: Colors.black87,
          alignment: Alignment.center,
          height: 100,
          child: Text("flutter",style: TextStyle(fontSize: 20,color: Colors.white),),
        ),),
      ),

    );
  }
}
