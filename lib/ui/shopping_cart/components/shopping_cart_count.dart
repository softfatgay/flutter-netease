import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/ui/shopping_cart/components/cart_num_filed.dart';

typedef void ValueChanged(num count);

Color? borderColor = Colors.grey[200];
const double _borderWidth = 0.5;

typedef void NumClick();

class CartCount extends StatefulWidget {
  final ValueChanged numChange;
  num number;
  final num min;
  final num max;

  CartCount({
    this.number = 1,
    this.min = 1,
    this.max = 1,
    required this.numChange,
  });

  @override
  _CartCountState createState() => _CartCountState();
}

class _CartCountState extends State<CartCount> {
  final controller = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

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
                // widget.numClick();
                _showDialog(context);
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
        widget.numChange(widget.number);
      });
    } else if (type == 'add' && widget.number < widget.max) {
      setState(() {
        widget.number = widget.number + 1;
        widget.numChange(widget.number);
      });
    }
  }

  _showDialog(BuildContext context) {
    controller.text = widget.number.toString();
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          content: Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            padding: EdgeInsets.symmetric(horizontal: 30),
            decoration: BoxDecoration(
                // border: Border.all(color: textGrey, width: 1),
                // borderRadius: BorderRadius.circular(4),
                ),
            child: CartTextFiled(
              controller: controller,
            ),
          ),
          actions: [
            CupertinoDialogAction(
              child: Text(
                '取消',
                style: t16grey,
              ),
              isDestructiveAction: true,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            CupertinoDialogAction(
              child: Text(
                '确认',
                style: t16red,
              ),
              onPressed: () {
                if (controller.text.isEmpty) {
                  controller.text = '1';
                }
                var text = num.parse(controller.text);
                if (text > 99) {
                  controller.text = '99';
                }
                if (text > widget.max) {
                  controller.text = widget.max.toString();
                }
                setState(() {
                  widget.number = num.parse(controller.text);
                  widget.numChange(widget.number);
                });
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
