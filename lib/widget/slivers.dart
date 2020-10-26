import 'package:flutter/cupertino.dart';

SliverToBoxAdapter singleSliverWidget(Widget widget) {
  return SliverToBoxAdapter(
    child: widget,
  );
}

SliverGrid buildASingleSliverGrid(Widget widget, int rowCount) {
  return SliverGrid(
    delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
      return widget;
    }),
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: rowCount,
        childAspectRatio: 0.65,
        mainAxisSpacing: 3,
        crossAxisSpacing: 3),
  );
}
