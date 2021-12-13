import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/component/img_error.dart';
import 'package:flutter_app/component/img_palceholder.dart';
import 'package:flutter_app/constant/colors.dart';

class NetImage extends CachedNetworkImage {
  NetImage(
      {@required String? imageUrl,
      final double corner = 0,
      final BoxFit fit = BoxFit.contain,
      final Alignment alignment = Alignment.center,
      final double? width,
      final double? height,
      final double fontSize = 23})
      : super(
          alignment: alignment,
          fit: fit,
          width: width,
          height: height,
          imageUrl: imageUrl ?? '',
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(corner),
              image: DecorationImage(
                image: imageProvider,
                fit: fit,
              ),
            ),
          ),
          errorWidget: (context, url, error) {
            return ImgError(fontSize: fontSize);
          },
          placeholder: (context, url) {
            return ImgPlaceHolder(fontSize: fontSize);
          },
        );
}
