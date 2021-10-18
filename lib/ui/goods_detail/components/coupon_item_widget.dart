import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/ui/goods_detail/model/couponModel.dart';

typedef void ReceiveClick(bool? albeToActivated);

class CouponItemWidget extends StatelessWidget {
  final ReceiveClick? receiveClick;
  final CouponModel? couponItem;

  const CouponItemWidget({Key? key, this.receiveClick, this.couponItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildCouponItem(couponItem);
  }

  _buildCouponItem(CouponModel? item) {
    return Container(
        margin: EdgeInsets.all(10),
        child: StatefulBuilder(builder: (context, setstate) {
          return Stack(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Color(0xFFeb7073),
                        Color(0xFFf4948a),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(4)),
                padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text(
                                '${item!.briefDesc}',
                                style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.w700,
                                    color: textWhite),
                              ),
                              Text(
                                '${item.unit}',
                                style: TextStyle(color: textWhite),
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
                                  Text(item.name!, style: t14white),
                                  Text('${item.timeDesc}', style: t12white),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(2),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 2),
                              child: Text(
                                '${item.albeToActivated! ? '立即领取' : '去凑单'}',
                                style: TextStyle(
                                    color: Color(0XFFb69150), fontSize: 12),
                              ),
                            ),
                            onTap: () {
                              if (receiveClick != null) {
                                receiveClick!(item.albeToActivated);
                              }
                            },
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      child: Container(
                        margin: EdgeInsets.only(top: 20),
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                        decoration: BoxDecoration(
                            color: Color(0XFFD9696B),
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(4))),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                item.useCondition!,
                                style: t12white,
                                maxLines: item.isSelected == null
                                    ? 1
                                    : (item.isSelected! ? 15 : 1),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Icon(
                              _returnIcon(item),
                              color: Colors.white,
                              size: 16,
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        setstate(() {
                          if (item.isSelected == null) {
                            item.isSelected = true;
                          } else {
                            item.isSelected = !item.isSelected!;
                          }
                        });
                      },
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 0,
                top: 0,
                child: Image.asset(
                  'assets/images/has_coupon.png',
                  width: 50,
                  height: 50,
                ),
              )
            ],
          );
        }));
  }

  _returnIcon(CouponModel item) {
    if (item.isSelected == null) {
      return Icons.keyboard_arrow_down_rounded;
    } else {
      if (item.isSelected!) {
        return Icons.keyboard_arrow_up_rounded;
      } else {
        return Icons.keyboard_arrow_down_rounded;
      }
    }
  }
}
