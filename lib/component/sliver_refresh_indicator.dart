import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef void Refresh();

class SliverRefreshIndicator extends StatelessWidget {
  final Refresh refresh;
  final bool top;

  const SliverRefreshIndicator(
      {Key? key, required this.refresh, this.top = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _indicator(context);
  }

  Widget _indicator(BuildContext context) {
    return CupertinoSliverRefreshControl(
      refreshIndicatorExtent: 20,
      refreshTriggerPullDistance: 120,
      builder: (context, refreshState, pulledExtent, refreshTriggerPullDistance,
          refreshIndicatorExtent) {
        return Container(
          padding: EdgeInsets.only(
              top: (top ? MediaQuery.of(context).padding.top : 0) +
                  pulledExtent / 3),
          child: pulledExtent > MediaQuery.of(context).padding.top
              ? CupertinoActivityIndicator(radius: 15)
              : Container(),
        );
      },
      onRefresh: () async {
        refresh();
      },
    );
  }
}
