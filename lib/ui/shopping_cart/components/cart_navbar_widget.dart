import 'package:flutter/material.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/ui/router/router.dart';

typedef void EditPress();

class CartNavBarWidget extends StatelessWidget {
  final bool? isEdit;
  final EditPress? editPress;
  final bool? canBack;

  const CartNavBarWidget({Key? key, this.isEdit, this.editPress, this.canBack})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _navBar(context);
  }

  _navBar(BuildContext context) {
    return Container(
      height: 46,
      decoration: BoxDecoration(
        color: Colors.white,
        // border: Border(bottom: BorderSide(color: backColor,width: 1))
      ),
      padding: EdgeInsets.only(right: 15),
      child: Row(
        children: [
          canBack!
              ? GestureDetector(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Image.asset(
                      'assets/images/back.png',
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                )
              : Container(width: 15),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  '购物车',
                  style: t20blackBold,
                ),
                SizedBox(width: 5),
                Text(
                  '无忧退换，购物更省心',
                  style: t12grey,
                ),
              ],
            ),
          ),
          if (!isEdit!)
            GestureDetector(
              child: Container(
                // decoration: BoxDecoration(
                //     image: DecorationImage(
                //         fit: BoxFit.fill,
                //         image: AssetImage('assets/images/lingquan.png'))),
                child: Text(
                  '领券',
                  style: t16red,
                ),
              ),
              onTap: () {
                Routers.push(Routers.getCouponPage, context);
              },
            ),
          SizedBox(
            width: 15,
          ),
          GestureDetector(
            onTap: () {
              if (editPress != null) {
                editPress!();
              }
            },
            child: Text(
              isEdit! ? '完成' : '编辑',
              style: t16black,
            ),
          )
        ],
      ),
    );
  }
}
