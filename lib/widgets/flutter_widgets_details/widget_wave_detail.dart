import 'package:flutter/material.dart';
import '../flutter_bezier_widgets/widget_circle_progress.dart';
import '../flutter_bezier_widgets/widget_study_bezierpainter.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class WidgetWavePage extends StatefulWidget {
  @override
  _WidgetWavePageState createState() => _WidgetWavePageState();
}

class _WidgetWavePageState extends State<WidgetWavePage> {
  List<Widget> _widgets = new List();

  @override
  Widget build(BuildContext context) {
    _widgets.clear();
    _widgets.add(_getCard(context,CustomBezierWidget1(color: Theme.of(context).primaryColor,)));
    _widgets.add(_getCard(context,CustomBezierWidget(color: Theme.of(context).primaryColor)));
    _widgets.add(_getCard(context,WidgetCircleProgressWidget(color: Theme.of(context).primaryColor,)));
    return Scaffold(
      appBar: AppBar(
        title: Text('WaveWidget'),
      ),
      body: Swiper(
        itemCount: _widgets.length,
        itemBuilder: (BuildContext context,int index){
          return _widgets[index];
        },
        pagination: SwiperPagination(),
        controller: SwiperController(),
      ),
    );
  }

  ///获取Card
  Widget _getCard(BuildContext context, Widget customBezierWidget) {
    return Container(
      child: Card(
        child: customBezierWidget,
      ),
    );
  }
}
