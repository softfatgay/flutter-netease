import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/component/img_error.dart';
import 'package:flutter_app/component/img_palceholder.dart';

class TopRoundNetImage extends StatelessWidget {
  final String? url;
  final double height;
  final double width;
  final double corner;

  const TopRoundNetImage(
      {Key? key,
      this.url,
      this.height = 100,
      this.width = 100,
      this.corner = 2})
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
        imageUrl: '${url ?? ''}',
        placeholder: (context, url) {
          return ImgPlaceHolder();
        },
        errorWidget: (context, url, error) {
          return ImgError();
        },
      ),
    );
  }
}
