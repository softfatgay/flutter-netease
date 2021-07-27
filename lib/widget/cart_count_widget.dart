import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/widget/normal_textfiled.dart';

typedef void ValueChanged(int count);

Color borderColor = Colors.grey[200];

class CartCountWidget extends StatefulWidget {
  CartCountWidget({
    this.number,
    this.min,
    this.max,
    this.onChange,
  });

  final ValueChanged onChange;
  final int number;
  final int min;
  final int max;

  @override
  _CartCountWidgetState createState() => _CartCountWidgetState();
}

class _CartCountWidgetState extends State<CartCountWidget> {
  int num = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    num = widget.number;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 100,
      decoration: BoxDecoration(
          border: Border.all(
            color: borderColor,
          ),
          borderRadius: BorderRadius.circular(2)),
      child: Row(
        children: <Widget>[
          Container(
            width: 30,
            color: widget.min >= num ? backColor : Colors.white,
            child: InkResponse(
              child: Center(
                child: Icon(
                  Icons.remove,
                  color: widget.min >= widget.number ? textLightGrey : textGrey,
                  size: 18,
                ),
              ),
              onTap: () {
                onClickBtn('remove');
              },
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(color: borderColor),
                  right: BorderSide(color: borderColor),
                ),
              ),
              child: NormalTextFiled(),
            ),
          ),
          Container(
            width: 30,
            color: widget.max <= num ? backColor : Colors.white,
            child: InkResponse(
              child: Center(
                child: Icon(
                  Icons.add,
                  color: widget.max <= widget.number ? textLightGrey : textGrey,
                  size: 18,
                ),
              ),
              onTap: () {
                onClickBtn('add');
              },
            ),
          ),
        ],
      ),
    );
  }

  onClickBtn(String type) {
    if (type == 'remove' && num > widget.min) {
      setState(() {
        num -= 1;
        widget.onChange(num);
      });
    } else if (type == 'add' && num < widget.max) {
      setState(() {
        num += 1;
        widget.onChange(num);
      });
    }
  }
}
