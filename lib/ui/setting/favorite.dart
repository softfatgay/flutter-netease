import 'package:flutter/material.dart';

const lightColor = Color.fromRGBO(255, 255, 255, 0.85);
const darkColor = Color.fromRGBO(1, 1, 1, 0.35);

class Favorite extends StatefulWidget {
  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(

    child: Center(
      child: Container(

      ),
    ),

    );
  }


//  VideoPlayerController videoPlayerController;
//  ChewieController chewieController;
//  String url = 'https://media.w3.org/2010/05/sintel/trailer.mp4';
//
//  var startHor;
//  var endHor;
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//        appBar: TabAppBar(
//          title: '视频播放',
//        ).build(context),
//        body: Column(
//          children: <Widget>[
//            Container(
//              width: double.infinity,
//              child: GestureDetector(
//                child: Stack(
//                  children: <Widget>[
//                    Chewie(
//                      controller: chewieController,
//                    ),
//                  ],
//                ),
//                onHorizontalDragUpdate: (startDetail) {
//                  setState(() {});
//                },
//              ),
//            ),
//          ],
//        ));
//  }
//
//  @override
//  void initState() {
//    // TODO: implement initState
//    super.initState();
//    videoPlayerController = VideoPlayerController.network(url);
//    chewieController = ChewieController(
//      videoPlayerController: videoPlayerController,
//      autoPlay: true,
//      title: '哈哈哈哈',
//      showControls: true,
//      allowFullScreen: true,
//      allowedScreenSleep: false,
//      placeholder: Container(
//          width: double.infinity,
//          child: Image.asset(
//            'assets/images/boduoxiaojie.png',
//            fit: BoxFit.fill,
//          )),
//    );
//  }
//
//  @override
//  void dispose() {
//    // TODO: implement dispose
//    super.dispose();
//    videoPlayerController.dispose();
//    chewieController.dispose();
//  }
}
