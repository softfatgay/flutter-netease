import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';

typedef void ItemClick(int index);

class VerticalSliderText extends StatelessWidget {
  final List<String> dateList;
  final ItemClick itemClick;
  final BoxDecoration decoration;
  final double width;

  const VerticalSliderText(
      {Key key, this.dateList, this.itemClick, this.decoration, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: decoration,
      width: width ?? MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: CarouselSlider(
        options: CarouselOptions(
          height: 25,
          aspectRatio: 1.0,
          scrollDirection: Axis.vertical,
          autoPlay: dateList.length > 1 ? true : false,
        ),
        items: itemList(dateList),
      ),
    );
  }

  itemList(List<String> dateList) {
    return dateList.map((item) {
      return GestureDetector(
        child: Center(
          child: Text(
            '$item',
            style: t14white,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        onTap: () {
          if (itemClick != null) {
            itemClick(dateList.indexOf(item));
          }
        },
      );
    }).toList();
  }
}
