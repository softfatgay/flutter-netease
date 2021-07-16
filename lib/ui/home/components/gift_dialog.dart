import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/ui/home/model/newUserGiftModel.dart';
import 'package:flutter_app/utils/util_mine.dart';

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
                        margin: EdgeInsets.only(bottom: 55),
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          '${Util.temFormat(newUserGift2.useExpireTime * 1000)}结束',
                          style: t14red,
                        ),
                      )
                    ],
                  ),
                )
              ],
            );
          },
        );
      });
}
