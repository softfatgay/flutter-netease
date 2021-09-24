import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/component/app_bar.dart';

class FullScreenImage extends StatefulWidget {
  final Map params;

  const FullScreenImage(this.params);

  @override
  _FullScreenImageState createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage> {
  List<String> _images = [];
  int initPage = 0;

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      _images = widget.params['images'];
      var page = widget.params['page'];
      if (page != null) {
        initPage = page;
      }
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
                    initialPage: initPage,
                    autoPlay: false,
                    height: double.infinity,
                    viewportFraction: 1.0,
                    enlargeCenterPage: true,
                    onPageChanged: (index, reason) {
                      setState(() {});
                    }),
              ),
              _buildTop(),
            ],
          )),
    );
  }

  _buildTop() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: new Container(
        child: Row(
          children: <Widget>[
            InkResponse(
              child: Container(
                width: 50,
                child: Center(
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: backColor,
                  ),
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
        height: 50,
      ),
    );
  }
}
