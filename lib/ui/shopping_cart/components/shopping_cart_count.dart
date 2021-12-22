import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';

typedef void ValueChanged(num? count);

Color? borderColor = Colors.grey[200];
const double _borderWidth = 0.5;

typedef void NumClick();

class CartCount extends StatefulWidget {
  final ValueChanged onChange;
  num number;
  final num min;
  final num max;
  final NumClick numClick;

  CartCount({
    this.number = 1,
    this.min = 1,
    this.max = 1,
    required this.onChange,
    required this.numClick,
  });

  @override
  _CartCountState createState() => _CartCountState();
}

class _CartCountState extends State<CartCount> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 100,
      child: Row(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              border: _leftBorder(),
            ),
            width: 32,
            // color: widget.min! >= widget.number ? backColor : Colors.white,
            child: InkResponse(
              child: Center(
                child: Icon(
                  Icons.remove,
                  color: _getLeftColor(),
                  size: 18,
                ),
              ),
              onTap: () {
                onClickBtn('remove');
              },
            ),
          ),
          Expanded(
            child: GestureDetector(
              child: Container(
                decoration: BoxDecoration(
                  border: _tvBorder(),
                ),
                child: Center(
                  child: Text(
                    '${widget.number}',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              onTap: () {
                widget.numClick();
              },
            ),
          ),
          Container(
            width: 32,
            decoration: BoxDecoration(border: _rightBorder()),
            // color: widget.max! <= widget.number ? backColor : Colors.white,
            child: InkResponse(
              child: Center(
                child: Icon(
                  Icons.add,
                  color: _getRightColor(),
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

  _leftBorder() {
    var borderSide = BorderSide(color: _getLeftColor(), width: _borderWidth);
    return Border(
      left: borderSide,
      top: borderSide,
      bottom: borderSide,
    );
  }

  _getLeftColor() {
    return widget.min >= widget.number ? Color(0x33999999) : textLightGrey;
  }

  _tvBorder() {
    return Border.all(color: textLightGrey, width: _borderWidth);
  }

  _rightBorder() {
    var borderSide = BorderSide(color: _getRightColor(), width: _borderWidth);
    return Border(
      right: borderSide,
      top: borderSide,
      bottom: borderSide,
    );
  }

  _getRightColor() {
    return widget.max <= widget.number ? Color(0x33999999) : textLightGrey;
  }

  onClickBtn(String type) {
    if (type == 'remove' && widget.number > widget.min) {
      setState(() {
        widget.number = widget.number - 1;
        widget.onChange(widget.number);
      });
    } else if (type == 'add' && widget.number < widget.max) {
      setState(() {
        widget.number = widget.number + 1;
        widget.onChange(widget.number);
      });
    }
  }
}
