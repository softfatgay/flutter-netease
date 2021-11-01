import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/ui/router/router.dart';
import 'package:flutter_app/utils/eventbus_constans.dart';
import 'package:flutter_app/utils/eventbus_utils.dart';

typedef void OnPress(int index);

class SliverCustomHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double collapsedHeight;
  final double expandedHeight;
  final double paddingTop;
  final Widget child;
  final String? title;
  final bool showBack;
  final List<String> tabs;
  final int? index;
  final OnPress? onPress;

  SliverCustomHeaderDelegate({
    this.onPress,
    this.index,
    this.tabs = const [],
    this.collapsedHeight = 46,
    this.expandedHeight = 0,
    this.paddingTop = 0,
    required this.child,
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

  Color tabSelectlColor(shrinkOffset) {
    final int alpha = (shrinkOffset / (this.maxExtent - this.minExtent) * 255)
        .clamp(0, 255)
        .toInt();
    return Color.fromARGB(alpha, 221, 26, 33);
  }

  Color searchColor(shrinkOffset) {
    final int alpha = (shrinkOffset / (this.maxExtent - this.minExtent) * 255)
        .clamp(0, 255)
        .toInt();
    return Color.fromARGB(alpha, 242, 244, 249);
  }

  Color tabNormalColor(shrinkOffset) {
    final int alpha = (shrinkOffset / (this.maxExtent - this.minExtent) * 255)
        .clamp(0, 255)
        .toInt();
    return Color.fromARGB(alpha, 51, 51, 51);
  }

  Color texthintColor(shrinkOffset) {
    final int alpha = (shrinkOffset / (this.maxExtent - this.minExtent) * 255)
        .clamp(0, 255)
        .toInt();
    return Color.fromARGB(alpha, 127, 127, 127);
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

  bool showTab(shrinkOffset) {
    if (shrinkOffset <= 50) {
      return false;
    } else {
      return true;
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
                  child: Stack(
                    children: [
                      _title(shrinkOffset, context),
                      if (showTab(shrinkOffset)) _tab(shrinkOffset),
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

  Positioned _title(double shrinkOffset, BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      top: 0,
      bottom: tabs.isNotEmpty ? 25 : 0,
      child: Container(
        height: double.infinity,
        alignment: Alignment.center,
        padding: EdgeInsets.only(right: title == null ? 15 : 50),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            if (showBack)
              GestureDetector(
                child: Container(
                  width: 50,
                  child: Image.asset(
                    'assets/images/back.png',
                    height: 26,
                    color: this.makeStickyHeaderTextColor(shrinkOffset, false),
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            Expanded(
              child: title == null
                  ? _searchTitle(context, shrinkOffset)
                  : Text(
                      '${this.title ?? ''}',
                      style: TextStyle(
                        fontSize: 16,
                        color:
                            this.makeStickyHeaderTextColor(shrinkOffset, false),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
            ),
          ],
        ),
      ),
    );
  }

  _tab(double shrinkOffset) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      height: 30,
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children:
              tabs.map<Widget>((item) => _tabItem(item, shrinkOffset)).toList(),
        ),
      ),
    );
  }

  _tabItem(String item, double shrinkOffset) {
    return GestureDetector(
      child: Container(
        height: double.infinity,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          border: index == tabs.indexOf(item)
              ? Border(
                  bottom: BorderSide(
                      color: tabSelectlColor(shrinkOffset), width: 2),
                )
              : null,
        ),
        child: Text(
          '$item',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 14,
              color: index == tabs.indexOf(item)
                  ? tabSelectlColor(shrinkOffset)
                  : tabNormalColor(shrinkOffset)),
        ),
      ),
      onTap: () {
        if (onPress != null) {
          onPress!(tabs.indexOf(item));
        }
      },
    );
  }

  _searchTitle(BuildContext context, double shrinkOffset) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: Row(
        children: [
          Expanded(child: _searchWidget(context, shrinkOffset)),
          GestureDetector(
            child: Container(
              margin: EdgeInsets.only(left: 15),
              child: Image.asset(
                'assets/images/ic_tab_cart_normal.png',
                width: 20,
                height: 22,
                color: tabNormalColor(shrinkOffset),
              ),
            ),
            onTap: () {
              Routers.push(
                  Routers.shoppingCart, context, {'from': Routers.goodDetail});
            },
          ),
          GestureDetector(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 7),
              margin: EdgeInsets.only(left: 15),
              child: Image.asset(
                'assets/images/good_detail_home.png',
                color: tabNormalColor(shrinkOffset),
              ),
            ),
            onTap: () {
              Navigator.of(context)
                  .popUntil(ModalRoute.withName(Routers.mainPage));
              HosEventBusUtils.fire(GO_HOME);
            },
          ),
        ],
      ),
    );
  }

  _searchWidget(BuildContext context, double shrinkOffset) {
    return GestureDetector(
      child: Container(
        height: double.infinity,
        margin: EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: searchColor(shrinkOffset),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/search_edit_icon.png',
              width: 14,
              height: 14,
              color: texthintColor(shrinkOffset),
            ),
            SizedBox(width: 5),
            Expanded(
              child: Container(
                child: Text(
                  "搜索商品",
                  style: TextStyle(
                      color: texthintColor(shrinkOffset),
                      fontSize: 12,
                      height: 1),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        Routers.push(Routers.search, context);
      },
    );
  }
}
