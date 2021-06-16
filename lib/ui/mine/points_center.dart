import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/utils/router.dart';
import 'package:flutter_app/utils/user_config.dart';
import 'package:flutter_app/utils/util_mine.dart';
import 'package:flutter_app/widget/back_loading.dart';
import 'package:flutter_app/widget/head_portrait.dart';
import 'package:flutter_app/widget/slivers.dart';
import 'package:flutter_app/widget/swiper.dart';
import 'package:flutter_app/widget/tab_app_bar.dart';

class PointCenter extends StatefulWidget {
  @override
  _PointCenterState createState() => _PointCenterState();
}

class _PointCenterState extends State<PointCenter> {
  bool _isLoading = true;

  var data;
  List banner, bannerData = List();

  String topback =
      'https://yanxuan.nosdn.127.net/6b49731e1ed23979a89f119048785bba.png';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPoint();
  }

  void getPoint() async {
    Map<String, dynamic> params = {};
    Map<String, dynamic> header = {"Cookie": cookie};

    var responseData = await pointCenter(params, header: header);
    setState(() {
      _isLoading = false;
      data = responseData.data;
      bannerData = data['ponitBanners'];
      banner = bannerData
          .map((item) => Container(
                margin: EdgeInsets.all(15),
                child: CachedNetworkImage(
                  imageUrl: item['picUrl'],
                  fit: BoxFit.fitWidth,
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: TabAppBar(
        title: '积分中心',
      ).build(context),
      body: _isLoading ? Loading() : _buildBody(),
    );
  }

  _buildBody() {
    return CustomScrollView(
      slivers: [
        singleSliverWidget(_buildTop()),
        _buildSwiper(),
        singleSliverWidget(_line(10.0)),
        singleSliverWidget(Image.asset('assets/images/point_banner.png')),
        singleSliverWidget(SizedBox(height: 15)),
        singleSliverWidget(_buildTitle('积分惊喜兑', '每周四10点开抢', '每期兑换1件')),
        singleSliverWidget(SizedBox(height: 15)),
        _buildactivity(),
        singleSliverWidget(SizedBox(height: 15)),
        singleSliverWidget(_buildTitle('2积分兑换生活权益', '权益使用详见规则', '')),
        singleSliverWidget(SizedBox(height: 15)),
        _buildactivity2(),
        singleSliverWidget(SizedBox(height: 15)),
        singleSliverWidget(_line(10.0)),
        singleSliverWidget(Image.asset('assets/images/point_banner2.png')),
        singleSliverWidget(SizedBox(height: 15)),
        _buildChangePoint()
      ],
    );
  }

  _buildTop() {
    return Container(
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: NetworkImage(
              topback,
            ),
            fit: BoxFit.fill),
      ),
      height: 150,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: 20),
          HeadPortrait(
            url:
                'https://yanxuan.nosdn.127.net/8945ae63d940cc42406c3f67019c5cb6.png',
          ),
          SizedBox(width: 5),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '你的可用积分：${data['availablePoint']}',
                style: t16whiteblod,
              ),
              Container(
                margin: EdgeInsets.only(top: 5),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 1),
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  '普通会员',
                  style: t12white,
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  //轮播图
  _buildSwiper() {
    return SliverToBoxAdapter(
      child: banner == null
          ? Container()
          : SwiperView(
              banner,
              onTap: (index) {
                _goWebview('${bannerData[index]["targetUrl"]}');
              },
              height: 110,
            ),
    );
  }

  _goWebview(String url) {
    print(url);
    Routers.push(Routers.webView, context, {'url': url});
  }

  _buildTitle(String title, String dec, String act) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                width: 15,
              ),
              Container(
                height: 13,
                width: 3,
                color: Colors.black,
                margin: EdgeInsets.only(right: 5),
              ),
              Text(
                '$title',
                style: t14blackBold,
              ),
              act == ''
                  ? Container()
                  : Container(
                      margin: EdgeInsets.only(left: 5),
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: textYellow, width: 1)),
                      child: Text(
                        '$act',
                        style: TextStyle(color: textYellow, fontSize: 10),
                      ),
                    ),
              SizedBox(
                width: 15,
              )
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            margin: EdgeInsets.only(left: 15),
            child: Text('$dec'),
          )
        ],
      ),
    );
  }

  Widget _line(double height) {
    return Container(
      height: height,
      color: lineColor,
    );
  }

  _buildactivity() {
    var pointExVirtualAct = data['pointExVirtualAct'];
    List activitys = pointExVirtualAct['actPackets'];
    return SliverGrid.count(
      crossAxisCount: 3,
      children: activitys.map<Widget>((item) {
        Widget widget = Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: textYellow, width: 0.5)),
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: item['picUrl'],
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                '${item['title']}',
                style: t12blackbold,
              ),
              Text(
                '${item['needPoint']}积分兑',
                style: TextStyle(
                    color: textYellow,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        );
        return Routers.link(widget, Routers.webView, context, {
          "url":
              'https://m.you.163.com/points/exVirtual/actPacket?actId=${pointExVirtualAct['actId']}&actPacketId=${item['actPacketId']}&actPacketGiftId=${item['actPacketGiftId']}'
        });
      }).toList(),
    );
  }

  _buildactivity2() {
    var pointExVirtualAct = data['pointExExternalRights'];
    List activitys = pointExVirtualAct['actPackets'];
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      sliver: SliverGrid.count(
        crossAxisCount: 2,
        childAspectRatio: 1.3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: activitys.map<Widget>((item) {
          Widget widget = Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: lineColor,
                      offset: Offset(0.0, 5.0), //阴影y轴偏移量
                      blurRadius: 1, //阴影模糊程度
                      spreadRadius: -4 //阴影扩散程度
                      )
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    child: CachedNetworkImage(
                  imageUrl: item['picUrl'],
                  fit: BoxFit.fill,
                )),
                SizedBox(
                  height: 5,
                ),
                Container(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    '${item['title']}',
                    style: t12blackbold,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    '${item['needPoint']}积分兑',
                    style: TextStyle(
                        color: textYellow,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          );
          return Routers.link(widget, Routers.webView, context, {
            "url":
                'https://m.you.163.com/points/exVirtual/actPacket?actId=${pointExVirtualAct['actId']}&actPacketId=${item['actPacketId']}&actPacketGiftId=${item['actPacketGiftId']}'
          });
        }).toList(),
      ),
    );
  }

  _buildChangePoint() {
    var exchangeModule = data['exchangeModule'];
    List pointCommodities = exchangeModule['pointCommodities'];
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      sliver: SliverGrid.count(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: pointCommodities.map<Widget>((item) {
          Widget widget = Container(
            decoration:
                BoxDecoration(border: Border.all(color: lineColor, width: 1)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    width: double.infinity,
                    child: CachedNetworkImage(
                      imageUrl: item['picUrl'],
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            '${item['name']}',
                            style: t14black,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            '${item['needPoint']}积分兑',
                            style: TextStyle(
                                color: redLightColor,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          );
          return Routers.link(
              widget, Routers.goodDetailTag, context, {'id': item['itemId']});
        }).toList(),
      ),
    );
  }
}
