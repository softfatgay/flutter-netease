import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';

typedef void OnCheckChanged(bool check);

class CartCheckBox extends StatefulWidget {
  final OnCheckChanged onCheckChanged;

  const CartCheckBox({Key key, this.onCheckChanged}) : super(key: key);

  @override
  _CartCheckBoxState createState() => _CartCheckBoxState();
}

class _CartCheckBoxState extends State<CartCheckBox> {
  bool check = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.onCheckChanged != null) {
          setState(() {
            check = !check;
          });
          widget.onCheckChanged(check);
        }
      },
      child: Container(
        child: Padding(
          padding: EdgeInsets.all(2),
          child: check
              ? Icon(
                  Icons.check_circle,
                  size: 22,
                  color: Colors.red,
                )
              : Icon(
                  Icons.brightness_1_outlined,
                  size: 22,
                  color: lineColor,
                ),
        ),
      ),
    );
  }
}
