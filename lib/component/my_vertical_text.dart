import 'package:flutter/cupertino.dart';

class MyVerticalText extends StatelessWidget {
  final String text;
  final TextStyle textStyle;

  const MyVerticalText(this.text, this.textStyle);

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
                  style: textStyle,
                ),
              ))
          .toList(),
    );
  }
}
