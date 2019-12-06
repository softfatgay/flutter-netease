import 'dart:async';

import 'package:common_utils/common_utils.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/utils/router.dart';
import 'package:flutter_app/utils/util_mine.dart';
import 'package:flutter_app/widget/search_widget.dart';

class SearchGoods extends StatefulWidget {
  final Map arguments;

  SearchGoods({this.arguments});

  @override
  _SearchGoodsState createState() => _SearchGoodsState();
}

class _SearchGoodsState extends State<SearchGoods> {
  TextEditingController controller = TextEditingController();
  bool isSearch = false;
  Timer timer;
  String textValue = '';

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: <Widget>[
//          _showPop(),
          !isSearch ? Container() : _showPop(),
          SearchWidget(
            hintText: '输入搜索',
            controller: controller,
            onValueChangedCallBack: (value) {
              _startTimer(value);
            },
            onSearchBtnClick: (value) {
              setState(() {
                textValue = value;
                isSearch = true;
              });
            },
          ),
        ],
      ),
    );
  }

  _startTimer(String value) {
    isSearch = false;

    if (timer != null) {
      timer.cancel();
    }
    timer = Timer(Duration(seconds: 1), () {
      setState(() {
        textValue = value;
        isSearch = true;
      });
    });
  }

  Widget _showPop() {
    List itemList = [];
    for (int i = 0; i < 10; i++) {
      var wordPair = new WordPair.random();
      itemList.add(wordPair.toString());
    }
    return CustomScrollView(
      slivers: <Widget>[
        SliverList(
          delegate:
              SliverChildBuilderDelegate((BuildContext context, int index) {
            return Container(
              height: MediaQuery.of(context).padding.top + 50,
            );
          }, childCount: 1),
        ),
        SliverGrid(
          delegate:
              SliverChildBuilderDelegate((BuildContext context, int index) {
            Widget widget = Container(
                height: 30,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 0.5),
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                width: double.infinity,
                child: Center(
                  child: Text(
                    itemList[index],
                    textAlign: TextAlign.center,
                  ),
                ));
            return Router.link(
                widget, Util.goodDetailTag, context, {'id': 1011004});
          }, childCount: 10),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 1.5,
          ),
        ),
        SliverList(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
          Widget widget = Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: 20),
            child: Text(
              '搜索历史',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
          );
          return widget;
        }, childCount: 1)),
        SliverList(
          delegate:
              SliverChildBuilderDelegate((BuildContext context, int index) {
            Widget widget = Container(
              height: 50,
              width: 100,
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 0.5),
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: Text('关键字  :$textValue'),
            );
            return Router.link(
                widget, Util.goodDetailTag, context, {'id': 1011004});
          }, childCount: 1),
        ),
      ],
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }
}
