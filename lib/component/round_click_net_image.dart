import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/component/img_error.dart';
import 'package:flutter_app/component/img_palceholder.dart';
import 'package:flutter_app/ui/full_screen/full_screen_image.dart';

class RoundClickNetImage extends StatelessWidget {
  final List<String?> images;
  final int index;
  final double? height;
  final double width;
  final double corner;
  final BoxFit fit;
  final Color backColor;
  final double fontSize;

  const RoundClickNetImage({
    Key? key,
    this.images = const [''],
    this.height = 100,
    this.width = 100,
    this.corner = 5,
    this.fontSize = 20,
    this.fit = BoxFit.cover,
    this.backColor = Colors.transparent,
    this.index = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      openBuilder:
          (BuildContext context, void Function({Object returnValue}) action) {
        return FullScreenImage({'images': images, 'page': index});
      },
      closedBuilder: (BuildContext context, void Function() action) {
        return _image(context);
      },
      closedElevation: 0,
      closedColor: backColor,
    );
  }

  _image(BuildContext context) {
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
        imageUrl: '${images[index]}',
        errorWidget: (context, url, error) {
          return ImgError(
            fontSize: fontSize,
          );
        },
        placeholder: (context, url) {
          return ImgPlaceHolder(
            fontSize: fontSize,
          );
        },
      ),
    );
  }
}
