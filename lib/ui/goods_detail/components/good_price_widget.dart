import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/ui/goods_detail/model/goodDetail.dart';
import 'package:flutter_app/ui/goods_detail/model/priceModel.dart';

///价格
class GoodPriceWidget extends StatelessWidget {
  final DetailPromBanner? detailPromBanner;
  final PriceModel? priceModel;

  const GoodPriceWidget({Key? key, this.detailPromBanner, this.priceModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildPrice();
  }

  _buildPrice() {
    return detailPromBanner == null && priceModel != null
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
                  '${priceModel!.basicPrice}',
                  overflow: TextOverflow.ellipsis,
                  style: t27redBold,
                ),
                if (priceModel!.counterPrice != priceModel!.basicPrice)
                  Container(
                    margin: EdgeInsets.only(left: 5),
                    child: Text(
                      '${priceModel!.counterPrice ?? ''}',
                      style: TextStyle(
                        fontSize: 12,
                        color: textGrey,
                        height: 1,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  )
              ],
            ))
        : Container();
  }
}
