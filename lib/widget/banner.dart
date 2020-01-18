import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

typedef void OnTap(int value);

class BannerCacheImg extends StatelessWidget {
  final List imageList;
  final double height;
  final int autoplayDelay;
  final bool autoplay;
  final Axis scrollDirection;
  final OnTap onTap;
  final BoxFit boxFit;
  final SwiperController controller;
  final String localImagePath;

  BannerCacheImg(
      {this.imageList,
      this.height = 200,
      this.autoplayDelay = 4000,
      this.autoplay = true,
      this.scrollDirection = Axis.horizontal,
      this.onTap,
      this.boxFit = BoxFit.cover,
      this.localImagePath = 'assets/images/no_banner.png',
      this.controller});

  @override
  Widget build(BuildContext context) {
    return (imageList == null || imageList.isEmpty)
        ? Container(
            child: Image.asset(
              localImagePath,
              fit: boxFit,
              height: height,
            ),
          )
        : Swiper(
            itemCount: imageList.length,
            itemBuilder: (BuildContext context, int index) {
              return CachedNetworkImage(
                imageUrl: imageList[index],
                fit: boxFit,
              );
            },
            containerHeight: height,
            controller: controller,
            scrollDirection: scrollDirection,
            autoplay: autoplay,
            autoplayDelay: autoplayDelay,
            onTap: (index) => onTap(index),
          );
  }
}
