import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/ui/router/router.dart';
import 'package:flutter_app/ui/shopping_cart/model/itemPoolBarModel.dart';

class BottomPoolWidget extends StatelessWidget {
  final ItemPoolBarModel? itemPoolBarModel;
  final String? from;

  const BottomPoolWidget({Key? key, this.itemPoolBarModel, this.from})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return itemPoolBarModel == null
        ? Container()
        : Container(
            padding: EdgeInsets.only(left: 25),
            height: 45,
            decoration: BoxDecoration(
                color: backWhite,
                border: Border(top: BorderSide(color: lineColor, width: 0.5))),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '小计：¥${itemPoolBarModel!.subtotalPrice}',
                        style: t14redBold,
                      ),
                      Text(
                        '${itemPoolBarModel!.promTip!.replaceAll('#', '')}',
                        style: t12black,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    height: double.infinity,
                    color: backRed,
                    alignment: Alignment.center,
                    child: Text(
                      '${from == Routers.goodDetail ? '重新换购' : '去购物车'}',
                      style: t16white,
                    ),
                  ),
                  onTap: () {
                    if (from == Routers.shoppingCart ||
                        from == Routers.goodDetail) {
                      Navigator.pop(context);
                    } else {
                      Routers.push(Routers.shoppingCart, context);
                    }
                  },
                )
              ],
            ),
          );
  }
}
