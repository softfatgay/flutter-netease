import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/ui/home/components/top_search.dart';
import 'package:flutter_app/ui/mine/model/userModel.dart';
import 'package:flutter_app/utils/router.dart';
import 'package:flutter_app/utils/user_config.dart';

class HomeHeader extends SliverPersistentHeaderDelegate {
  final double collapsedHeight;
  final double expandedHeight;
  final double paddingTop;
  final Widget child;
  final String title;
  final UserModel userInfo;
  final bool showBack;

  HomeHeader({
    this.collapsedHeight,
    this.expandedHeight,
    this.paddingTop,
    this.child,
    this.title,
    this.userInfo,
    this.showBack = false,
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
      print('color-------$alpha');
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
      decoration: BoxDecoration(color: backWhite),
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
          Positioned(
            child: GestureDetector(
              child: _searchWidget(),
              onTap: () {
                Routers.push(Routers.search, context, {'id': "零食"});
              },
            ),
            bottom: 0,
            left: 0,
            right: searchOffsetR,
          ),
        ],
      ),
    );
  }

  _searchWidget() {
    return Container(
      height: 50,
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Container(
        padding: EdgeInsets.only(left: 8),
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: backRed),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/search_edit_icon.png',
              width: 14,
              height: 14,
            ),
            SizedBox(width: 5),
            Expanded(
              child: Text(
                "搜索商品，共30000+款好物",
                style: t12grey,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Container(
              height: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: backRed,
                borderRadius: BorderRadius.circular(20),
              ),
              alignment: Alignment.center,
              child: Text(
                '搜索',
                style: t14whiteBold,
              ),
            )
          ],
        ),
      ),
    );
  }

  _buildTops(BuildContext context, double shrinkOffset, bool isShowLogo) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 10,
            bottom: 0,
            child: Container(
              alignment: Alignment.center,
              child: Stack(
                children: [
                  Positioned(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/ic_tab_home_normal.png',
                          height: 22,
                          width: 22,
                        ),
                        SizedBox(width: 5),
                        Image.asset(
                          'assets/images/logo_text.png',
                          height: 20,
                          // color: Colors.white,
                        ),
                      ],
                    ),
                    top: 0,
                    bottom: 0,
                  ),
                  Container(
                    width: 200,
                    height: 50,
                    color: logoColor(shrinkOffset),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            right: 10,
            top: 0,
            bottom: 0,
            child: Container(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/qr_scan.png',
                            width: 20,
                            height: 20,
                            color: Color(0xFF7D7D7D),
                          ),
                          Text(
                            '扫一扫',
                            style: t10black,
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      Routers.push(Routers.qrScanPage, context);
                    },
                  ),
                  SizedBox(width: 20),
                  GestureDetector(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/ic_tab_cart_normal.png',
                            width: 20,
                            height: 22,
                            color: Color(0xFF7D7D7D),
                          ),
                          Text(
                            '购物车',
                            style: t10black,
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      Routers.push(
                          Routers.shoppingCart, context, {'from': 'detail'});
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
