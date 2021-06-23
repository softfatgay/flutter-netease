import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/model/itemListItem.dart';
import 'package:flutter_app/utils/router.dart';
import 'package:flutter_app/widget/round_net_image.dart';

class HotListItem extends StatelessWidget {
  final ItemListItem item;
  final int index;

  const HotListItem({Key key, this.item, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildItem(context);
  }

  Widget _buildItem(BuildContext context) {
    Widget widget = Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 120,
                child: Row(
                  children: [
                    Container(
                      height: 120,
                      width: 120,
                      child: RoundNetImage(
                        url: item.scenePicUrl,
                      ),
                    ),
                    _buildItemInfo(),
                  ],
                ),
              ),
              _bottomLink(),
            ],
          ),
          Container(
            height: 20,
            width: 20,
            margin: EdgeInsets.all(5),
            alignment: Alignment.center,
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Color(0xFFD2D3D2)),
            child: Text(
              '${index + 1}',
              style: t14white,
            ),
          )
        ],
      ),
    );
    return Routers.link(
        widget, Routers.goodDetailTag, context, {'id': item.id});
  }

  _bottomLink() {
    return item.hotSaleListBottomInfo == null
        ? Container()
        : Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            margin: EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
                color: Color(0xFFF6F6F6),
                borderRadius: BorderRadius.circular(20)),
            child: Row(
              children: [
                ClipOval(
                  child: Image.network(
                    '${item.hotSaleListBottomInfo.iconUrl ?? ''}',
                    height: 20,
                    width: 20,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 5),
                Expanded(
                  child: Text(
                    '${item.hotSaleListBottomInfo.content ?? ''}',
                    style: t12grey,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: textGrey,
                ),
              ],
            ),
          );
  }

  _buildItemInfo() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            (item.promTag == null || item.promTag == '')
                ? Container()
                : Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                        border: Border.all(color: redColor, width: 1),
                        borderRadius: BorderRadius.circular(15)),
                    child: Text(
                      '${item.promTag}',
                      style: t12red,
                    ),
                  ),
            Container(
              margin: EdgeInsets.only(top: 6),
              child: Text(
                '${item.name}',
                style: TextStyle(
                    color: textBlack,
                    fontSize: 16,
                    height: 1.1,
                    fontWeight: FontWeight.bold),
              ),
            ),
            item.goodCmtRate == null
                ? Container()
                : Container(
                    margin: EdgeInsets.only(top: 6),
                    child: Text('${item.goodCmtRate}好评率'),
                  ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                      child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '¥${item.retailPrice}',
                        style: TextStyle(
                            color: textRed,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      (item.counterPrice == item.retailPrice ||
                              item.counterPrice == 0)
                          ? Container()
                          : Text(
                              '¥${item.counterPrice}',
                              style: TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  color: textGrey),
                            )
                    ],
                  )),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    decoration: BoxDecoration(
                        color: redColor,
                        borderRadius: BorderRadius.circular(15)),
                    child: Text(
                      '马上抢',
                      style: t16whiteblod,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
