import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/widget/tab_app_bar.dart';

class QRCodeMine extends StatefulWidget {
  @override
  _QRCodeMineState createState() => _QRCodeMineState();
}

class _QRCodeMineState extends State<QRCodeMine> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TabAppBar().build(context),
      body: Stack(
        children: [
          Container(
          margin: EdgeInsets.only(top: 40),
            height: 400,
            color: Colors.white,
          ),
          Container(
            height: 80,
            child: ClipOval(
              child: CachedNetworkImage(imageUrl: 'http://yanxuan.nosdn.127.net/8945ae63d940cc42406c3f67019c5cb6.png'),
            ),
          )
        ],
      ),
    );
  }
}
