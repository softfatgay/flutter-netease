import 'package:flutter/material.dart';
import 'package:flutter_app/component/slivers.dart';
import 'package:flutter_app/model/itemListItem.dart';
import 'package:flutter_app/ui/sort/component/good_item_widget.dart';

const marginS = 8.0;

class GoodItems extends StatelessWidget {
  final List<ItemListItem>? dataList;

  const GoodItems({Key? key, this.dataList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildItems(dataList!);
  }

  _buildItems(List<ItemListItem> data) {
    return data.isEmpty
        ? singleSliverWidget(Container())
        : SliverPadding(
            padding:
                EdgeInsets.symmetric(horizontal: marginS, vertical: marginS),
            sliver: SliverGrid(
              delegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
                return GoodItemWidget(item: data[index]);
              }, childCount: data.length),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.58,
                mainAxisSpacing: 0,
                crossAxisSpacing: marginS,
              ),
            ),
          );
  }
}
