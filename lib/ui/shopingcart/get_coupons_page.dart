import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/ui/router/router.dart';
import 'package:flutter_app/ui/shopingcart/model/getCouponModel.dart';
import 'package:flutter_app/utils/util_mine.dart';
import 'package:flutter_app/widget/app_bar.dart';
import 'package:flutter_app/widget/round_net_image.dart';

class GetCouponPage extends StatefulWidget {
  const GetCouponPage({Key key}) : super(key: key);

  @override
  _GetCouponPageState createState() => _GetCouponPageState();
}

class _GetCouponPageState extends State<GetCouponPage> {
  GetCouponModel _couponModel;

  List<CouponItem> _avalibleCouponList = [];
  List<CouponItem> _receiveCouponList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _couponListInCart();
  }

  void _couponListInCart() async {
    var responseData = await couponListInCart();
    setState(() {
      _couponModel = GetCouponModel.fromJson(responseData.data);
      _avalibleCouponList = _couponModel.avalibleCouponList;
      _receiveCouponList = _couponModel.receiveCouponList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopAppBar(
        title: '领券',
      ).build(context),
      body: _buildBody(),
    );
  }

  _buildBody() {
    List<Widget> childs = [];
    childs.add(_title("可领取的优惠券"));
    childs.add(_avalibleCoupon(_avalibleCouponList));
    childs.add(_title("已领取的优惠券"));
    childs.add(_avalibleCoupon(_receiveCouponList));

    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: 15),
      child: Column(
        children: childs,
      ),
    );
  }

  _title(String title) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.only(top: 15),
      child: Row(
        children: [
          Container(
            height: 14,
            color: textBlack,
            width: 3,
          ),
          Text(
            '$title',
            style: t14black,
          )
        ],
      ),
    );
  }

  _avalibleCoupon(List<CouponItem> avalibleCouponList) {
    return Column(
      children:
          avalibleCouponList.map<Widget>((item) => _buildItem(item)).toList(),
    );
  }

  _buildItem(CouponItem item) {
    var backColor = Color(0xFFFFF4F4);
    var botomColor = backWhite;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: backColor,
        border: Border.all(color: lineColor, width: 1),
        borderRadius: BorderRadius.circular(4),
      ),
      padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(color: backColor),
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      '${item.briefDesc}',
                      style: t28blackBold,
                    ),
                    Text(
                      '${item.unit}',
                      style: t14blackBold,
                    ),
                  ],
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.name, style: t14black),
                        Text('${_valueDate(item)}', style: t12black),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: backRed, width: 1),
                        borderRadius: BorderRadius.circular(2),
                        color: item.receiveFlag ? Colors.transparent : backRed),
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    child: Text(
                      item.receiveFlag ? '去凑单' : '立即领取',
                      style: item.receiveFlag ? t12Orange : t12white,
                    ),
                  ),
                  onTap: () {},
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                color: botomColor,
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(4))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            '购物车中的适用商品',
                            style: t12black,
                            maxLines: item.isSelected == null
                                ? 1
                                : (item.isSelected ? 15 : 1),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Icon(
                          _returnIcon(item),
                          color: textBlack,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      if (item.isSelected == null) {
                        item.isSelected = true;
                      } else {
                        item.isSelected = !item.isSelected;
                      }
                    });
                  },
                ),
                item.isSelected == null
                    ? Container()
                    : item.isSelected
                        ? SingleChildScrollView(
                            padding: EdgeInsets.only(bottom: 15),
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: item.skuList
                                  .map(
                                    (skuItem) => Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 5),
                                      child: RoundNetImage(
                                        backColor: Color(0XFFf4f4f4),
                                        url: skuItem.picUrl,
                                        width: 80,
                                        height: 80,
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          )
                        : Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _valueDate(CouponItem item) {
    print(item.validEndTime);
    print(item.validStartTime);
    String end = '';
    String start = '';

    if (item.validEndTime == null) {
      end = '已过期';
    } else {
      end = '${Util.long2dateD(item.validEndTime * 1000)}';
    }

    if (item.validStartTime == null) {
      start = '';
    } else {
      start = '${Util.long2dateD(item.validStartTime * 1000)}';
    }

    return '$start-$end';
  }

  _returnIcon(CouponItem item) {
    if (item.isSelected == null) {
      return Icons.keyboard_arrow_down_rounded;
    } else {
      if (item.isSelected) {
        return Icons.keyboard_arrow_up_rounded;
      } else {
        return Icons.keyboard_arrow_down_rounded;
      }
    }
  }
}
