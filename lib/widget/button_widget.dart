import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///普通按钮
Widget NormalBtn(String text, Color color, Function onPressed,
    {TextStyle textStyle}) {
  return Container(
    height: 45,
    width: double.infinity,
    child: RaisedButton(
      elevation: 0,
      color: color,
      onPressed: () {
        if (onPressed != null) {
          onPressed();
        }
      },
      child: btnChild(text, textStyle: textStyle),
    ),
  );
}

Widget btnChild(String text, {TextStyle textStyle}) {
  return Text(
    text ?? '确定',
    style: textStyle ?? t14white,
  );
}

///tab
Widget NormalFAB(String text, VoidCallback onPressed,
    {Color backColor = backRed, Color disabledColor = disableBtnColor}) {
  return Container(
    height: 45,
    width: ScreenUtil().setWidth(167),
    margin: EdgeInsets.only(bottom: 70),
    child: RaisedButton(
      elevation: 0,
      color: backColor,
      disabledColor: enableBtnLightColor,
      onPressed: onPressed,
      child: Text(
        '${text ?? ''}',
        style: t14white,
      ),
    ),
  );
}

///fab
Widget ButtonFAB(String text, Function onPressed, {Color backColor = backRed}) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.symmetric(horizontal: 16),
    height: 45,
    child: RaisedButton(
      elevation: 0,
      color: backColor,
      onPressed: () {
        if (onPressed != null) {
          onPressed();
        }
      },
      child: Text(
        '${text ?? ''}',
        style: t14white,
      ),
    ),
  );
}

///普通按钮
Widget ActiveBtn(Color backColor, Function onPressed,
    {String text, double height, TextStyle textStyle}) {
  return Container(
    height: 45,
    width: double.infinity,
    child: RaisedButton(
      elevation: 0,
      color: backColor,
      onPressed: () {
        if (onPressed != null) {
          onPressed();
        }
      },
      child: btnChild(text, textStyle: textStyle),
    ),
  );
}

///页面级别按钮，可高度定制或使用默认效果
class PageButton extends StatefulWidget {
  final String text;
  final Color textColor;
  final double fontSize;
  final String fontFamily;
  final FontWeight fontWeight;
  final double height;
  final double width;
  final double radius;
  final Color backgroundColor;
  final Color backgroundHighlightColor;
  final VoidCallback onPressed;
  final bool enable;

  const PageButton({
    Key key,
    this.text = 'Button',
    this.textColor = Colors.white,
    this.fontSize = 16,
    this.fontFamily,
    this.fontWeight = FontWeight.w500,
    this.width,
    this.height = 45,
    this.radius = 8,
    this.backgroundColor = backRed,
    this.backgroundHighlightColor = enableBtnLightColor,
    this.onPressed,
    this.enable,
  }) : super(key: key);

  @override
  _PageButtonState createState() => _PageButtonState();
}

class _PageButtonState extends State<PageButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: (widget.width != null && widget.width > 0) ? widget.width : 100,
      height: widget.height,
      child: MaterialButton(
        color: widget.backgroundColor,
        highlightColor: widget.backgroundHighlightColor,
        disabledColor: disableBtnColor,
//        colorBrightness: Brightness.dark,
//        splashColor: Colors.grey,
        child: Text(
          widget.text,
          style: TextStyle(
            color: widget.textColor,
            fontWeight: widget.fontWeight,
            fontSize: widget.fontSize,
            fontFamily:
                (widget.fontFamily != null && widget.fontFamily is String)
                    ? widget.fontFamily
                    : DefaultTextStyle.of(context).style.fontFamily,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(widget.radius),
        ),
        onPressed: (widget.enable != null && widget.enable == false)
            ? null
            : () {
                if (widget.onPressed != null) {
                  widget.onPressed();
                }
              },
      ),
    );
  }
}
