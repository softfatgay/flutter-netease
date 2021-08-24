import 'package:flutter/material.dart';
import 'package:flutter_app/component/banner.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/ui/goods_detail/model/goodDetail.dart';
import 'package:flutter_app/ui/router/router.dart';

class GoodDetailBanner extends StatefulWidget {
  final VideoInfo videoInfo;
  final List<String> imgList;

  const GoodDetailBanner({Key key, this.videoInfo, this.imgList})
      : super(key: key);

  @override
  _GoodDetailState createState() => _GoodDetailState();
}

class _GoodDetailState extends State<GoodDetailBanner> {
  int _bannerIndex = 0;

  @override
  Widget build(BuildContext context) {
    return _buildSwiper();
  }

  _buildSwiper() {
    List<String> imgList = widget.imgList;
    final VideoInfo videoInfo = widget.videoInfo;
    return Stack(
      children: [
        BannerCacheImg(
          imageList: imgList,
          onIndexChanged: (index) {
            setState(() {
              _bannerIndex = index;
            });
          },
          onTap: (index) {
            Routers.push(
                Routers.image, context, {'images': imgList, 'page': index});
          },
        ),
        Positioned(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(
                color: Color(0x80FFFFFF),
                borderRadius: BorderRadius.circular(2)),
            child: Text(
              '$_bannerIndex/${imgList.length}',
              style: t12black,
            ),
          ),
          right: 15,
          bottom: 10,
        ),
        videoInfo == null ||
                videoInfo.mp4VideoUrl == null ||
                videoInfo.mp4VideoUrl == ''
            ? Container()
            : Positioned(
                left: 15,
                bottom: 10,
                child: GestureDetector(
                  child: Container(
                    height: 31,
                    width: 31,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.white),
                    child: Image.asset(
                      'assets/images/video_play.png',
                      height: 28,
                      width: 28,
                    ),
                  ),
                  onTap: () {
                    Routers.push(Routers.videoPage, context,
                        {'url': videoInfo.mp4VideoUrl});
                  },
                ),
              ),
      ],
    );
  }
}
