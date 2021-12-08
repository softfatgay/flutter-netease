import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/component/slivers.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/ui/home/model/categoryHotSellModule.dart';
import 'package:flutter_app/ui/router/router.dart';

class HomeCategoryHotSell extends StatelessWidget {
  final CategoryHotSellModule? categoryHotSellModule;

  const HomeCategoryHotSell({Key? key, this.categoryHotSellModule})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _categoryHotSell(context);
  }

  _categoryHotSell(BuildContext context) {
    if (categoryHotSellModule == null ||
        categoryHotSellModule!.categoryList == null ||
        categoryHotSellModule!.categoryList!.isEmpty) {
      return singleSliverWidget(Container());
    }
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      sliver: singleSliverWidget(
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(0, 5, 12, 12),
              child: Text(
                '${categoryHotSellModule!.title ?? ''}',
                style: t16black,
              ),
            ),
            Row(
              children: [
                _hotTopCell(context, 0),
                SizedBox(width: 4),
                _hotTopCell(context, 1),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _hotTopCell(BuildContext context, int index) {
    var categoryList = categoryHotSellModule!.categoryList ?? [];
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: () {
          _goHotList(index, context);
        },
        child: Container(
          decoration: BoxDecoration(
            color: index == 0 ? Color(0xFFF7F1DD) : Color(0xFFE4E8F0),
            borderRadius: BorderRadius.circular(3),
          ),
          padding: EdgeInsets.only(left: 20),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${categoryList[index].categoryName}',
                      style: t12blackBold,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      height: 2,
                      width: 30,
                      color: Colors.black,
                    )
                  ],
                ),
                flex: 2,
              ),
              Expanded(
                child: Container(
                  child: CachedNetworkImage(
                    imageUrl: '${categoryList[index].picUrl}',
                  ),
                ),
                flex: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _goHotList(int index, BuildContext context) {
    var categoryList = categoryHotSellModule!.categoryList ?? [];

    String categoryId = '0';
    var item = categoryList[index];
    var targetUrl = item.targetUrl;

    if (targetUrl != null && targetUrl.contains('categoryId')) {
      var parse = Uri.parse(targetUrl);
      var id = parse.queryParameters['categoryId'];
      if (id != null) {
        categoryId = id;
      }
    }
    Routers.push(Routers.hotList, context,
        {'categoryId': categoryId, 'name': item.categoryName});
  }
}
