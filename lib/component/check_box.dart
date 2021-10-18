import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';

typedef void OnCheckChanged(bool check);
typedef void Onpress();

class MCheckBox extends StatelessWidget {
  final Onpress? onPress;
  final bool? check;
  final String? suffixText;

  const MCheckBox({Key? key, this.onPress, this.check, this.suffixText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onPress != null) {
          onPress!();
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: check!
                  ? Icon(
                      Icons.check_circle,
                      size: 22,
                      color: Colors.red,
                    )
                  : Icon(
                      Icons.brightness_1_outlined,
                      size: 22,
                      color: lineColor,
                    ),
            ),
            SizedBox(width: 5),
            Container(
              child: Text(
                '$suffixText',
                style: t14black,
              ),
            )
          ],
        ),
      ),
    );
  }
}
