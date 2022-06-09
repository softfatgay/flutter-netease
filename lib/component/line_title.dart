import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';

class LineTitle extends StatelessWidget {
  final String title;
  final TextStyle style;

  const LineTitle({
    Key? key,
    required this.title,
    this.style = const TextStyle(
      fontSize: 17,
      color: textBlack,
      height: 1.1,
      fontWeight: FontWeight.w500,
    ),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _titleLine(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 6),
            child: Text(
              "$title",
              style: style,
            ),
          ),
          _titleLine(),
        ],
      ),
    );
  }

  _titleLine() {
    return Container(
      width: 12,
      color: textBlack,
      height: 1,
    );
  }
}
