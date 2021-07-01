import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/ui/goodsDetail/model/goodDetail.dart';
import 'package:flutter_app/utils/router.dart';

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
          margin: EdgeInsets.fromLTRB(10, 15, 10, 0),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
          height: 40,
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                height: 40,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.horizontal(left: Radius.circular(6)),
                  color: backYellow,
                ),
                alignment: Alignment.center,
                child: Text(
                  '${spmcBanner.spmcTagDesc}',
                  style: t12white,
                ),
              ),
              Expanded(
                child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 5),
                        height: 40,
                        decoration: ShapeDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  "assets/images/detail_vip_icon.png"),
                              fit: BoxFit.fitWidth),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusDirectional.horizontal(
                              end: Radius.circular(6),
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                '${spmcBanner.spmcDesc}${spmcBanner.spmcPrice}',
                                style: t12white,
                                textAlign: TextAlign.start,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 1),
                              decoration: BoxDecoration(
                                  color: backYellow,
                                  borderRadius: BorderRadius.circular(6)),
                              child: Text(
                                '开通',
                                style: t12black,
                              ),
                            ),
                            SizedBox(width: 5),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
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
