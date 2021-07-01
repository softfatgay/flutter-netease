import 'package:flutter/material.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/ui/goodsDetail/model/shoppingReward.dart';
import 'package:flutter_app/widget/global.dart';

typedef void ShowDialog();

///购物返
class ShoppingRewardWidget extends StatelessWidget {
  final ShoppingReward shoppingReward;
  final ShowDialog showDialog;

  const ShoppingRewardWidget({Key key, this.shoppingReward, this.showDialog})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildWidget();
  }

  _buildWidget() {
    return shoppingReward == null
        ? Container()
        : InkResponse(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              decoration: bottomBorder,
              child: Row(
                children: <Widget>[
                  Container(
                    child: Text(
                      '${shoppingReward.name ?? ''}：',
                      style: t14grey,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 5),
                    child: Text(
                      '${shoppingReward.rewardDesc ?? ''}',
                      style: t14black,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Text(
                        '${shoppingReward.rewardValue ?? ''}',
                        style: t14red,
                      ),
                    ),
                  ),
                  arrowRightIcon,
                ],
              ),
            ),
            onTap: () {
              if (showDialog != null) {
                showDialog();
              }
            },
          );
  }
}
