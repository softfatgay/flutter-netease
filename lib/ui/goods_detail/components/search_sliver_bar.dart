import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
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
          border: Border(bottom: BorderSide(color: lineColor, width: 1))),
      height: maxExtent,
      width: double.infinity,
      //堆叠布局,和frame差不多,一层一层堆叠
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          //定位,相当于绝对布局
          Positioned(
            child: _buildTops(context, shrinkOffset, isShowLogo),
            top: paddingTop,
          ),
        ],
      ),
    );
  }

  _buildTops(BuildContext context, double shrinkOffset, bool isShowLogo) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: collapsedHeight,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: GestureDetector(
              child: Container(
                color: backWhite,
                margin: EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.center,
                child: Text(
                  '综合',
                  style: index == 0 ? t14red : t14black,
                ),
              ),
              onTap: () {
                if (pressIndex != null) {
                  pressIndex(0);
                }
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: GestureDetector(
              child: Container(
                color: backWhite,
                margin: EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '价格',
                      style: index == 1 ? t14red : t14black,
                    ),
                    descSorted == null
                        ? _dftSort()
                        : (descSorted ? _dftSortDown() : _dftSortUp())
                  ],
                ),
              ),
              onTap: () {
                if (pressIndex != null) {
                  pressIndex(1);
                }
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: GestureDetector(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                color: backWhite,
                alignment: Alignment.center,
                child: Text(
                  '分类',
                  style: index == 2 ? t14red : t14black,
                ),
              ),
              onTap: () {
                if (pressIndex != null) {
                  pressIndex(2);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

_dftSort() => Image.asset('assets/images/sort_dft.png', width: 14);

_dftSortUp() => Image.asset('assets/images/sort_up.png', width: 14);

_dftSortDown() => Image.asset('assets/images/sort_down.png', width: 14);
