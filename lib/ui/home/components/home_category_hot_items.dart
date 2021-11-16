import 'package:flutter/material.dart';
import 'package:flutter_app/component/net_image.dart';
import 'package:flutter_app/component/slivers.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/model/category.dart';
import 'package:flutter_app/ui/home/model/categoryHotSellModule.dart';
import 'package:flutter_app/ui/router/router.dart';

class HomeCategoryHotItems extends StatelessWidget {
  final CategoryHotSellModule? categoryHotSellModule;

  const HomeCategoryHotItems({Key? key, this.categoryHotSellModule})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildWidget(context);
  }

  _buildWidget(BuildContext context) {
    if (categoryHotSellModule == null ||
        categoryHotSellModule!.categoryList == null ||
        categoryHotSellModule!.categoryList!.length < 2) {
      return singleSliverWidget(Container());
    }
    var categoryList = categoryHotSellModule!.categoryList ?? [];
    var sublist = categoryList.sublist(2, categoryList.length);
    return SliverPadding(
      padding: EdgeInsets.only(left: 10, right: 10, bottom: 15),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4, crossAxisSpacing: 4, mainAxisSpacing: 4),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                _goHotList(context, sublist[index]);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFF2F2F2),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Column(
                  children: <Widget>[
                    Text(
                      sublist[index].categoryName!,
                      style: TextStyle(
                          color: textBlack,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: NetImage(
                        imageUrl: sublist[index].picUrl,
                        fontSize: 14,
                      ),
                    )
                  ],
                ),
              ),
            );
          },
          childCount: sublist.length,
        ),
      ),
    );
  }

  void _goHotList(BuildContext context, Category item) {
    String categoryId = '0';
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
