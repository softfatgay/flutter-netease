import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';

class RoundNetImage extends StatelessWidget {
  final String? url;
  final double? height;
  final double width;
  final double corner;
  final BoxFit fit;
  final Color backColor;

  const RoundNetImage(
      {Key? key,
      required this.url,
      this.height = 100,
      this.width = 100,
      this.corner = 5,
      this.fit = BoxFit.cover,
      this.backColor = Colors.transparent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: backColor, borderRadius: BorderRadius.circular(corner)),
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
        imageUrl: url!,
        errorWidget: (context, url, error) {
          return Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
                border: Border.all(color: lineColor, width: 1),
                borderRadius: BorderRadius.circular(corner)),
          );
        },
      ),
    );
  }
}
