import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/component/round_net_image.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/model/itemListItem.dart';
import 'package:flutter_app/ui/router/router.dart';

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
      margin: EdgeInsets.only(bottom: 10),
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
                        url: item.listPicUrl,
                      ),
                    ),
                    _buildItemInfo(),
                  ],
                ),
              ),
              _bottomLink(),
            ],
          ),
          _sortIcon()
        ],
      ),
    );
    return Routers.link(widget, Routers.goodDetail, context, {'id': item.id});
  }

  _sortIcon() {
    if (index == 0) {
      return CachedNetworkImage(
          width: 25,
          height: 25,
          imageUrl:
              'https://yanxuan.nosdn.127.net/f1566323de5e538cfd1c1845685285f2.png');
    } else if (index == 1) {
      return CachedNetworkImage(
          width: 25,
          height: 25,
          imageUrl:
              'https://yanxuan.nosdn.127.net/5d91018eda410767b27ec57b8bf9b929.png');
    } else if (index == 2) {
      return CachedNetworkImage(
          width: 25,
          height: 25,
          imageUrl:
              'https://yanxuan.nosdn.127.net/89748e835b8ffb8a328d945bc2b9de93.png');
    } else {
      return Container(
        height: 20,
        width: 20,
        margin: EdgeInsets.all(4),
        alignment: Alignment.center,
        decoration:
            BoxDecoration(shape: BoxShape.circle, color: Color(0xFFD2D3D2)),
        child: Text(
          '${index + 1}',
          style: t14white,
        ),
      );
    }
  }

  _bottomLink() {
    return item.hotSaleListBottomInfo == null
        ? Container()
        : Container(
            height: 20,
            padding: EdgeInsets.symmetric(horizontal: 2),
            margin: EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
                color: Color(0xFFF6F6F6),
                borderRadius: BorderRadius.circular(20)),
            child: Row(
              children: [
                ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: '${item.hotSaleListBottomInfo.iconUrl ?? ''}',
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
                )
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
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      '${item.promTag}',
                      style: t12red,
                    ),
                  ),
            Container(
              margin: EdgeInsets.only(top: 6),
              decoration: BoxDecoration(),
              child: Text(
                '${item.name}',
                style: TextStyle(
                    color: textBlack,
                    fontSize: 16,
                    height: 1.1,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 6),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ///好评率
                _commondRate(),
                Expanded(child: _tags()),
              ],
            ),
            _buildPrice()
          ],
        ),
      ),
    );
  }

  _buildPrice() {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '¥${item.retailPrice}',
                  style: t18redBold,
                ),
                (item.counterPrice == item.retailPrice ||
                        item.counterPrice == 0)
                    ? Container()
                    : Text(
                        '¥${item.counterPrice}',
                        style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: textGrey,
                            fontSize: 14),
                      )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            decoration: BoxDecoration(
              color: redColor,
              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color(0xFFFE5555),
                  Color(0xFFCF2524),
                ],
              ),
            ),
            child: Row(
              children: [
                Text(
                  '马上抢',
                  style: t14whiteBold,
                ),
                Icon(
                  Icons.keyboard_arrow_right,
                  color: backWhite,
                  size: 16,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  _commondRate() {
    return item.goodCmtRate == null
        ? Container()
        : Container(
            padding: EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color(0xFFCF2524),
                    Color(0xFFFFA77E),
                  ],
                ),
                borderRadius: BorderRadius.circular(8)),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    color: backWhite,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Image.asset(
                    'assets/images/zan.png',
                    width: 8,
                    height: 8,
                  ),
                ),
                Text(
                  '${item.goodCmtRate}好评率',
                  style: t12white,
                ),
              ],
            ),
          );
  }

  _tags() {
    var itemTagList = item.itemTagList;
    return itemTagList == null
        ? Container()
        : Row(
            children: itemTagList
                .map((e) => Container(
                      margin: EdgeInsets.only(left: 5),
                      padding: EdgeInsets.symmetric(horizontal: 3),
                      decoration: BoxDecoration(
                          color: backLightRed,
                          borderRadius: BorderRadius.circular(8)),
                      child: Text(
                        '${e.name}',
                        style: t12red,
                      ),
                    ))
                .toList(),
          );
  }
}
