import 'package:flutter/material.dart';
import 'package:flutter_app/component/net_image.dart';
import 'package:flutter_app/component/round_net_image.dart';
import 'package:flutter_app/component/slivers.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/ui/home/model/flashSaleModuleItem.dart';
import 'package:flutter_app/ui/router/router.dart';

class HomeFlashSaleItem extends StatelessWidget {
  final List<FlashSaleModuleItem> flashSaleModuleItemList;

  const HomeFlashSaleItem({
    Key? key,
    this.flashSaleModuleItemList = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildWidget(context);
  }

  _buildWidget(BuildContext context) {
    if (flashSaleModuleItemList.isEmpty) {
      return singleSliverWidget(Container());
    }
    return SliverPadding(
      padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            childAspectRatio: 0.9),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            var item = flashSaleModuleItemList[index];
            Widget widget = Column(
              children: <Widget>[
                Expanded(
                  child: RoundNetImage(
                    url: flashSaleModuleItemList[index].picUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    backColor: backColor,
                    corner: 4,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "¥${item.activityPrice}",
                        style: t14red,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "¥${item.originPrice}",
                        style: TextStyle(
                          fontSize: 12,
                          color: textGrey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      )
                    ],
                  ),
                )
              ],
            );
            return Routers.link(
                widget, Routers.goodDetail, context, {'id': item.itemId});
          },
          childCount: flashSaleModuleItemList.length,
        ),
      ),
    );
  }
}
