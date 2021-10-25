import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';

typedef void ValueChanged(int? count);

Color? borderColor = Colors.grey[200];

typedef void NumClick();

class CartCount extends StatefulWidget {
  final ValueChanged? onChange;
  int? number;
  final int? min;
  final int? max;
  final NumClick? numClick;

  CartCount({
    this.number,
    this.min,
    this.max,
    this.onChange,
    this.numClick,
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
      decoration: BoxDecoration(
          border: Border.all(
            color: borderColor!,
          ),
          borderRadius: BorderRadius.circular(2)),
      child: Row(
        children: <Widget>[
          Container(
            width: 30,
            color: widget.min! >= widget.number! ? backColor : Colors.white,
            child: InkResponse(
              child: Center(
                child: Icon(
                  Icons.remove,
                  color:
                      widget.min! >= widget.number! ? textLightGrey : textGrey,
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
                  border: Border(
                    left: BorderSide(color: borderColor!),
                    right: BorderSide(color: borderColor!),
                  ),
                ),
                child: Center(
                  child: Text(
                    '${widget.number}',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              onTap: () {
                if (widget.numClick != null) {
                  widget.numClick!();
                }
              },
            ),
          ),
          Container(
            width: 30,
            color: widget.max! <= widget.number! ? backColor : Colors.white,
            child: InkResponse(
              child: Center(
                child: Icon(
                  Icons.add,
                  color:
                      widget.max! <= widget.number! ? textLightGrey : textGrey,
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
    if (type == 'remove' && widget.number! > widget.min!) {
      setState(() {
        widget.number = widget.number! - 1;
        widget.onChange!(widget.number);
      });
    } else if (type == 'add' && widget.number! < widget.max!) {
      setState(() {
        widget.number = widget.number! + 1;
        widget.onChange!(widget.number);
      });
    }
  }
}
