import 'dart:math';
import 'dart:ui';

import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';

typedef void OnValueChanged(String value);
typedef void OnSearchBtnClick(String value);

class SearchWidget extends StatefulWidget {
  final String textValue;
  final String hintText;
  final double textFiledHeight;
  final TextEditingController controller;
  final OnValueChanged onValueChangedCallBack;
  final OnSearchBtnClick onSearchBtnClick;

  SearchWidget(
      {this.textValue,
      this.textFiledHeight = 48.0,
      @required this.controller,
      this.hintText,
      this.onSearchBtnClick,
      this.onValueChangedCallBack});

  @override
  _SearchGoodsState createState() => _SearchGoodsState();
}

class _SearchGoodsState extends State<SearchWidget> {
  String text;

  @override
  Widget build(BuildContext context) {
    if (widget.controller == null) {
      throw Exception('TextEditingController 没有初始化');
    }
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      height: MediaQuery.of(context).padding.top + widget.textFiledHeight,
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(width: 0.5, color: Colors.grey[200]))),
      child: Row(
        children: <Widget>[
          GestureDetector(
            child: Container(
              height: widget.textFiledHeight,
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Icon(Icons.arrow_back),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          Expanded(
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: new BoxDecoration(
                      color: Colors.grey[100],
                      border: Border.all(color: Colors.grey[400], width: 0.5),
                      borderRadius: new BorderRadius.circular(20.0)),
                  margin: EdgeInsets.symmetric(vertical: 5),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 8),
                          height: widget.textFiledHeight,
                          child: TextField(
                            style: TextStyle(
                                textBaseline: TextBaseline.alphabetic),
                            decoration: InputDecoration(
                                hintText: TextUtil.isEmpty(widget.hintText)
                                    ? ''
                                    : widget.hintText,
                                border: InputBorder.none),
                            textInputAction: TextInputAction.search,
                            onSubmitted: (text) {
                              //回车按钮
                              if (widget.onSearchBtnClick != null) {
                                widget.onSearchBtnClick(text);
                              }
                            },
                            maxLines: 1,
                            onChanged: (textValue) {
                              setState(() {
                                this.text = textValue;
                              });
                              if (widget.onValueChangedCallBack != null) {
                                widget.onValueChangedCallBack(text);
                              }
                            },
                            controller: widget.controller,
                          )),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 8),
                      child: GestureDetector(
                        child: TextUtil.isEmpty(text)
                            ? Container()
                            : Icon(
                                Icons.cancel,
                              ),
                        onTap: () {
                          widget.controller.clear();
                          setState(() {
                            text = '';
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
            height: widget.textFiledHeight,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: GestureDetector(
              child: Center(
                child: Text('搜索'),
              ),
              onTap: () {
                if (widget.onSearchBtnClick != null) {
                  widget.onSearchBtnClick(text);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
