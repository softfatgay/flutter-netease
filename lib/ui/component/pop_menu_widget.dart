import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';

typedef void ClosePop();

class PopMenuWidet extends StatelessWidget {
  final Widget? child;
  final bool showPopMenu;
  final ClosePop? closePop;

  const PopMenuWidet(
      {Key? key, this.child, this.showPopMenu = false, this.closePop})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _widget();
  }

  _widget() {
    return child == null
        ? Container()
        : showPopMenu
            ? Container(
                color: Color(0X4D000000),
                child: Column(
                  children: [
                    Container(
                      color: backWhite,
                      child: child,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          if (closePop != null) {
                            closePop!();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              )
            : Container();
  }
}
