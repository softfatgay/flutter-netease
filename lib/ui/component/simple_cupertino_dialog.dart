import 'package:flutter/cupertino.dart';
import 'package:flutter_app/constant/fonts.dart';

class SimpleCupertinoDialog {
  final String tips;
  final String confirmTv;
  final String cancelTv;
  final Function confirm;

  SimpleCupertinoDialog({
    required this.tips,
    required this.confirm,
    this.confirmTv = '确定',
    this.cancelTv = '取消',
  });

  build(BuildContext context) {
    _showDialog(context);
  }

  void _showDialog(BuildContext context) {
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
            child: Text(
              '$tips',
              style: t16black,
            ),
          ),
          actions: [
            CupertinoDialogAction(
              child: Text(
                '$cancelTv',
                style: t16grey,
              ),
              isDestructiveAction: true,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            CupertinoDialogAction(
              child: Text(
                '$confirmTv',
                style: t16red,
              ),
              onPressed: () {
                Navigator.of(context).pop();
                confirm();
              },
            ),
          ],
        );
      },
    );
  }
}
