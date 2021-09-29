import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';

class DialogTitleWidget extends StatelessWidget {
  final String title;

  const DialogTitleWidget({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: lineColor, width: 1))),
      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 15),
      width: double.infinity,
      child: Stack(
        children: [
          Center(
            child: Text(
              '${title ?? ''}',
              style: t16black,
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: GestureDetector(
              child: Container(
                alignment: Alignment.centerRight,
                child: Image.asset(
                  'assets/images/close.png',
                  width: 20,
                  height: 20,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
