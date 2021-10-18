import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';

class NormalTextFiled extends TextField {
  NormalTextFiled(
      {final TextEditingController? controller,
      final int maxlines = 1,
      int? maxLength,
      bool enabled = true,
      String counterText = '',
      String prefixText = '',
      TextInputType? keyboardType,
      String hintText = ''})
      : super(
          keyboardType: TextInputType.name,
          obscureText: false,
          controller: controller,
          style: t16black,
          enabled: enabled,
          textAlign: TextAlign.start,
          inputFormatters: [],
          decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
              fillColor: Colors.white,
              filled: true,
              hintStyle: t14hintText,
              disabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(2)),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(2)),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(2)),
              hintText: '$hintText',
              counterText: ''),
        );
}
