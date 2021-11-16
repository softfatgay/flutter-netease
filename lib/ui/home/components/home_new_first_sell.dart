import 'package:flutter/material.dart';
import 'package:flutter_app/component/net_image.dart';
import 'package:flutter_app/component/round_net_image.dart';
import 'package:flutter_app/component/slivers.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/ui/home/model/newItemModel.dart';
import 'package:flutter_app/ui/router/router.dart';

class HomeNewFirstSell extends StatelessWidget {
  final List<NewItemModel> newItemList;

  const HomeNewFirstSell({Key? key, required this.newItemList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildWidget(context);
  }

  _buildWidget(BuildContext context) {
    if (newItemList.isEmpty) return singleSliverWidget(Container());
    return SliverPadding(
        padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
        sliver: SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              childAspectRatio: 0.58),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              var item = newItemList[index];
              Widget widget = Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        child: RoundNetImage(
                          url: item.scenePicUrl,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Text(
                        "${item.simpleDesc}",
                        style: t12black,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      "¥${item.retailPrice}",
                      style: t14red,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      constraints: BoxConstraints(minHeight: 18),
                      child: _newItemsTags(item),
                    )
                  ],
                ),
              );
              return Routers.link(
                  widget, Routers.goodDetail, context, {'id': item.id});
            },
            childCount: newItemList.length > 6 ? 6 : newItemList.length,
          ),
        ));
  }

  _newItemsTags(NewItemModel item) {
    var itemTagList = item.itemTagList;
    if (itemTagList != null && itemTagList.length > 1) {
      var itemD = itemTagList[itemTagList.length - 1];
      return Container(
        padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            border: Border.all(width: 0.5, color: redColor)),
        child: Text(
          '${itemD.name}',
          style: t12red,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      );
    } else {
      return Container();
    }
  }
}
