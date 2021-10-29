import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/component/my_under_line_tabindicator.dart';

class TabAppBar extends StatelessWidget {
  const TabAppBar({
    this.tabs = const [],
    this.controller,
    this.title = '',
    this.scrollable = true,
  });

  final List<String?> tabs;

  final TabController? controller;

  final String title;
  final bool scrollable;

  Widget buildAppBar(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Container(
        child: Row(
          children: <Widget>[
            TextButton(
              child: Image.asset(
                'assets/images/back.png',
                height: 25,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Expanded(
              child: Text(
                '$title',
                style: t16black,
                maxLines: 1,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Container(
              width: 50,
            ),
          ],
        ),
        height: tabs.isNotEmpty ? 40 : 56,
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
          isScrollable: scrollable,
          controller: this.controller,
          labelStyle: TextStyle(fontSize: 15),
          labelColor: redColor,
          indicatorColor: Colors.red,
          unselectedLabelColor: Colors.black,
          indicator: MyUnderlineTabIndicator(
            borderSide: BorderSide(width: 2.0, color: redColor),
          ),
          tabs: tabs
              .map((tv) => Tab(
                    child: Container(
                      alignment: Alignment.center,
                      height: 34,
                      child: Text(
                        '${tv ?? ''}',
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
        children: tabs.isNotEmpty
            ? [buildAppBar(context), buildTabBar()]
            : [buildAppBar(context)],
      ),
      preferredSize: Size(
        MediaQuery.of(context).size.width,
        tabs.isNotEmpty ? 80 : 56,
      ),
    );
  }
}
