import 'package:flutter/material.dart';
import 'package:flutter_app/component/round_net_image.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/model/saturdayBuyModel.dart';
import 'package:flutter_app/ui/router/router.dart';

class StuBuyListItemWidget extends StatelessWidget {
  final Result? item;

  const StuBuyListItemWidget({Key? key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildItem(context);
  }

  _buildItem(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(4)),
        child: Row(
          children: [
            _image(item!),
            _detailDes(item!),
          ],
        ),
      ),
      onTap: () {
        Routers.push(Routers.pinPage, context,
            {'itemId': item!.itemId, 'baseId': item!.id});
      },
    );
  }

  _image(Result item) {
    return Container(
      height: 130,
      width: 130,
      alignment: Alignment.topCenter,
      child: Stack(
        children: [
          RoundNetImage(
            height: 130,
            width: 130,
            corner: 4,
            url: item.picUrl,
          ),
          Container(
            margin: EdgeInsets.only(top: 5),
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color(0xFFF53C46),
                    Color(0xFFEB7829),
                  ],
                ),
                borderRadius:
                    BorderRadius.horizontal(right: Radius.circular(10))),
            child: Text(
              '免单团',
              style: t12white,
            ),
          )
        ],
      ),
    );
  }

  _detailDes(Result item) {
    return Expanded(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 6),
              child: Text(
                item.title!,
                maxLines: 2,
                style: t14blackBold,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                  child: Text(
                    '${item.userNum}人团',
                    style: TextStyle(fontSize: 12, color: textGrey),
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      ClipOval(
                          child: Image.network(
                        item.recentUsers == null ? '' : item.recentUsers![0],
                        width: 16,
                        height: 16,
                        fit: BoxFit.cover,
                      )),
                      SizedBox(width: 2),
                      ClipOval(
                          child: Image.network(
                        item.recentUsers == null ? '' : item.recentUsers![1],
                        width: 16,
                        height: 16,
                        fit: BoxFit.cover,
                      )),
                      Expanded(
                        child: Text(
                          '${item.joinUsers}人已拼',
                          style: TextStyle(fontSize: 12, color: textGrey),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            _priceDec(),
            _price()
          ],
        ),
      ),
    );
  }

  _priceDec() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 6),
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 1),
        decoration: BoxDecoration(
          color: Color(0xFFFFA543),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          '成团立返${item!.price}元余额',
          style: t12white,
        ),
      ),
    );
  }

  _price() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: backRed,
      ),
      child: Row(
        children: [
          Expanded(
            child: Row(
              textBaseline: TextBaseline.alphabetic,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              children: [
                Text(
                  '折合 ',
                  style: t10white,
                ),
                Expanded(
                  child: Text(
                    '¥${item!.isRefundPay! ? '0' : '${item!.price}'}',
                    style: num20WhiteBold,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '去开团',
            style: t14white,
          )
        ],
      ),
    );
  }
}
