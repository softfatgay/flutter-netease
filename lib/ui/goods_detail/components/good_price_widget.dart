import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/ui/goods_detail/model/goodDetail.dart';

///价格
class GoodPriceWidget extends StatelessWidget {
  final DetailPromBanner detailPromBanner;
  final String price;
  final String counterPrice;

  const GoodPriceWidget(
      {Key key, this.detailPromBanner, this.price, this.counterPrice})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildPrice();
  }

  _buildPrice() {
    return detailPromBanner == null
        ? Container(
            color: backWhite,
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: <Widget>[
                Text(
                  '￥',
                  overflow: TextOverflow.ellipsis,
                  style: t16redBold,
                ),
                Text(
                  '$price',
                  overflow: TextOverflow.ellipsis,
                  style: t27redBold,
                ),
                price == counterPrice
                    ? Container()
                    : Container(
                        margin: EdgeInsets.only(left: 5),
                        child: Text(
                          '${counterPrice == 'null' ? '' : '￥$counterPrice'}',
                          style: TextStyle(
                            fontSize: 12,
                            color: textGrey,
                            height: 1,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ),
              ],
            ))
        : Container();
  }
}
