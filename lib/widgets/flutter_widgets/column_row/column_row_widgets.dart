import 'package:flutter/material.dart';

class RowColunmPage extends StatefulWidget {
  @override
  _RowColunmPageState createState() => _RowColunmPageState();
}

class _RowColunmPageState extends State<RowColunmPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Row&Column'),
      ),
      body: SingleChildScrollView(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              'Wellcome to Flutter!',
              style: TextStyle(fontSize: 22, color: Colors.green),
            ),
            Text(
              'Wellcome to Flutter!' * 2,
              style: TextStyle(fontSize: 18, color: Colors.blue),
            ),
            //_rowMainAlignAll(),
            _crossAligbAll(),
            _mainSize(MainAxisSize.min),
            _mainSize(MainAxisSize.max),
            _rowVertical(VerticalDirection.down),
            _rowVertical(VerticalDirection.up),
            _rowDirection(TextDirection.ltr),
            _rowDirection(TextDirection.rtl),
          ],
        ),
      ),
    );
  }

  Widget _rowMainAlignAll() => Column(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              'MainAxisAlignment.start',
              style: TextStyle(fontSize: 22),
            ),
          ),
          _rowMainAlign(MainAxisAlignment.start),
          SizedBox(
            height: 10,
          ),
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              'MainAxisAlignment.center',
              style: TextStyle(fontSize: 22),
            ),
          ),
          _rowMainAlign(MainAxisAlignment.center),
          SizedBox(
            height: 10,
          ),
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              'MainAxisAlignment.end',
              style: TextStyle(fontSize: 22),
            ),
          ),
          _rowMainAlign(MainAxisAlignment.end),
          SizedBox(
            height: 10,
          ),
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              'MainAxisAlignment.spaceBetween',
              style: TextStyle(fontSize: 22),
            ),
          ),
          _rowMainAlign(MainAxisAlignment.spaceBetween),
          SizedBox(
            height: 10,
          ),
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              'MainAxisAlignment.spaceEvenly',
              style: TextStyle(fontSize: 22),
            ),
          ),
          _rowMainAlign(MainAxisAlignment.spaceEvenly),
          SizedBox(
            height: 10,
          ),
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              'MainAxisAlignment.spaceAround',
              style: TextStyle(fontSize: 22),
            ),
          ),
          _rowMainAlign(MainAxisAlignment.spaceAround),
        ],
      );

  Widget _rowMainAlign(mainAxisAlignment) => Container(
        color: Colors.red,
        height: 50,
        child: new Row(
          mainAxisAlignment: mainAxisAlignment,
          children: <Widget>[
            Text('Open'),
            Text('Open'),
            Text('Open'),
            Text('Open'),
          ],
        ),
      );

  Widget _crossAligbAll() => Column(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Container(
            alignment: Alignment.topLeft,
            child: Text('CrossAxisAlignment.center'),
          ),
          _crossAlign(CrossAxisAlignment.center),
          SizedBox(
            height: 10,
          ),
          Container(
            alignment: Alignment.topLeft,
            child: Text('CrossAxisAlignment.end'),
          ),
          _crossAlign(CrossAxisAlignment.end),
          SizedBox(
            height: 10,
          ),
          Container(
            alignment: Alignment.topLeft,
            child: Text('CrossAxisAlignment.start'),
          ),
          _crossAlign(CrossAxisAlignment.start),
          SizedBox(
            height: 10,
          ),
          Container(
            alignment: Alignment.topLeft,
            child: Text('CrossAxisAlignment.baseline.ideographic'),
          ),
          _crossBaseline(CrossAxisAlignment.baseline,TextBaseline.ideographic),
          SizedBox(
            height: 10,
          ),
          Container(
            alignment: Alignment.topLeft,
            child: Text('CrossAxisAlignment.stretch'),
          ),
          _crossBaseline(CrossAxisAlignment.stretch,null),


        ],
      );

  Widget _crossAlign(crossAxisAlignment) => Container(
        color: Colors.lightBlue,
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: crossAxisAlignment,
          textBaseline: TextBaseline.ideographic,
          children: <Widget>[
            Text('Flutter',style: TextStyle(fontSize: 10),),
            Text('Flutter',style: TextStyle(fontSize: 18)),
            Text('Flutter',style: TextStyle(fontSize: 34)),
            Text('Flutter',style: TextStyle(fontSize: 18)),
          ],
        ),
      );

  //Because of our CrossAxisAlignment.baseline need to use with textBaseline

  Widget _crossBaseline(crossAxisAlignment, TextBaseline baseline) => Container(
        color: Colors.lightBlue,
        height: 80.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: crossAxisAlignment,
          textBaseline: baseline,
          children: <Widget>[
            Text('Flutter',style: TextStyle(fontSize: 10),),
            Text('Flutter',style: TextStyle(fontSize: 18)),
            Text('Flutter',style: TextStyle(fontSize: 34)),
            Text('Flutter',style: TextStyle(fontSize: 18)),
          ],
        ),
      );


  Widget _mainSize(mainSize)=>Container(
    color: mainSize==MainAxisSize.min?Colors.yellow:Colors.red,
    child: Row(
      mainAxisSize: mainSize,
      children: <Widget>[
        Text('Flutter',style: TextStyle(fontSize: 10),),
        Text('Flutter',style: TextStyle(fontSize: 18)),
        Text('Flutter',style: TextStyle(fontSize: 34)),
        Text('Flutter',style: TextStyle(fontSize: 18)),
      ],
    ),
  );

  Widget _rowVertical(direct)=>Container(
    color: direct==VerticalDirection.down?Colors.blue[800]:Colors.green,
    height: 100,
    child: Column(
      verticalDirection: direct,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Text('Flutter',style: TextStyle(fontSize: 10),),
        Text('Flutter',style: TextStyle(fontSize: 18)),
        Text('Flutter',style: TextStyle(fontSize: 34)),
        Text('Flutter',style: TextStyle(fontSize: 18)),
      ],
    ),
  );

  Widget _rowDirection(textDirect)=>Container(
    color: textDirect==TextDirection.ltr?Colors.redAccent:Colors.purple,
    height: 60,
    child: Row(
      textDirection: textDirect,
      children: <Widget>[
        Text('Flutter',style: TextStyle(fontSize: 10),),
        Text('Flutter',style: TextStyle(fontSize: 18)),
        Text('Flutter',style: TextStyle(fontSize: 34)),
        Text('Flutter',style: TextStyle(fontSize: 18)),
      ],
    ),
  );
}
