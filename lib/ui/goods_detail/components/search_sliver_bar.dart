import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/ui/goods_detail/components/search_nav_bar.dart';
import 'package:flutter_app/ui/home/components/top_search.dart';
import 'package:flutter_app/ui/mine/model/userModel.dart';
import 'package:flutter_app/ui/router/router.dart';
import 'package:flutter_app/utils/user_config.dart';

typedef void PressIndex(int index);

class SearchSliverBar extends SliverPersistentHeaderDelegate {
  final PressIndex pressIndex;
  final int index;
  final double collapsedHeight;
  final double expandedHeight;
  final double paddingTop;
  final Widget child;
  final String title;
  final UserModel userInfo;
  final bool showBack;
  final bool descSorted;

  SearchSliverBar({
    this.index = 0,
    this.collapsedHeight,
    this.pressIndex,
    this.expandedHeight,
    this.paddingTop,
    this.child,
    this.title,
    this.userInfo,
    this.showBack = false,
    this.descSorted,
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

  double verOffset = 30.0;

  Color logoColor(shrinkOffset) {
    if (shrinkOffset <= verOffset) {
      final int alpha = (shrinkOffset / verOffset * 255).clamp(0, 255).toInt();
      return Color.fromARGB(alpha, 255, 255, 255);
    } else {
      return Colors.white;
    }
  }

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // TODO: implement build
    var paddingTop = MediaQuery.of(context).padding.top;
    var isShowLogo = true;
    var searchOffsetR = 0.0;
    if (shrinkOffset < verOffset) {
      if (shrinkOffset < 10) {
        isShowLogo = true;
      } else {
        isShowLogo = false;
      }
      searchOffsetR = shrinkOffset * 3.3;
    } else {
      searchOffsetR = verOffset * 3.3;
      isShowLogo = false;
    }

    return Container(
      decoration: BoxDecoration(
          color: backWhite,
          border: Border(
            bottom: BorderSide(color: lineColor, width: 0.5),
          )),
      height: maxExtent,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          //定位,相当于绝对布局
          Positioned(
            child: SearchNavBar(
                height: collapsedHeight,
                index: index,
                pressIndex: pressIndex,
                descSorted: descSorted),
            top: paddingTop,
          ),
        ],
      ),
    );
  }
}
