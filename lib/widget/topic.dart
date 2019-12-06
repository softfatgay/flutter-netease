import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:toast/toast.dart';

class Topic extends StatelessWidget {
  final List data;
  final BuildContext context;

  Topic(this.data, this.context);

  @override
  Widget build(BuildContext context) {
    List imageUrl = [];
    data.forEach((item) => imageUrl.add(item));
    return Container(
      width: double.infinity,
      height: 240,
      child: Swiper(
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: <Widget>[
                Container(
                  height: 200,
                  child: CachedNetworkImage(
                    imageUrl: imageUrl[index]['scene_pic_url'],
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  height: 20,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text.rich(TextSpan(children: [
                      TextSpan(
                          text: imageUrl[index]['title'],
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold)),
                      TextSpan(
                          text: '￥${imageUrl[index]['price_info']}元起',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.red,
                              fontWeight: FontWeight.bold))
                    ])),
                  ),
                ),
                Container(
                  height: 20,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      imageUrl[index]['subtitle'],
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ),
                )
              ],
            ),
          );
        },

        controller: SwiperController(),
        scrollDirection: Axis.horizontal,
        onTap: (index){
          Toast.show('点击了$index', context);
        },
        viewportFraction: 0.8,
      ),
    );
  }
}
