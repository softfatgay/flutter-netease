import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/ui/goods_detail/components/gd_button_style.dart';
import 'package:flutter_app/ui/goods_detail/model/wapitemDeliveryModel.dart';
import 'package:flutter_app/component/global.dart';

typedef void OnPress();

class DeliveryWidget extends StatelessWidget {
  final WapitemDeliveryModel? wapitemDelivery;
  final OnPress onPress;

  const DeliveryWidget({
    Key? key,
    this.wapitemDelivery,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return wapitemDelivery == null ? Container() : _buildWidget();
  }

  _buildWidget() {
    return TextButton(
      style: gdButtonStyle,
      child: Container(
        padding: EdgeInsets.only(top: 15, bottom: 15, right: 10),
        decoration: bottomBorder,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '配送：',
                    style: t14black,
                  ),
                  SizedBox(width: 6),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${wapitemDelivery!.addressName}',
                          style: t14black,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (wapitemDelivery!.deliveryTime != null &&
                            wapitemDelivery!.deliveryTime!.isNotEmpty)
                          Text(
                            '${wapitemDelivery!.deliveryTime}',
                            style: t14grey,
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            arrowRightIcon
          ],
        ),
      ),
      onPressed: () {
        onPress();
      },
    );
  }
}
