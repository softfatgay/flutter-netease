
import 'package:flutter/material.dart';

class WidgetUtil{
  static SliverList buildASingleSliver(Widget widget) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        return SingleChildScrollView(
          child: widget,
        );
      }, childCount: 1),
    );
  }

}