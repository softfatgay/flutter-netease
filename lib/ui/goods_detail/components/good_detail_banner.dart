import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/component/indicator_banner.dart';
import 'package:flutter_app/ui/goods_detail/model/goodDetail.dart';
import 'package:flutter_app/ui/router/router.dart';

class GoodDetailBanner extends StatefulWidget {
  final VideoInfo? videoInfo;
  final List<String>? imgList;
  final double height;

  const GoodDetailBanner(
      {Key? key, this.videoInfo, this.imgList, this.height = 200})
      : super(key: key);

  @override
  _GoodDetailState createState() => _GoodDetailState();
}

class _GoodDetailState extends State<GoodDetailBanner> {
  @override
  Widget build(BuildContext context) {
    return _buildSwiper();
  }

  _buildSwiper() {
    List<String> imgList = widget.imgList!;
    final VideoInfo? videoInfo = widget.videoInfo;
    return Stack(
      children: [
        IndicatorBanner(
            dataList: imgList,
            fit: BoxFit.cover,
            height: widget.height,
            margin: EdgeInsets.all(0),
            corner: 0,
            indicatorType: IndicatorType.num,
            onPress: (index) {
              Routers.push(
                  Routers.image, context, {'images': imgList, 'page': index});
            }),
        if (videoInfo != null &&
            videoInfo.mp4VideoUrl != null &&
            videoInfo.mp4VideoUrl!.isNotEmpty)
          Positioned(
            left: 15,
            bottom: 10,
            child: GestureDetector(
              child: Container(
                height: 32,
                width: 32,
                child: Image.asset(
                  'assets/images/video_play.png',
                  height: 30,
                  width: 30,
                ),
              ),
              onTap: () {
                Routers.push(
                    Routers.videoPage, context, {'url': videoInfo.mp4VideoUrl});
              },
            ),
          ),
      ],
    );
  }
}
