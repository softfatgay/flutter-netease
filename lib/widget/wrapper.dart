import 'package:flutter/material.dart';

class WrapKeepState extends StatefulWidget {
  WrapKeepState(this.hocWidget);

  final Widget hocWidget;

  @override
  State<StatefulWidget> createState() {
    return _WrapKeepState();
  }
}

class _WrapKeepState extends State<WrapKeepState>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: PreferredSize(
        child: Container(
          color: Colors.green,
        ),
        preferredSize: Size(MediaQuery.of(context).size.width, 0),
      ),
      body: widget.hocWidget,
    );
    // return widget.hocWidget;
  }
}
