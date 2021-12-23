import 'package:flutter/cupertino.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/ui/shopping_cart/components/cart_num_filed.dart';

class CountClickDialog {
  final TextEditingController controller;
  final Function confirm;

  CountClickDialog(this.controller, this.confirm);

  build(BuildContext context) async {
    return _showDialog(context);
  }

  _showDialog(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          content: Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            padding: EdgeInsets.symmetric(horizontal: 30),
            decoration: BoxDecoration(
                // border: Border.all(color: textGrey, width: 1),
                // borderRadius: BorderRadius.circular(4),
                ),
            child: CartTextFiled(
              controller: controller,
            ),
          ),
          actions: [
            CupertinoDialogAction(
              child: Text(
                '取消',
                style: t16grey,
              ),
              isDestructiveAction: true,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            CupertinoDialogAction(
              child: Text(
                '确认',
                style: t16red,
              ),
              onPressed: () {
                confirm();
              },
            ),
          ],
        );
      },
    );
  }
}
