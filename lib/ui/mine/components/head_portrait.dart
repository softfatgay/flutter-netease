import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/component/round_net_image.dart';

class HeadPortrait extends StatelessWidget {
  final String? url;

  const HeadPortrait({Key? key, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: RoundNetImage(
        url: url,
        height: 50,
        width: 50,
        corner: 25,
        fontSize: 10,
      ),
    );
  }
}
