import 'package:flutter/material.dart';
import 'package:flutter_app/widget/MyUnderlineTabIndicator.dart';
import 'package:flutter_app/widget/colors.dart';

class TabAppBar extends StatelessWidget {
  const TabAppBar({this.tabs, this.controller, this.title});

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
                    color: Colors.black,
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
                  title,
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
            ),
            Container(
              width: 50,
            ),
          ],
        ),
        height: 44,
      ),
    );
  }

  Widget buildTabBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(width: 0.5,color: Color(0xFFEAEAEA)))
      ),

        width: double.infinity,
        child: TabBar(
          isScrollable: true,
          controller: this.controller,
          labelStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          labelColor: redColor,
          unselectedLabelColor: Colors.black45,
          indicator: MyUnderlineTabIndicator(
            borderSide: BorderSide(width: 2.0, color: redColor),
          ),
          indicatorWeight: 2,
          tabs: tabs.map((item) {
            return Expanded(
                child: Container(
              height: 30,
              child: Center(child: Text(item)),
            ));
          }).toList(),
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
