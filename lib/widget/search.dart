import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/utils/router.dart';
import 'package:flutter_app/utils/util_mine.dart';

class SearchWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return buildSearch(context);
  }

  Widget buildSearch(BuildContext context) {
    Widget widget = Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 237, 237, 237),
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
          Text(
            "搜索商品，共30000+款好物",
            style: t12grey,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
    return Routers.link(widget, Routers.search, context, {'id': ''});
  }
}
