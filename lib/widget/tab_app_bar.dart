import 'package:flutter/material.dart';
import 'package:flutter_app/widget/MyUnderlineTabIndicator.dart';
import 'package:flutter_app/widget/colors.dart';

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
        child: Row(
          children: <Widget>[
            InkResponse(
              child: Container(
                width: 50,
                child: Center(
                  child: Icon(
                    Icons.arrow_back,
                    color: redColor,
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
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
            ),
            Container(
              width: 50,
            ),
          ],
        ),
        height: 48,
      ),
    );
  }

  Widget buildTabBar() {
    return Container(
        height: 32,
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
                      height: 32,
                      child: Text(f),
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
        tabs != null && tabs.length > 0 ? 82 : 50,
      ),
    );
  }
}
