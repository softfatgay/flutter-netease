import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/ui/goods_detail/model/goodDetail.dart';
import 'package:flutter_app/component/timer_text.dart';

///banner底部活动
class DetailPromBannerWidget extends StatelessWidget {
  final DetailPromBanner detailPromBanner;
  final String price;
  final String counterPrice;

  const DetailPromBannerWidget(
      {Key key, this.detailPromBanner, this.price, this.counterPrice})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _detailPromBannerWidget();
  }

  _detailPromBannerWidget() {
    return detailPromBanner == null ? Container() : _activity();
  }

  _activity() {
    return Container(
      decoration: BoxDecoration(color: Color(0xFFFFF0DD)),
      child: Row(
        children: [
          CachedNetworkImage(
            imageUrl: detailPromBanner.bannerTitleUrl,
            height: 50,
          ),
          Expanded(
            child: Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: detailPromBanner.bannerContentUrl,
                  height: 50,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Container(
                  height: 50,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [_priceDes(), _sellDes()],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  _sellDes() {
    int hour = 0;
    int day = 0;
    var countdown = detailPromBanner.countdown;
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

    if (day == 0) {
      return _timer(detailPromBanner.countdown);
    }

    return (detailPromBanner.countdown != null &&
            detailPromBanner.countdown > 0)
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '距结束$day天$hour小时',
                style: t12white,
              ),
              detailPromBanner.sellVolumeDesc == null
                  ? Container()
                  : Container(
                      margin: EdgeInsets.only(top: 5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 40,
                            height: 3,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(2)),
                          ),
                          Text(
                            '${detailPromBanner.sellVolumeDesc}',
                            style: t12white,
                          ),
                        ],
                      ),
                    ),
            ],
          )
        : Container();
  }

  _priceDes() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${detailPromBanner.promoTitle}  ${detailPromBanner.promoSubTitle ?? ''}',
          style: t12whiteBold,
        ),
        SizedBox(height: 3),
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.ideographic,
          children: [
            Text(
              '￥',
              style: TextStyle(
                fontSize: 12,
                color: textWhite,
                fontWeight: FontWeight.w500,
                height: 1.1,
              ),
            ),
            Text(
              '$price',
              style: TextStyle(
                fontSize: 24,
                color: textWhite,
                fontWeight: FontWeight.w500,
                height: 1.1,
              ),
            ),
            SizedBox(width: 3),
            Text(
              '${counterPrice ?? ''}',
              style: TextStyle(
                  decoration: TextDecoration.lineThrough,
                  fontSize: 12,
                  color: textWhite),
            ),
            SizedBox(width: 3),
          ],
        ),
      ],
    );
  }

  _timer(num second) {
    return TimerText(
      time: second ~/ 1000,
      tips: '距结束',
    );
  }
}
