import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget back;
  final TabBar widget;
  final Color color;

  const SliverTabBarDelegate(this.widget, {this.color, this.back})
      : assert(widget != null);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      child: widget,
      color: color,
    );
  }

  @override
  bool shouldRebuild(SliverTabBarDelegate oldDelegate) {
    return false;
  }

  @override
  double get maxExtent => widget.preferredSize.height;

  @override
  double get minExtent => widget.preferredSize.height;
}


