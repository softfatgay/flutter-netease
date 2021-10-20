import 'dart:async';

import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';

typedef void OnBtnClick(String value);

class NormalFiledClearWidget extends StatefulWidget {
  final String textValue;

  ///{@macro 输入框变化,回调时间,默认500毫秒}
  final int textChangeDuration;
  final String hintText;
  final double textFiledHeight;
  final TextEditingController controller;
  final OnBtnClick? onBtnClick;

  NormalFiledClearWidget({
    this.textValue = '',
    this.textFiledHeight = 48.0,
    required this.controller,
    this.hintText = '',
    this.textChangeDuration = 500,
    this.onBtnClick,
  });

  @override
  _SearchGoodsState createState() => _SearchGoodsState();
}

class _SearchGoodsState extends State<NormalFiledClearWidget> {
  TextEditingController? _controller;
  bool showIcon = false;

  @override
  void initState() {
    // TODO: implement initState
    if (widget.controller == null) {
      throw Exception('TextEditingController 没有初始化');
    }
    setState(() {
      _controller = widget.controller;
    });
    super.initState();
    _controller!.addListener(() {
      if (_controller!.text.toString().isNotEmpty) {
        setState(() {
          showIcon = true;
        });
      } else {
        setState(() {
          showIcon = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.controller == null) {
      throw Exception('TextEditingController 没有初始化');
    }
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6),
      height: MediaQuery.of(context).padding.top + widget.textFiledHeight,
      child: Row(
        children: <Widget>[
          SizedBox(width: 10),
          Expanded(
            child: Container(
              decoration: new BoxDecoration(
                color: Colors.grey[100],
                border: Border.all(color: Colors.grey[100]!, width: 0.1),
                borderRadius: new BorderRadius.circular(5.0),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      height: widget.textFiledHeight,
                      child: TextField(
                        style: t14black,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 0, color: Colors.transparent)),
                          disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 0, color: Colors.transparent)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 0, color: Colors.transparent)),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 0, color: Colors.transparent)),
                          contentPadding: EdgeInsets.symmetric(vertical: 0),
                          hintStyle: t14grey,
                          hintText: widget.hintText,
                        ),
                        textInputAction: TextInputAction.search,
                        onSubmitted: (text) {
                          //回车按钮
                          if (widget.onBtnClick != null) {
                            widget.onBtnClick!(text);
                          }
                        },
                        maxLines: 1,
                        onChanged: (textValue) {},
                        controller: _controller,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 8),
                    child: GestureDetector(
                      child: !showIcon
                          ? Container()
                          : Icon(
                              Icons.cancel,
                              size: 20,
                              color: textLightGrey,
                            ),
                      onTap: () {
                        setState(() {
                          _controller!.clear();
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            height: widget.textFiledHeight - 16,
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith((states) {
                  return showIcon ? backRed : Color(0xFFCCCCCC);
                  if (states.contains(MaterialState.pressed)) {
                    return backRed;
                  }
                  //默认不使用背景颜色
                  return backLightRed;
                }),
                padding: MaterialStateProperty.all(EdgeInsets.all(0)),
              ),
              child: Text(
                '兑换',
                style: t14white,
              ),
              onPressed: () {
                if (widget.onBtnClick != null && showIcon) {
                  widget.onBtnClick!(_controller!.text.toString());
                }
              },
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller!.dispose();
    super.dispose();
  }
}
