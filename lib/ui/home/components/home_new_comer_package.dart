import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/component/line_title.dart';
import 'package:flutter_app/component/net_image.dart';
import 'package:flutter_app/component/slivers.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/ui/home/model/indexActivityModule.dart';
import 'package:flutter_app/ui/router/router.dart';
import 'package:flutter_app/utils/constans.dart';

const double _widgetHeight = 200;

class HomeNewComerPackage extends StatelessWidget {
  final List<IndexActivityModule> indexActivityModule;

  const HomeNewComerPackage({Key? key, required this.indexActivityModule})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildWidget(context);
  }

  _buildWidget(BuildContext context) {
    return singleSliverWidget(Column(children: [
      LineTitle(title: '新人专享礼包'),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        height: _widgetHeight,
        width: double.infinity,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: _newPackage(context),
            ),
            Container(
              width: 2,
              color: Colors.white,
            ),
            Expanded(
              flex: 1,
              child: _activityModel(context),
            ),
          ],
        ),
      ),
      SizedBox(
        height: 10,
      )
    ]));
  }

  _activityModel(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: indexActivityModule.map((item) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              color: Color(0xFFF9DCC9),
            ),
            width: double.infinity / 2,
            height: (_widgetHeight - 2) /
                (indexActivityModule.isEmpty ? 1 : indexActivityModule.length),
            child: GestureDetector(
              child: Stack(
                children: [
                  Positioned(
                    right: 30,
                    top: 10,
                    bottom: 0,
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      child: CachedNetworkImage(
                        imageUrl: '${item.showPicUrl ?? ''}',
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${item.title ?? ''}',
                          style: t14blackBold,
                        ),
                        if (item.subTitle != null && item.subTitle!.isNotEmpty)
                          Text(
                            '${item.subTitle ?? ''}',
                            style: TextStyle(
                                fontSize: 12, color: Color(0xFF7F7F7F)),
                          ),
                        if (item.tag != null && item.tag!.isNotEmpty)
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 1, horizontal: 2),
                            decoration: BoxDecoration(
                                color: Color(0xFFCBB693),
                                borderRadius: BorderRadius.circular(2)),
                            child: Text(
                              '${item.tag}',
                              style: TextStyle(
                                  fontSize: 12, color: textWhite, height: 1),
                            ),
                          ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 20,
                    top: 10,
                    child: Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                          color: Color(0xFFf59524),
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${item.activityPrice ?? ''}',
                            style: num12White,
                          ),
                          Text(
                            '${item.originPrice ?? ''}',
                            style: TextStyle(
                                fontSize: 12,
                                height: 1,
                                color: textWhite,
                                decoration: TextDecoration.lineThrough,
                                fontFamily: 'DINAlternateBold'),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              onTap: () {
                if (item.targetUrl!.contains('pin/item/list')) {
                  Routers.push(Routers.mineItems, context, {'id': 2});
                } else {
                  _goWebview(context, item.targetUrl);
                }
              },
            ),
          );
        }).toList());
  }

  _newPackage(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFF6E5C4),
          borderRadius: BorderRadius.circular(3),
        ),
        height: double.infinity,
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(40, 60, 40, 20),
              child: NetImage(imageUrl: '$redPackageUrl', fit: BoxFit.cover),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
              child: Text(
                '新人专享礼包',
                style: t14blackBold,
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        _goWebview(context, '$redPackageHtml');
      },
    );
  }

  _goWebview(BuildContext context, String? url) {
    Routers.push(Routers.webView, context, {'url': url});
  }
}
