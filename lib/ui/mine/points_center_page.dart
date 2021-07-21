import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/model/itemListItem.dart';
import 'package:flutter_app/ui/mine/model/pointsModel.dart';
import 'package:flutter_app/ui/sort/good_item_normal.dart';
import 'package:flutter_app/ui/sort/good_item_widget.dart';
import 'package:flutter_app/utils/router.dart';
import 'package:flutter_app/utils/user_config.dart';
import 'package:flutter_app/widget/back_loading.dart';
import 'package:flutter_app/widget/head_portrait.dart';
import 'package:flutter_app/widget/slivers.dart';
import 'package:flutter_app/widget/swiper.dart';
import 'package:flutter_app/widget/tab_app_bar.dart';
import 'package:flutter_app/widget/top_round_net_image.dart';

class PointCenterPage extends StatefulWidget {
  @override
  _PointCenterPageState createState() => _PointCenterPageState();
}

class _PointCenterPageState extends State<PointCenterPage> {
  bool _isLoading = true;

  PointsModel _data;
  List _banner = [];
  List<PonitBannersItem> _bannerData = [];
  List<ItemListItem> _rcmdDataList = [];

  String _topback =
      'https://yanxuan.nosdn.127.net/6b49731e1ed23979a89f119048785bba.png';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPoint();
    _rcmd();
  }

  _rcmd() async {
    var responseData = await pointsRcmd();

    List data = responseData.data;
    List<ItemListItem> dataList = [];
    data.forEach((element) {
      dataList.add(ItemListItem.fromJson(element));
    });
    setState(() {
      _rcmdDataList = dataList;
    });
  }

  void getPoint() async {
    var responseData = await pointCenter();
    setState(() {
      _isLoading = false;
      _data = PointsModel.fromJson(responseData.data);
      _bannerData = _data.ponitBanners;
      _banner = _bannerData
          .map((item) => Container(
                margin: EdgeInsets.all(15),
                child: CachedNetworkImage(
                  imageUrl: item.picUrl,
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
        _buildChangePoint(),
        singleSliverWidget(_rcmTitle()),
        singleSliverWidget(_buildTitle('精选超值年购', '', '')),
        _rcmdOne(),
        singleSliverWidget(SizedBox(height: 25)),
        singleSliverWidget(_buildTitle('精选返积分商品', '', '')),
        GoodItemNormalWidget(dataList: _rcmdDataList)
      ],
    );
  }

  _buildTop() {
    return Container(
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            _topback,
          ),
          fit: BoxFit.fill,
        ),
      ),
      height: 150,
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 20),
              HeadPortrait(url: '$user_icon_url'),
              SizedBox(width: 5),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '你的可用积分：${_data.availablePoint}',
                    style: t16whiteblod,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 1),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text('普通会员', style: t12white),
                  ),
                ],
              )
            ],
          ),
          Positioned(
            right: 10,
            top: 20,
            child: GestureDetector(
              child: Container(
                child: Text(
                  '积分规则',
                  style: t14white,
                ),
              ),
              onTap: () {
                Routers.push(Routers.webView, context,
                    {'url': 'https://m.you.163.com/help/new#/36/81'});
              },
            ),
          ),
          Positioned(
            right: 0,
            top: 50,
            child: GestureDetector(
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 10),
                height: 30,
                decoration: BoxDecoration(
                  color: backWhite,
                  borderRadius:
                      BorderRadius.horizontal(left: Radius.circular(15)),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/menu_icon.png',
                      width: 20,
                      height: 20,
                    ),
                    Text(
                      '账单',
                      style: t14Yellow,
                    ),
                  ],
                ),
              ),
              onTap: () {
                Routers.push(Routers.webView, context,
                    {'url': 'https://m.you.163.com/points/detail'});
              },
            ),
          ),
        ],
      ),
    );
  }

  //轮播图
  _buildSwiper() {
    return SliverToBoxAdapter(
      child: _banner == null
          ? Container()
          : SwiperView(
              _banner,
              onTap: (index) {
                _goWebview('${_bannerData[index].targetUrl}');
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
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: textYellow, width: 1)),
                      child: Text(
                        '$act',
                        style: t10Yellow,
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

  _line(double height) {
    return Container(
      height: height,
      color: backColor,
    );
  }

  _buildactivity() {
    var pointExVirtualAct = _data.pointExVirtualAct;
    List<ActPackets> activitys = pointExVirtualAct.actPackets;
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
                      imageUrl: item.picUrl,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                '${item.title}',
                style: t12blackbold,
              ),
              Text(
                '${item.needPoint}积分兑',
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
              'https://m.you.163.com/points/exVirtual/actPacket?actId=${pointExVirtualAct.actId}&actPacketId=${item.actPacketId}&actPacketGiftId=${item.actPacketGiftId}'
        });
      }).toList(),
    );
  }

  _buildactivity2() {
    var pointExVirtualAct = _data.pointExExternalRights;
    List<ActPackets> activitys = pointExVirtualAct.actPackets;
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
              borderRadius: BorderRadius.circular(4),
              color: backColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: TopRoundNetImage(
                    url: item.picUrl,
                    corner: 4,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Text(
                    '${item.title}',
                    style: t12blackbold,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 10, bottom: 10),
                  child: Text(
                    '${item.needPoint}积分兑',
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
                'https://m.you.163.com/points/exVirtual/actPacket?actId=${pointExVirtualAct.actId}&actPacketId=${item.actPacketId}&actPacketGiftId=${item.actPacketGiftId}'
          });
        }).toList(),
      ),
    );
  }

  _buildChangePoint() {
    var exchangeModule = _data.exchangeModule;
    List<PointCommoditiesItem> pointCommodities =
        exchangeModule.pointCommodities;
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
                      imageUrl: item.picUrl,
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
                            '${item.name}',
                            style: t14black,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            '${item.needPoint}积分兑',
                            style: t14Yellow,
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          );
          return Routers.link(
              widget, Routers.goodDetailTag, context, {'id': item.itemId});
        }).toList(),
      ),
    );
  }

  _rcmTitle() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      alignment: Alignment.center,
      child: Text(
        '为您推荐',
        style: t16blackbold,
      ),
    );
  }

  _rcmdOne() {
    return SliverList(
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
      return _rcmdOneItem(index);
    }, childCount: _data.memLayawayVO.layawayList.length));
  }

  _rcmdOneItem(int index) {
    var layawayList = _data.memLayawayVO.layawayList;
    var item = layawayList[index];
    return GestureDetector(
      child: Container(
        color: backWhite,
        padding: EdgeInsets.symmetric(horizontal: 10),
        margin: EdgeInsets.only(bottom: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              width: 120,
              height: 120,
              imageUrl: item.primaryPicUrl,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${item.name}',
                    style: t14black,
                  ),
                  SizedBox(height: 5),
                  Text(
                    '${item.title}',
                    style: t12lightGrey,
                  ),
                  SizedBox(height: 15),
                  Text(
                    '¥${item.retailPrice}/${item.phaseNum}期',
                    style: t14YellowBold,
                  ),
                  Text(
                    '购买最高得${item.point}积分',
                    style: t12Yellow,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        Routers.push(Routers.webView, context, {
          'url': 'https://m.you.163.com/layaway/detail?id=${item.id.toString()}'
        });
      },
    );
  }
}
