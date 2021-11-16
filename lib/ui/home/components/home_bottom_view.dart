import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/component/slivers.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/ui/home/model/sceneLightShoppingGuideModule.dart';
import 'package:flutter_app/ui/router/router.dart';

class HomeBottomView extends StatelessWidget {
  final List<SceneLightShoppingGuideModule> dataList;

  const HomeBottomView({Key? key, required this.dataList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildWidget(context);
  }

  _buildWidget(BuildContext context) {
    if (dataList.isEmpty) return singleSliverWidget(Container());
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 15),
      sliver: singleSliverWidget(Row(
        children: dataList.map((item) {
          Widget widget = Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                _goWebview(context, item.styleItem!.targetUrl);
              },
              child: Container(
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
                            '${item.styleItem!.title ?? ''}',
                            style: t14blackBold,
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            '${item.styleItem!.desc ?? ''}',
                            style: dataList.indexOf(item) % 2 == 1
                                ? t12warmingRed
                                : t12violet,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Row(
                        children: [
                          Expanded(
                            child: CachedNetworkImage(
                              imageUrl: '${item.styleItem!.picUrlList![0]}',
                            ),
                          ),
                          Expanded(
                            child: CachedNetworkImage(
                              imageUrl: '${item.styleItem!.picUrlList![1]}',
                            ),
                          ),
                        ],
                      ),
                    )
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

  _goWebview(BuildContext context, String? url) {
    Routers.push(Routers.webView, context, {'url': url});
  }
}
