import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';

class CartTextFiled extends CupertinoTextField {
  CartTextFiled(
      {final TextEditingController? controller,
      final int maxLines = 1,
      int? maxLength,
      TextStyle textStyle = t16black,
      bool enabled = true,
      Color borderColor = backRed,
      String counterText = '',
      String prefixText = '',
      String hintText = ''})
      : super(
          keyboardType: TextInputType.number,
          obscureText: false,
          controller: controller,
          style: textStyle,
          enabled: enabled,
          autofocus: true,
          textAlign: TextAlign.center,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: BoxDecoration(
            border: Border.all(color: borderColor, width: 1),
            borderRadius: BorderRadius.circular(3),
          ),
        );
}
