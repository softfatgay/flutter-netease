import 'dart:async';

import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';

typedef void OnValueChanged(String value);
typedef void OnBtnClick(String value);

class SearchWidget extends StatefulWidget {
  final String textValue;
  final double paddingV;

  ///{@macro 输入框变化,回调时间,默认500毫秒}
  final int textChangeDuration;
  final String hintText;
  final double searchHeight;
  final TextEditingController controller;
  final OnValueChanged onValueChangedCallBack;
  final OnBtnClick onBtnClick;

  SearchWidget(
      {this.textValue = '',
      this.searchHeight = 48.0,
      this.paddingV = 8,
      @required this.controller,
      this.hintText,
      this.textChangeDuration = 500,
      this.onBtnClick,
      this.onValueChangedCallBack});

  @override
  _SearchGoodsState createState() => _SearchGoodsState();
}

class _SearchGoodsState extends State<SearchWidget> {
  TextEditingController _controller;

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
  }

  @override
  Widget build(BuildContext context) {
    if (widget.controller == null) {
      throw Exception('TextEditingController 没有初始化');
    }
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      height: MediaQuery.of(context).padding.top + widget.searchHeight,
      // decoration: BoxDecoration(
      //     border:
      //         Border(bottom: BorderSide(width: 0.5, color: Colors.grey[200]))),
      child: Row(
        children: <Widget>[
          SizedBox(width: 10),
          Expanded(
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: new BoxDecoration(
                      color: Colors.grey[100],
                      border: Border.all(color: Colors.grey[100], width: 0.1),
                      borderRadius: new BorderRadius.circular(5.0)),
                  margin: EdgeInsets.symmetric(vertical: widget.paddingV),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 8),
                      child: Image.asset(
                        'assets/images/search_edit_icon.png',
                        width: 14,
                        height: 14,
                      ),
                    ),
                    Expanded(
                      child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 8),
                          height: widget.searchHeight,
                          child: TextField(
                            style: t14black,
                            decoration: InputDecoration(
                                hintText: TextUtil.isEmpty(widget.hintText)
                                    ? ''
                                    : widget.hintText,
                                border: InputBorder.none),
                            textInputAction: TextInputAction.search,
                            onSubmitted: (text) {
                              //回车按钮
                              setState(() {
                                if (widget.onBtnClick != null) {
                                  widget.onBtnClick(text);
                                }
                              });
                            },
                            maxLines: 1,
                            onChanged: (textValue) {
                              _startTimer(textValue);
                            },
                            controller: _controller,
                          )),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 8),
                      child: GestureDetector(
                        child: TextUtil.isEmpty(_controller.text)
                            ? Container()
                            : Icon(
                                Icons.cancel,
                                size: 20,
                                color: textLightGrey,
                              ),
                        onTap: () {
                          setState(() {
                            _controller.clear();
                            widget.onValueChangedCallBack('');
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: 60,
            height: widget.searchHeight,
            margin: EdgeInsets.symmetric(vertical: widget.paddingV),
            padding: EdgeInsets.symmetric(horizontal: 6),
            child: Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  elevation: 0,
                  textStyle: TextStyle(color: Colors.black),
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                ),
                onPressed: () {
                  if (widget.onBtnClick != null) {
                    widget.onBtnClick(_controller.text);
                  }
                },
                child: Text(
                  '取消',
                  style: t16black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Timer timer;

  _startTimer(String value) {
    if (timer != null) {
      timer.cancel();
    }
    timer = Timer(Duration(milliseconds: widget.textChangeDuration), () {
      setState(() {
        // _controller.text = value.trim();
        if (widget.onValueChangedCallBack != null) {
          widget.onValueChangedCallBack(_controller.text);
        }
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if (timer != null) {
      timer.cancel();
      timer = null;
    }
  }
}
