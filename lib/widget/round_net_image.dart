import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class RoundNetImage extends StatelessWidget {
  final String url;
  final double height;
  final double width;
  final double corner;
  final BoxFit fit;

  const RoundNetImage(
      {Key key,
      this.url,
      this.height = 100,
      this.width = 100,
      this.corner = 5,
      this.fit = BoxFit.cover})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CachedNetworkImage(
        height: height,
        width: width,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(corner),
            image: DecorationImage(
              image: imageProvider,
              fit: fit,
            ),
          ),
        ),
        imageUrl: url,
      ),
    );
  }
}
