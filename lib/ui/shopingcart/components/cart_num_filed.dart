import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';

class CartTextFiled extends CupertinoTextField {
  CartTextFiled(
      {final TextEditingController controller,
      final int maxlines = 1,
      int maxLength,
      bool enabled = true,
      String counterText = '',
      String prefixText = '',
      String hintText = ''})
      : super(
          keyboardType: TextInputType.number,
          obscureText: false,
          controller: controller,
          style: t16black,
          enabled: enabled,
          autofocus: true,
          textAlign: TextAlign.center,
          inputFormatters: [],
          decoration: BoxDecoration(
            border: Border.all(color: backRed, width: 1),
            borderRadius: BorderRadius.circular(3),
          ),
        );
}
