import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/ui/goods_detail/model/bannerModel.dart';
import 'package:flutter_app/component/timer_text.dart';
import 'package:flutter_app/utils/color_util.dart';

///banner底部活动
class DetailPromBannerWidget extends StatelessWidget {
  final BannerModel? banner;

  const DetailPromBannerWidget({Key? key, this.banner}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _detailPromBannerWidget();
  }

  _detailPromBannerWidget() {
    return banner == null || banner!.processBanner == null
        ? Container()
        : _activity();
  }

  _activity() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 2),
      decoration: BoxDecoration(
          color: HexColor.fromHex(banner!.processBanner == null
              ? '#E53B44'
              : banner!.processBanner!.bgColor ?? '#E53B44')),
      child: Column(
        children: [
          if (banner!.processBanner != null) _sellDes(),
          Container(
            margin: EdgeInsets.only(top: 5),
            child: Row(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      '¥',
                      style: t18whiteBold,
                    ),
                    SizedBox(width: 3),
                    Text(
                      '${_basicTextInt()[0]}',
                      style: t32whiteBold,
                    ),
                    Text(
                      '${_basicTextInt()[1]}',
                      style: t20whitebold,
                    ),
                    SizedBox(width: 5),
                    if (banner!.processBanner!.priceInfo!.counterPrice != null)
                      Text(
                        '¥${banner!.processBanner!.priceInfo!.counterPrice}',
                        style: TextStyle(
                          fontSize: 14,
                          color: textWhite,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                  ],
                ),
                if (banner!.processBanner!.priceInfo!.finalPrice != null)
                  _finalPrice()
              ],
            ),
          ),
        ],
      ),
    );
  }

  _sellDes() {
    int hour = 0;
    int day = 0;
    var countdown = banner!.processBanner!.endTimeGap;
    if (countdown != null && countdown > 0) {
      var d = countdown;
      // print('----------------');
      // print(d);
      var e = d ~/ 1000;
      // print(e);
      var f = e ~/ 3600;
      // print(f);
      hour = (f % 24).toInt();
      day = f ~/ 24;
    }

    var title = Text(
      '${banner!.processBanner!.title ?? ''}',
      style: t12white,
    );

    var cntTimer = Expanded(child: _timer(banner!.processBanner!.endTimeGap!));

    var spline = Container(
      height: 10,
      width: 1,
      color: backWhite,
      margin: EdgeInsets.symmetric(horizontal: 5),
    );

    var cntDay = Expanded(
        child: Text(
      '距结束$day天$hour小时',
      style: t12white,
    ));

    List<Widget> list = [];
    list.add(title);
    if (banner!.processBanner!.endTimeGap != null &&
        banner!.processBanner!.endTimeGap! > 0) {
      if (day == 0) {
        list.add(spline);
        list.add(cntTimer);
      } else {
        if (day < 30) {
          list.add(spline);
          list.add(cntDay);
        }
      }
    }

    if (day == 0) {
      return Row(
        children: [
          Text(
            '${banner!.processBanner!.title ?? ''}',
            style: t12white,
          ),
          if (day == 0)
            Container(
              height: 10,
              width: 1,
              color: backWhite,
              margin: EdgeInsets.symmetric(horizontal: 5),
            ),
          _timer(banner!.processBanner!.endTimeGap!),
        ],
      );
    }
    return Row(children: list);
  }

  _basicTextInt() {
    var basicPrice = banner!.processBanner!.priceInfo!.basicPrice!;
    if (basicPrice.contains('.')) {
      var indexOf = basicPrice.indexOf('.');
      var subInt = basicPrice.substring(0, indexOf);
      var subsDouble = basicPrice.substring(indexOf, basicPrice.length);
      return [subInt, '$subsDouble'];
    }

    return [basicPrice, ''];
  }

  // _priceDes() {
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text(
  //         '${banner.promoTitle}  ${banner.promoSubTitle ?? ''}',
  //         style: t12whiteBold,
  //       ),
  //       SizedBox(height: 3),
  //       Row(
  //         crossAxisAlignment: CrossAxisAlignment.baseline,
  //         textBaseline: TextBaseline.ideographic,
  //         children: [
  //           Text(
  //             '￥',
  //             style: TextStyle(
  //               fontSize: 12,
  //               color: textWhite,
  //               fontWeight: FontWeight.w500,
  //               height: 1.1,
  //             ),
  //           ),
  //           Text(
  //             '$price',
  //             style: TextStyle(
  //               fontSize: 24,
  //               color: textWhite,
  //               fontWeight: FontWeight.w500,
  //               height: 1.1,
  //             ),
  //           ),
  //           SizedBox(width: 3),
  //           Text(
  //             '${counterPrice ?? ''}',
  //             style: TextStyle(
  //                 decoration: TextDecoration.lineThrough,
  //                 fontSize: 12,
  //                 color: textWhite),
  //           ),
  //           SizedBox(width: 3),
  //         ],
  //       ),
  //     ],
  //   );
  // }

  _timer(num second) {
    return TimerText(
      time: second ~/ 1000,
      tips: '距结束',
      textStyle: t12white,
    );
  }

  _finalPrice() {
    var finalPrice = banner!.processBanner!.priceInfo!.finalPrice!;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
      decoration: BoxDecoration(
          color: backWhite, borderRadius: BorderRadius.circular(20)),
      child: Text(
        '${finalPrice.prefix ?? ''} ¥${finalPrice.price ?? ''} ${finalPrice.suffix ?? ''}',
        style: t14redBold,
      ),
    );
  }
}
