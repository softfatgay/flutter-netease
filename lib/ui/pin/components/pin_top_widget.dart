import 'package:flutter/material.dart';
import 'package:flutter_app/component/timer_text.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/ui/pin/model/pinItemDetailModel.dart';
import 'package:flutter_app/utils/util_mine.dart';

///banner底部活动
class PinTopWidget extends StatelessWidget {
  final ItemInfo? itemInfo;

  const PinTopWidget({Key? key, this.itemInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _detailPromBannerWidget();
  }

  _detailPromBannerWidget() {
    return itemInfo == null ? Container() : _activity();
  }

  _activity() {
    return Container(
      height: 50,
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          Color(0xFFe54c50),
          Color(0xFFfc6161),
        ],
      )),
      child: Row(
        children: [
          Row(
            textBaseline: TextBaseline.alphabetic,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            children: [
              Text(
                '¥',
                style: t12white,
              ),
              Text(
                '${itemInfo!.price}',
                style: t20whitebold,
              ),
            ],
          ),
          SizedBox(
            width: 10,
          ),
          itemInfo!.isRefundPay!
              ? Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  decoration: BoxDecoration(
                      color: backWhite,
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    children: [
                      Text(
                        '折合到手¥ ',
                        style: t12red,
                      ),
                      Text(
                        '${itemInfo!.prePrice}',
                        style: t18redBold,
                      ),
                    ],
                  ),
                )
              : Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: backWhite, width: 0.5)),
                  child: Text(
                    '超低价',
                    style: t12white,
                  ),
                ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TimerText(
                  tips: '距结束',
                  textStyle: t14white,
                  time: (itemInfo!.endTime! - Util.currentTimeMillis()) ~/ 1000,
                ),
                Text(
                  '包邮•邀新团',
                  style: t12white,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
