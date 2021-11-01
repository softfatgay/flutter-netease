import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/component/round_net_image.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';

typedef void OnPress(int index);
enum IndicatorType { num, line, none }

class IndicatorBanner extends StatefulWidget {
  final double height;
  final List<String> dataList;
  final BoxFit fit;
  final OnPress onPress;
  final EdgeInsetsGeometry margin;
  final Color backGroundColor;
  final double corner;
  final double indicatorWidth;
  final IndicatorType indicatorType;

  const IndicatorBanner({
    Key? key,
    this.height = 160,
    this.dataList = const [],
    this.fit = BoxFit.contain,
    this.backGroundColor = backColor,
    this.corner = 6,
    this.indicatorWidth = 20,
    this.indicatorType = IndicatorType.line,
    this.margin = const EdgeInsets.symmetric(horizontal: 0),
    required this.onPress,
  }) : super(key: key);

  @override
  _IndicatorBannerState createState() => _IndicatorBannerState();
}

class _IndicatorBannerState extends State<IndicatorBanner> {
  int _currentIndex = 0;
  List<String> _dataList = [];

  @override
  void initState() {
    // TODO: implement initState
    _dataList = widget.dataList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildWidget();
  }

  Widget _buildWidget() {
    return Container(
      child: Stack(
        children: [
          CarouselSlider.builder(
            options: CarouselOptions(
                height: widget.height,
                autoPlay: widget.dataList.length > 1 ? true : false,
                enlargeCenterPage: false,
                viewportFraction: 1,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                }),
            itemCount: _dataList.length,
            itemBuilder: (context, index, realIdx) {
              return GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                    color: backGroundColor,
                    borderRadius: BorderRadius.circular(widget.corner),
                  ),
                  margin: widget.margin,
                  child: RoundNetImage(
                    url: _dataList[index],
                    width: double.infinity,
                    height: widget.height,
                    fit: widget.fit,
                    corner: widget.corner,
                  ),
                ),
                onTap: () {
                  widget.onPress(index);
                },
              );
            },
          ),
          if (widget.dataList.length > 1)
            if (widget.indicatorType != IndicatorType.none)
              widget.indicatorType == IndicatorType.line
                  ? Positioned(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: _dataList.asMap().entries.map((entry) {
                          return Container(
                            width: widget.indicatorWidth,
                            height: 2.0,
                            margin: EdgeInsets.symmetric(horizontal: 3.0),
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: _currentIndex == entry.key
                                    ? backWhite
                                    : Color(0x80F2F4F9)),
                          );
                        }).toList(),
                      ),
                      bottom: 10,
                      left: 0,
                      right: 0,
                    )
                  : Positioned(
                      bottom: 10,
                      right: 20,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 2),
                        decoration: BoxDecoration(
                            color: Color(0xFFFFFFFF),
                            borderRadius: BorderRadius.circular(2)),
                        child: Text(
                          '$_currentIndex/${_dataList.length}',
                          style: t12black,
                        ),
                      ),
                    ),
        ],
      ),
    );
  }
}
