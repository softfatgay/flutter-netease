import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';

/// @Author: 一凨
/// @Date: 2018-12-10 21:15:27
/// @Last Modified by: 一凨
/// @Last Modified time: 2018-12-10 21:16:05

import 'package:flutter/material.dart';
import 'package:flutter_app/http/api.dart';
import 'package:flutter_app/widget/loading.dart';

class ScrollViewDemo extends StatefulWidget {
  @override
  _ScrollViewDemoState createState() => _ScrollViewDemoState();
}

class _ScrollViewDemoState extends State<ScrollViewDemo> {

  int index = 0;

  List<String> images = [
    'http://pic2.sc.chinaz.com/Files/pic/pic9/201902/zzpic16762_s.jpg',
    'http://pic2.sc.chinaz.com/Files/pic/pic9/201804/wpic629_s.jpg',
    'http://pic2.sc.chinaz.com/Files/pic/pic9/201605/apic20786_s.jpg',
    'http://pic2.sc.chinaz.com/Files/pic/pic9/201604/apic20249_s.jpg',
    'http://pic2.sc.chinaz.com/Files/pic/pic9/201603/apic19577_s.jpg',
    'http://pic.sc.chinaz.com/Files/pic/pic9/201603/apic19216_s.jpg',
    'http://pic.sc.chinaz.com/Files/pic/pic9/201503/apic10259_s.jpg',
    'http://pic.sc.chinaz.com/Files/pic/pic9/201301/xpic9393_s.jpg',
    'http://pic1.sc.chinaz.com/Files/pic/pic9/201911/zzpic20859_s.jpg',
    'http://pic1.sc.chinaz.com/Files/pic/pic9/201906/zzpic18631_s.jpg',
    'http://pic2.sc.chinaz.com/Files/pic/pic9/201905/zzpic18089_s.jpg',
    'http://pic.sc.chinaz.com/Files/pic/pic9/201904/zzpic17558_s.jpg',
    'http://pic1.sc.chinaz.com/Files/pic/pic9/201903/zzpic16921_s.jpg',
    'http://pic.sc.chinaz.com/Files/pic/pic9/201603/apic19577_s.jpg',
    'http://pic2.sc.chinaz.com/Files/pic/pic9/201804/wpic524_s.jpg',
    'http://pic2.sc.chinaz.com/Files/pic/pic9/201802/zzpic10097_s.jpg',
    'http://pic2.sc.chinaz.com/Files/pic/pic9/201710/zzpic7532_s.jpg',
    'http://pic2.sc.chinaz.com/Files/pic/pic9/201707/bpic2241_s.jpg',
    'http://pic2.sc.chinaz.com/Files/pic/pic9/201707/zzpic5038_s.jpg',
    'http://pic.sc.chinaz.com/Files/pic/pic9/201702/zzpic1137_s.jpg',
    'http://pic.sc.chinaz.com/Files/pic/pic9/201609/apic23087_s.jpg',
  ];

  PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
      return Material(
        child: Stack(
//          alignment: const FractionalOffset(0.9, 0.95), //定位方式
          children: <Widget>[
            Container(
              height: 10000, //注意这里的高度必须得指定
              child: PageView(
                controller: _pageController,
                children: buildChild(context),
                scrollDirection: Axis.vertical,
                onPageChanged: (index) {
                  setState(() {
                    this.index = index;
                  });
                },
              ),
            ),
            Positioned(
                //方法二
                bottom: 15.0,
                left: 15.0,
                child: index == 0
                    ? Container()
                    : GestureDetector(
                        onTap: () {
                          _pageController.jumpToPage(0);
                        },
                        child: Icon(Icons.vertical_align_top),
                      )),
            Positioned(
              bottom: 15.0,
              right: 15.0,
              child: Container(
                height: 30,
                width: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(color: Color(0x33000000)),
                child: Text(
                  '$index/${images.length}',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      );
  }

  List<Widget> buildChild(BuildContext context) {
    List<Widget> children = [];
    for (int i = 0; i < (images.length); i++) {
      children.add(Container(
        width: double.infinity,
        height: 1000,
        child: CachedNetworkImage(
          imageUrl: images[i],
         fit: BoxFit.cover,
        ),
      ));
    }
    return children;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageController.dispose();
  }
}
