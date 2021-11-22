import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/component/top_round_net_image.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/model/saturdayBuyModel.dart';
import 'package:flutter_app/ui/router/router.dart';

class StuBuyGridItemWidget extends StatelessWidget {
  final Result? item;

  const StuBuyGridItemWidget({Key? key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildItem(context);
  }

  _buildItem(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(6)),
        child: _detailDes(item!),
      ),
      onTap: () {
        Routers.push(Routers.pinPage, context,
            {'itemId': item!.itemId, 'baseId': item!.id});
      },
    );
  }

  _detailDes(Result item) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _image(item),
        Container(
          padding: EdgeInsets.only(left: 5, top: 5),
          child: RichText(
            text: TextSpan(
              style: t14black,
              children: [
                if (item.isRefundPay!)
                  WidgetSpan(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                      child: Text(
                        '${item.isRefundPay! ? '返¥${item.price}余额 ' : ''}',
                        style: TextStyle(
                            color: textWhite, fontSize: 12, height: 1.1),
                        textAlign: TextAlign.center,
                      ),
                      decoration: BoxDecoration(
                          color: Color(0xFFFF5252),
                          borderRadius: BorderRadius.circular(15)),
                    ),
                  ),
                TextSpan(
                    text: '${item.title}',
                    style:
                        TextStyle(fontSize: 14, color: textBlack, height: 1.1))
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
                  Container(
                    width: 28,
                    child: Stack(
                      children: [
                        ClipOval(
                            child: Image.network(
                          item.recentUsers == null ? '' : item.recentUsers![0],
                          width: 16,
                          height: 16,
                          fit: BoxFit.cover,
                        )),
                        Positioned(
                          right: 0,
                          child: ClipOval(
                              child: Image.network(
                            item.recentUsers == null
                                ? ''
                                : item.recentUsers![1],
                            width: 16,
                            height: 16,
                            fit: BoxFit.cover,
                          )),
                        ),
                      ],
                    ),
                  ),
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
    );
  }

  _image(Result item) {
    return Expanded(
      child: Container(
        alignment: Alignment.topCenter,
        child: Stack(
          children: [
            TopRoundNetImage(
              corner: 6,
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
            child: item!.isRefundPay!
                ? Container(
                    child: Text(
                      '折合0元到手',
                      style: t16redBold,
                    ),
                  )
                : Container(
                    child: Row(
                      textBaseline: TextBaseline.alphabetic,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      children: [
                        Text(
                          '¥${item!.price}',
                          style: t16redBold,
                        ),
                        Text(
                          '¥${item!.originPrice}',
                          style: TextStyle(
                            fontSize: 12,
                            color: textGrey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
          Container(
            margin: EdgeInsets.only(right: 6),
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            decoration: BoxDecoration(
                color: redColor, borderRadius: BorderRadius.circular(15)),
            child: Text(
              '去开团',
              style: TextStyle(fontSize: 14, color: textWhite, height: 1.15),
            ),
          )
        ],
      ),
      padding: EdgeInsets.only(left: 5),
    );
  }
}
