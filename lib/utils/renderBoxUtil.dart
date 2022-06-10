import 'package:flutter/material.dart';

class RenderBoxUtil {
  static double offsetY(BuildContext context, GlobalKey globalKey) {
    RenderBox renderObject =
        globalKey.currentContext!.findRenderObject() as RenderBox;
    var offset = renderObject.localToGlobal(Offset.zero);
    return offset.dy;
  }
}
