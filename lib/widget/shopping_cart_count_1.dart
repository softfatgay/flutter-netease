import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';

typedef void ValueChanged(int count);

Color borderColor = Colors.grey[200];

class CartCount extends StatefulWidget {
  CartCount({
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
  _CartCountState createState() => _CartCountState();
}

class _CartCountState extends State<CartCount> {
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
      child: Row(
        children: <Widget>[
          GestureDetector(
            child: Container(
              width: 30,
              decoration: BoxDecoration(
                border: Border(
                  left: leftBorderSide(),
                  top: leftBorderSide(),
                  bottom: leftBorderSide(),
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.remove,
                  color: widget.min >= widget.number ? backColor : textGrey,
                  size: 18,
                ),
              ),
            ),
            onTap: () {
              onClickBtn('remove');
            },
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  right: leftBorderSide(),
                  top: leftBorderSide(),
                  bottom: leftBorderSide(),
                ),
              ),
              child: Center(
                child: Text(
                  '$num',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),
          GestureDetector(
            child: Container(
              width: 30,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: widget.max >= num ? textLightGrey : textGrey)),
              child: Center(
                child: Icon(
                  Icons.add,
                  color: widget.max >= widget.number ? textLightGrey : textGrey,
                  size: 18,
                ),
              ),
            ),
            onTap: () {
              onClickBtn('add');
            },
          )
        ],
      ),
    );
  }

  BorderSide leftBorderSide() =>
      BorderSide(color: widget.min >= widget.number ? backColor : textGrey);

  BorderSide rightBorderSide() =>
      BorderSide(color: widget.min >= widget.number ? backColor : textGrey);

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
