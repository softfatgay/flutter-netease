import 'package:flutter/cupertino.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/model/itemTagListItem.dart';

class TitleTagsWidget extends StatelessWidget {
  final List<ItemTagListItem> itemTagListGood;

  const TitleTagsWidget({Key key, this.itemTagListGood}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildTitleTags();
  }

  _buildTitleTags() {
    return itemTagListGood == null || itemTagListGood.isEmpty
        ? Container()
        : Container(
            padding: EdgeInsets.fromLTRB(10, 15, 10, 0),
            color: backWhite,
            child: Row(
              children: itemTagListGood
                  .map<Widget>((item) => Container(
                        margin: EdgeInsets.only(right: 5),
                        padding:
                            EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: redColor, width: 1)),
                        child: Text(
                          item.name,
                          style: t10red,
                        ),
                      ))
                  .toList(),
            ),
          );
  }
}
