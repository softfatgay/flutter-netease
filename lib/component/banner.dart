import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/component/round_net_image.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/ui/router/router.dart';

typedef void OnTap(int value);
typedef void OnIndexChanged(int index);

class BannerCacheImg extends StatelessWidget {
  final List? imageList;
  final double? height;
  final double corner;
  final int autoplayDelay;
  final bool autoplay;
  final Axis scrollDirection;
  final OnTap? onTap;
  final BoxFit boxFit;
  final String localImagePath;
  final OnIndexChanged? onIndexChanged;

  BannerCacheImg(
      {this.imageList,
      this.height = 280,
      this.autoplayDelay = 4000,
      this.autoplay = true,
      this.scrollDirection = Axis.horizontal,
      this.onTap,
      this.boxFit = BoxFit.cover,
      this.localImagePath = 'assets/images/no_banner.png',
      this.onIndexChanged,
      this.corner = 0});

  @override
  Widget build(BuildContext context) {
    return (imageList == null || imageList!.isEmpty)
        ? Container(
            child: Image.asset(
              localImagePath,
              fit: boxFit,
              height: height,
            ),
          )
        : _buildSwiper();
  }

  _buildSwiper() {
    return CarouselSlider(
      items: imageList!.map<Widget>((e) {
        return GestureDetector(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(corner), color: backWhite),
            child: RoundNetImage(
              url: '$e',
              corner: corner,
              height: height,
              fit: BoxFit.cover,
            ),
          ),
          onTap: () {
            onTap!(imageList!.indexOf(e));
          },
        );
      }).toList(),
      options: CarouselOptions(
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 5),
          viewportFraction: 1.0,
          height: height,
          // enlargeCenterPage: true,
          onPageChanged: (index, reason) {
            // setState(() {});
          }),
    );
  }
}
