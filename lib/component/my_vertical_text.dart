import 'package:flutter/cupertino.dart';
import 'package:flutter_app/constant/fonts.dart';

class VerticalText extends StatelessWidget {
  final String text;
  final TextStyle style;

  const VerticalText(this.text, {this.style = t14black});

  @override
  Widget build(BuildContext context) {
    return _verticalText(text);
  }

  _verticalText(String text) {
    var length = text.length;
    List<String> list = [];
    for (int i = 0; i < length; i++) {
      list.add(text[i]);
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: list
          .map((e) => Container(
                child: Text(
                  e,
                  style: style,
                ),
              ))
          .toList(),
    );
  }
}
