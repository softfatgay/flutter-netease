import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/utils/router.dart';
import 'package:flutter_app/widget/app_bar.dart';
import 'package:flutter_app/widget/tab_app_bar.dart';

class FullScreenImage extends StatefulWidget {
  final Map arguments;

  const FullScreenImage(this.arguments);

  @override
  _FullScreenImageState createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Listener(
          onPointerMove: (move) {
            Router.pop(context);
          },
          child: Stack(
            children: <Widget>[
              Center(
                child: Container(
                  child: CachedNetworkImage(
                    imageUrl: widget.arguments['id'],
                  ),
                ),
              ),
              Appbar(title: '')
            ],
          )),
    );
  }
}
