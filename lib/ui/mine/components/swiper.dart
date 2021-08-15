import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

typedef void OnTap(int index);

class SwiperView extends StatefulWidget {
  final List bannerImg;
  final OnTap onTap;
  final double height;

  @override
  _SwiperViewState createState() => _SwiperViewState();

  SwiperView(this.bannerImg, {this.onTap, this.height = 180});
}

class _SwiperViewState extends State<SwiperView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[firstSwiperView()],
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget firstSwiperView() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: widget.height,
      child: Swiper(
        itemCount: widget.bannerImg.length,
        itemBuilder: (BuildContext context, int index) =>
            (widget.bannerImg[index]),
        pagination: SwiperPagination(
          alignment: Alignment.bottomCenter,
          margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
          builder: DotSwiperPaginationBuilder(
              color: Colors.transparent,
              size: 8,
              activeColor: Colors.transparent),
        ),
        controller: SwiperController(),
        scrollDirection: Axis.horizontal,
        autoplay: widget.bannerImg.length > 1 ? true : false,
        autoplayDelay: 5000,
        onTap: (index) => {
          if (widget.onTap != null) {widget.onTap(index)}
        },
      ),
    );
  }
}
