import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';


//Hero 里面需要包裹Material组件
class BeautyHero extends StatelessWidget {
  final String imageUrl;
  final VoidCallback onTap;

  BeautyHero({Key key, @required this.imageUrl, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      padding: EdgeInsets.all(10),
      child:Hero(
          tag: this.imageUrl,
           transitionOnUserGestures: true,
          child:Material(color: Colors.transparent, child:  InkWell(
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.fill,
              ),
            ),
            onTap: onTap,
          ),))
    ));
  }
}
