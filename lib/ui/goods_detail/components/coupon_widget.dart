import 'package:flutter/material.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/component/global.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/ui/goods_detail/components/coupon_item_widget.dart';
import 'package:flutter_app/ui/goods_detail/components/diaolog_title_widget.dart';
import 'package:flutter_app/ui/goods_detail/components/gd_button_style.dart';
import 'package:flutter_app/ui/goods_detail/model/couponModel.dart';
import 'package:flutter_app/ui/router/router.dart';
import 'package:flutter_app/utils/toast.dart';

///领券

class CouponWidget extends StatelessWidget {
  final List<String>? couponShortNameList;
  final List<CouponModel>? couponList;
  final num id;
  final Function getCoupon;

  const CouponWidget({
    Key? key,
    this.couponShortNameList,
    this.couponList,
    required this.id,
    required this.getCoupon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildWidget(context);
  }

  _buildWidget(BuildContext context) {
    return couponShortNameList == null || couponShortNameList!.isEmpty
        ? Container()
        : TextButton(
            style: gdButtonStyle,
            child: Container(
              padding: EdgeInsets.only(top: 15, bottom: 15, right: 10),
              decoration: bottomBorder,
              child: Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: 5),
                    child: Text(
                      '领券：',
                      style: t14black,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: couponShortNameList!
                          .map<Widget>((item) => _buildItem(item))
                          .toList(),
                    ),
                  ),
                  arrowRightIcon,
                ],
              ),
            ),
            onPressed: () {
              _showCouponDialog(context);
            },
          );
  }

  _buildItem(String item) {
    return Container(
      margin: EdgeInsets.only(right: 3),
      decoration: BoxDecoration(
          border: Border.all(color: Color(0xFFF48F18), width: 0.5),
          borderRadius: BorderRadius.circular(2)),
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
      child: Text(
        '$item',
        style: t12Yellow,
      ),
    );
  }

  _showCouponDialog(BuildContext context) {
    return showModalBottomSheet(
      //设置true,不会造成底部溢出
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(5.0),
            ),
          ),
          child: Container(
            padding: EdgeInsets.only(bottom: 50),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DialogTitleWidget(title: '领券'),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: couponList!
                      .map<Widget>((item) => Container(
                            child: _buildCouponItem(context, item),
                          ))
                      .toList(),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  _buildCouponItem(BuildContext context, CouponModel item) {
    return CouponItemWidget(
      couponItem: item,
      receiveClick: (ableToActivated) {
        if (ableToActivated) {
          ///领券
          getCoupon(item);
          // _getItemCoupon(item);
        } else {
          ///已领取，去凑单
          Routers.push(Routers.makeUpPage, context,
              {'from': Routers.goodDetail, 'id': -1});
        }
      },
    );
  }
}
