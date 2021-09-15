import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/ui/goods_detail/model/goodDetail.dart';
import 'package:flutter_app/ui/router/router.dart';

///开通pro-vip
class ProVipWidget extends StatelessWidget {
  final SpmcBanner spmcBanner;

  const ProVipWidget({Key key, this.spmcBanner}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _proVip(context);
  }

  _proVip(BuildContext context) {
    if (spmcBanner != null) {
      return GestureDetector(
        child: Container(
          padding: EdgeInsets.only(top: 10),
          color: backWhite,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Color(0XFFFFF1D2)),
            child: Row(
              children: [
                Image.asset(
                  'assets/images/pro_icon.png',
                  height: 12,
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 10),
                    child: RichText(
                      text: TextSpan(style: t14black, children: [
                        TextSpan(
                            text: '${spmcBanner.spmcDesc}', style: t14black),
                        TextSpan(
                            text: '${spmcBanner.spmcPrice}', style: t14red),
                      ]),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                  decoration: BoxDecoration(
                      color: Color(0XFF12161C),
                      borderRadius: BorderRadius.circular(15)),
                  child: Text(
                    '开通',
                    style: t12Yellow,
                  ),
                )
              ],
            ),
          ),
        ),
        onTap: () {
          Routers.push(
              Routers.webView, context, {'url': '${spmcBanner.spmcLinkUrl}'});
        },
      );
    } else {
      return Container();
    }
  }
}
