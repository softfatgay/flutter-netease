import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/widget/my_under_line_tabindicator.dart';

class TabAppBar extends StatelessWidget {
  const TabAppBar({this.tabs, this.controller, this.title = ''});

  final List<String> tabs;

  final TabController controller;

  final String title;

  Widget buildAppBar(BuildContext context) {
    return new Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: new Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: lineColor, width: 0.5))),
        child: Row(
          children: <Widget>[
            InkResponse(
              child: Container(
                width: 50,
                child: Center(
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: textBlack,
                  ),
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Expanded(
              child: Center(
                child: Text(
                  title == null ? '' : title,
                  style: t16black,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Container(
              width: 50,
            ),
          ],
        ),
        height: tabs != null && tabs.length > 0 ? 48 : 56,
      ),
    );
  }

  Widget buildTabBar() {
    return Container(
        height: 40,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                bottom: BorderSide(width: 0.5, color: Color(0xFFEAEAEA)))),
        width: double.infinity,
        child: TabBar(
          isScrollable: true,
          controller: this.controller,
          labelStyle: TextStyle(fontSize: 15),
          labelColor: redColor,
          indicatorColor: Colors.red,
          unselectedLabelColor: Colors.black,
          indicator: MyUnderlineTabIndicator(
            borderSide: BorderSide(width: 2.0, color: redColor),
          ),
          tabs: tabs
              .map((f) => Tab(
                    child: Container(
                      alignment: Alignment.center,
                      height: 34,
                      child: Text(
                        f,
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ))
              .toList(),
        ));
  }

  @override
  PreferredSize build(BuildContext context) {
    return new PreferredSize(
      child: Column(
        children: tabs != null && tabs.length > 0
            ? [buildAppBar(context), buildTabBar()]
            : [buildAppBar(context)],
      ),
      preferredSize: Size(
        MediaQuery.of(context).size.width,
        tabs != null && tabs.length > 0 ? 88 : 56,
      ),
    );
  }
}
