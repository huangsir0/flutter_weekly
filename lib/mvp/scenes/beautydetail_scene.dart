import 'package:flutter/material.dart';
import 'package:flutter_weekly/widgets/helper_widgets/beauty_widget.dart';
class BeautyDetailScene extends StatelessWidget {
  final String des;
  final String imgUrl;

  BeautyDetailScene({Key key, this.des, this.imgUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Center(
        child: BeautyHero(
          imageUrl: this.imgUrl,
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }
}
