import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';

typedef void OnCheckChanged(bool check);
typedef void OnPress();

class MCheckBoxWidth extends StatelessWidget {
  final OnPress onPress;
  final bool check;
  final String? suffixText;

  const MCheckBoxWidth(
      {Key? key,
      required this.onPress,
      required this.check,
      this.suffixText = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPress();
      },
      child: Container(
        width: double.infinity,
        color: Colors.transparent,
        padding: EdgeInsets.symmetric(vertical: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            check
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
            if (suffixText != null && suffixText!.isNotEmpty)
              SizedBox(width: 5),
            if (suffixText != null && suffixText!.isNotEmpty)
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
