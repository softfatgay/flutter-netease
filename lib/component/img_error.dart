import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';

class ImgError extends StatelessWidget {
  final double? fontSize;

  const ImgError({Key? key, this.fontSize = 23}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          border: Border.all(color: Color(0xFFF5F5F5), width: 0.6),
          borderRadius: BorderRadius.circular(8)),
      child: Transform.rotate(
        angle: 0.75,
        child: Text(
          'error.png',
          style: TextStyle(
              color: lineColor,
              fontSize: fontSize,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
