/*
 * @Description: page模块状态缓存HOC
 * @Author: luoguoxiong
 * @Date: 2019-09-02 14:31:53
 */
import 'package:flutter/material.dart';

class WrapKeepState extends StatefulWidget {
  WrapKeepState(this.hocWidget);

  final Widget hocWidget;

  @override
  State<StatefulWidget> createState() {
    return _WrapKeepState();
  }
}

class _WrapKeepState extends State<WrapKeepState> with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: new PreferredSize(
        child: new Container(
          color: Colors.green,
        ),
        preferredSize: new Size(MediaQuery.of(context).size.width, 0),
      ),
      body: widget.hocWidget,
    );
    // return widget.hocWidget;
  }
}
