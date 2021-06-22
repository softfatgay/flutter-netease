import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/utils/router.dart';

class TopSearch extends StatelessWidget {
  final bool abool;

  const TopSearch({Key key, this.abool = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildSearch(context);
  }

  _buildSearch(BuildContext context) {
    Widget widget = Container(
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "网易严选",
              style: abool ? t16black : t16grey,
            ),
          ),
          Expanded(
            child: Container(
              height: 35,
              width: double.infinity,
              margin: EdgeInsets.fromLTRB(0, 10, 15, 10),
              decoration: BoxDecoration(
                color: abool
                    ? Color.fromARGB(255, 237, 237, 237)
                    : Color.fromARGB(50, 237, 237, 237),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.search,
                    size: 20,
                    color: textGrey,
                  ),
                  Expanded(
                    child: Text(
                      "搜索商品，共30000+款好物",
                      style: t12grey,
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
