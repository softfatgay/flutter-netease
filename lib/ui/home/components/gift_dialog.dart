import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/ui/home/model/newUserGiftModel.dart';
import 'package:flutter_app/ui/router/router.dart';
import 'package:flutter_app/utils/util_mine.dart';
import 'package:flutter_app/component/timer_text.dart';

void showGiftDialog(BuildContext context, NewUserGift newUserGift) {
  var newUserGift2 = newUserGift.newUserGift;
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        String label = 'test';
        return StatefulBuilder(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                  child: Container(
                    margin: EdgeInsets.only(right: 40),
                    child: Image.asset(
                      'assets/images/circle_close.png',
                      width: 30,
                      height: 30,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                Container(
                  height: 400,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage('${newUserGift2.showPic}'),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Container(
                        alignment: Alignment.topCenter,
                        margin: EdgeInsets.only(top: 80),
                        child: Text(
                          '${newUserGift2.price}元',
                          style: t27redBold,
                        ),
                      ),
                      Container(
                        alignment: Alignment.topCenter,
                        margin: EdgeInsets.only(top: 210),
                        child: Text(
                          '恭喜您获得了新礼包',
                          style: TextStyle(
                              color: textLightYellow,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        alignment: Alignment.topCenter,
                        margin: EdgeInsets.only(top: 250),
                        child: Text(
                          '${Util.temFormat(newUserGift2.useExpireTime * 1000)}结束',
                          style: t16whiteblod,
                        ),
                      ),
                      Positioned(
                        bottom: 37,
                        left: 0,
                        right: 0,
                        child: Container(
                          alignment: Alignment.center,
                          width: double.infinity,
                          child: GestureDetector(
                            child: Container(
                              width: 200,
                              height: 53,
                              color: Colors.transparent,
                              alignment: Alignment.center,
                              child: Text(
                                '立即领取',
                                style: t16redBold,
                              ),
                            ),
                            onTap: () {
                              Routers.push(Routers.webView, context, {
                                'url':
                                    'https://act.you.163.com/act/pub/qAU4P437asfF.html'
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          },
        );
      });
}
