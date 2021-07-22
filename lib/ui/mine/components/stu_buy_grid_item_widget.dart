import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/model/saturdayBuyModel.dart';
import 'package:flutter_app/utils/router.dart';
import 'package:flutter_app/widget/top_round_net_image.dart';

class StuBuyGridItemWidget extends StatelessWidget {
  final Result item;

  const StuBuyGridItemWidget({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildItem(context);
  }

  _buildItem(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(2)),
        child: _detailDes(item),
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

  Expanded _detailDes(Result item) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _image(item),
          Container(
            padding: EdgeInsets.only(left: 5),
            child: RichText(
              text: TextSpan(
                style: t14black,
                children: [
                  TextSpan(
                      text: '${item.isRefundPay ? '返¥${item.price}余额 ' : ''}',
                      style: t14red),
                  TextSpan(text: '${item.title}')
                ],
              ),
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
          _price(),
          SizedBox(height: 5)
        ],
      ),
    );
  }

  Row noUse(Result item) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: 6,
            ),
            Text(
              "¥${item.price}",
              style: TextStyle(
                  color: textRed, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 3,
            ),
            Expanded(
                child: Text(
              "¥${item.originPrice}",
              style: TextStyle(
                  color: Colors.grey,
                  decoration: TextDecoration.lineThrough,
                  fontSize: 12),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )),
          ],
        )),
        Container(
          margin: EdgeInsets.only(right: 6),
          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
              color: redColor, borderRadius: BorderRadius.circular(15)),
          child: Text(
            '去开团',
            style: t14white,
          ),
        )
      ],
    );
  }

  _image(Result item) {
    return Expanded(
      child: Container(
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
      ),
    );
  }

  _price() {
    return Container(
      child: Row(
        children: [
          Expanded(
              child: item.isRefundPay
                  ? Container(
                      child: Text(
                        '折合0元到手',
                        style: t18redBold,
                      ),
                    )
                  : Container()),
          Container(
            margin: EdgeInsets.only(right: 6),
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
                color: redColor, borderRadius: BorderRadius.circular(15)),
            child: Text(
              '去开团',
              style: t14white,
            ),
          )
        ],
      ),
      padding: EdgeInsets.only(left: 5),
    );
  }
}
