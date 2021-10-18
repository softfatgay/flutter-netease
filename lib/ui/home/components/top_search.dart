import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/ui/router/router.dart';

class TopSearch extends StatelessWidget {
  final bool abool;
  final num? totalNum;

  const TopSearch({Key? key, this.abool = true, this.totalNum = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildSearch(context);
  }

  _buildSearch(BuildContext context) {
    Widget widget = Container(
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 5),
            child: Image.asset(
              'assets/images/logo_text.png',
              height: 18,
              // color: Colors.white,
            ),
          ),
          Expanded(
            child: Container(
              height: 30,
              width: double.infinity,
              margin: EdgeInsets.fromLTRB(0, 10, 10, 10),
              decoration: BoxDecoration(
                color: backColor,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 5,
                  ),
                  Image.asset(
                    'assets/images/search_edit_icon.png',
                    width: 14,
                    height: 14,
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      "搜索商品，共$totalNum款好物",
                      style: t12black,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
    List _roundWords = ['零食', '茅台酒', '床上用品', '衣服', '玩具', '奶粉', '背包'];

    return Routers.link(widget, Routers.search, context,
        {'id': _roundWords[Random().nextInt(6)]});
  }
}
