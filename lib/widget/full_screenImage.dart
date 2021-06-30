import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/widget/app_bar.dart';

class FullScreenImage extends StatefulWidget {
  final Map arguments;

  const FullScreenImage(this.arguments);

  @override
  _FullScreenImageState createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage> {
  List<String> _images = [];

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      _images = widget.arguments['images'];
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Listener(
          onPointerMove: (move) {
            // Routers.pop(context);
          },
          child: Stack(
            children: <Widget>[
              CarouselSlider(
                items: _images.map<Widget>((e) {
                  return GestureDetector(
                    child: Container(
                      child: CachedNetworkImage(
                        imageUrl: e,
                      ),
                    ),
                    onTap: () {
                      // Routers.push(Util.webView, context, {'url': e.targetUrl});
                      Navigator.pop(context);
                    },
                  );
                }).toList(),
                options: CarouselOptions(
                    autoPlay: true,
                    height: double.infinity,
                    viewportFraction: 1.0,
                    enlargeCenterPage: true,
                    onPageChanged: (index, reason) {
                      setState(() {});
                    }),
              ),
              Appbar(
                title: '',
                backcolor: Colors.white,
              )
            ],
          )),
    );
  }
}
