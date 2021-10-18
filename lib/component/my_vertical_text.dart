import 'package:flutter/cupertino.dart';

class MyVerticalText extends StatelessWidget {
  final String? text;
  final TextStyle textStyle;

  const MyVerticalText(this.text, this.textStyle);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.vertical,
      alignment: WrapAlignment.center,
      children: text!
          .split("")
          .map((string) => Text(
                string,
                style: textStyle,
                textAlign: TextAlign.center,
              ))
          .toList(),
    );
  }
}
