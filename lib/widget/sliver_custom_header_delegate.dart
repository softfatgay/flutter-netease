import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';

class SliverCustomHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double collapsedHeight;
  final double expandedHeight;
  final double paddingTop;
  final Widget child;
  final String title;
  final bool showBack;

  SliverCustomHeaderDelegate({
    this.collapsedHeight,
    this.expandedHeight,
    this.paddingTop,
    this.child,
    this.title,
    this.showBack = true,
  });

  @override
  // TODO: implement maxExtent
  double get maxExtent => this.expandedHeight;

  @override
  // TODO: implement minExtent
  double get minExtent => this.collapsedHeight + this.paddingTop;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    return true;
  }

  Color makeStickyHeaderBgColor(shrinkOffset) {
    final int alpha = (shrinkOffset / (this.maxExtent - this.minExtent) * 255)
        .clamp(0, 255)
        .toInt();
    return Color.fromARGB(alpha, 255, 255, 255);
  }

  Color makeStickyHeaderTextColor(shrinkOffset, isIcon) {
    if (shrinkOffset <= 50) {
      return isIcon ? Colors.white : Colors.transparent;
    } else {
      final int alpha = (shrinkOffset / (this.maxExtent - this.minExtent) * 255)
          .clamp(0, 255)
          .toInt();
      return Color.fromARGB(alpha, 0, 0, 0);
    }
  }

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(color: lineColor, blurRadius: 1, spreadRadius: 0.2)
        ],
      ),
      height: maxExtent,
      width: double.infinity,
      //堆叠布局,和frame差不多,一层一层堆叠
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          this.child,
          //定位,相当于绝对布局
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: Container(
              color: this.makeStickyHeaderBgColor(shrinkOffset),
              child: SafeArea(
                bottom: false,
                child: Container(
                  height: this.collapsedHeight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      showBack
                          ? InkResponse(
                              child: Container(
                                width: 50,
                                child: Image.asset(
                                  'assets/images/back.png',
                                  height: 25,
                                  color: this.makeStickyHeaderTextColor(
                                      shrinkOffset, false),
                                ),
                              ),
                              onTap: () {
                                Navigator.pop(context);
                              },
                            )
                          : Container(width: 20),
                      Expanded(
                          child: Text(
                        this.title,
                        style: TextStyle(
                          fontSize: 16,
                          color: this
                              .makeStickyHeaderTextColor(shrinkOffset, false),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
