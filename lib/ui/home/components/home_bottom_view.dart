import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/component/slivers.dart';
import 'package:flutter_app/ui/home/model/sceneLightShoppingGuideModule.dart';
import 'package:flutter_app/ui/home/model/styleItem.dart';
import 'package:flutter_app/ui/router/router.dart';
import 'package:flutter_app/utils/color_util.dart';

class HomeBottomView extends StatelessWidget {
  final List<SceneLightShoppingGuideModule> dataList;

  const HomeBottomView({Key? key, required this.dataList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildWidget(context);
  }

  _buildWidget(BuildContext context) {
    if (dataList.isEmpty) return singleSliverWidget(Container());

    List<StyleItem?> data = [];
    dataList.forEach((element) {
      if (element.styleItem != null) data.add(element.styleItem);
      if (element.styleBanner != null) data.add(element.styleBanner);
    });

    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 15),
      sliver: singleSliverWidget(Row(
        children: data.map((item) {
          Widget widget = Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                _goWebView(context, item!.targetUrl);
              },
              child: Container(
                height: 130,
                decoration: BoxDecoration(
                    color: Color(0xFFF2F2F2),
                    borderRadius: BorderRadius.circular(3)),
                margin: EdgeInsets.symmetric(horizontal: 2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(15, 15, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${item!.title ?? ''}',
                            style: TextStyle(
                                color: HexColor.fromHex(
                                    item.titleColor ?? '333333'),
                                fontSize: 14),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Text('${item.desc ?? ''}',
                              style: TextStyle(
                                  color: HexColor.fromHex(
                                      item.descColor ?? '999999'),
                                  fontSize: 12)),
                        ],
                      ),
                    ),
                    Expanded(
                      child: item.picUrlList == null
                          ? CachedNetworkImage(imageUrl: '${item.picUrl}')
                          : Row(
                              children: item.picUrlList!
                                  .map(
                                    (element) => Expanded(
                                      child: CachedNetworkImage(
                                        imageUrl: '$element',
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          );
          return widget;
        }).toList(),
      )),
    );
  }

  _goWebView(BuildContext context, String? url) {
    Routers.push(Routers.webView, context, {'url': url});
  }
}
