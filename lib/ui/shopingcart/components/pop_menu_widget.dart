import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';

class PopMenuWidet extends StatefulWidget {
  final Widget child;

  const PopMenuWidet({Key key, this.child}) : super(key: key);

  @override
  _PopMenuState createState() => _PopMenuState();
}

class _PopMenuState extends State<PopMenuWidet> {
  bool _showPopMenu = false;

  @override
  Widget build(BuildContext context) {
    return _widget();
  }

  _widget() {
    return _showPopMenu
        ? Container(
            color: Color(0X4D000000),
            child: Column(
              children: [
                Container(
                  color: backWhite,
                  child: widget.child,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _showPopMenu = false;
                      });
                    },
                  ),
                ),
              ],
            ),
          )
        : Container();
  }
}
