import 'package:flutter/material.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/ui/goods_detail/components/gd_button_style.dart';
import 'package:flutter_app/ui/goods_detail/model/shoppingReward.dart';
import 'package:flutter_app/component/global.dart';

typedef void ShowDialog();

///购物返
class ShoppingRewardWidget extends StatelessWidget {
  final ShoppingReward? shoppingReward;
  final ShowDialog showDialog;

  const ShoppingRewardWidget({
    Key? key,
    this.shoppingReward,
    required this.showDialog,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildWidget();
  }

  _buildWidget() {
    return shoppingReward == null
        ? Container()
        : TextButton(
            style: gdButtonStyle,
            child: Container(
              padding: EdgeInsets.only(top: 15, bottom: 15, right: 10),
              child: Row(
                children: <Widget>[
                  Container(
                    child: Text(
                      '${shoppingReward!.name ?? ''}：',
                      style: t14black,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 6),
                    child: Text(
                      '${shoppingReward!.rewardDesc ?? ''}',
                      style: t14black,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Text(
                        '${shoppingReward!.rewardValue ?? ''}',
                        style: t14red,
                      ),
                    ),
                  ),
                  arrowRightIcon,
                ],
              ),
            ),
            onPressed: () {
              showDialog();
            },
          );
  }
}
