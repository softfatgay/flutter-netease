import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/model/saturdayBuyModel.dart';
import 'package:flutter_app/ui/router/router.dart';
import 'package:flutter_app/widget/top_round_net_image.dart';

class StuBuyListItemWidget extends StatelessWidget {
  final Result item;

  const StuBuyListItemWidget({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildItem(context);
  }

  _buildItem(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(bottom: 6),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(2)),
        child: Row(
          children: [
            _image(item),
            _detailDes(item),
          ],
        ),
      ),
      onTap: () {
        Routers.push(
          Routers.webView,
          context,
          {
            'url':
                'https://m.you.163.com/pin/static/index.html#/pages/pin/detail/goods?pinBaseId=${item.id}'
          },
        );
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
          TopRoundNetImage(
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
        height: 130,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(6, 6, 6, 0),
              child: Text(
                item.title,
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
                        item.recentUsers == null ? '' : item.recentUsers[0],
                        width: 16,
                        height: 16,
                        fit: BoxFit.cover,
                      )),
                      SizedBox(width: 2),
                      ClipOval(
                          child: Image.network(
                        item.recentUsers == null ? '' : item.recentUsers[1],
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
            _price()
          ],
        ),
      ),
    );
  }

  _price() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
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
                    '¥${item.isRefundPay ? '0' : '${item.price}'}',
                    style: t20whitebold,
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
