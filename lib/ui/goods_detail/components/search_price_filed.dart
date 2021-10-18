import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';

_disabledBorder() => OutlineInputBorder(
    borderSide: BorderSide(
      color: textBlack,
      width: 1,
    ),
    borderRadius: BorderRadius.circular(2));

class SearchPriceTextFiled extends TextField {
  SearchPriceTextFiled(
      {final TextEditingController? controller,
      final int maxlines = 1,
      int? maxLength,
      bool enabled = true,
      String counterText = '',
      String prefixText = '',
      TextInputType? keyboardType,
      String hintText = ''})
      : super(
          keyboardType: TextInputType.number,
          obscureText: false,
          controller: controller,
          style: t14black,
          enabled: enabled,
          textAlign: TextAlign.center,
          inputFormatters: [],
          decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 0),
              fillColor: Colors.white,
              hintStyle: t12grey,
              disabledBorder: _disabledBorder(),
              enabledBorder: _disabledBorder(),
              focusedBorder: _disabledBorder(),
              hintText: '$hintText',
              counterText: ''),
        );
}
