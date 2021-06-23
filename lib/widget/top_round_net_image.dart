import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class TopRoundNetImage extends StatelessWidget {
  final String url;
  final double height;
  final double witht;
  final double corner;

  const TopRoundNetImage(
      {Key key, this.url, this.height = 100, this.witht = 100, this.corner = 2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CachedNetworkImage(
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(corner)),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
        imageUrl: url,
      ),
    );
  }
}
