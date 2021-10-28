import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/component/app_bar.dart';
import 'package:flutter_app/component/back_loading.dart';
import 'package:flutter_app/component/indicator_banner.dart';
import 'package:flutter_app/component/net_image.dart';
import 'package:flutter_app/component/slivers.dart';
import 'package:flutter_app/component/top_round_net_image.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/http_manager/net_contants.dart';
import 'package:flutter_app/model/itemListItem.dart';
import 'package:flutter_app/ui/mine/components/head_portrait.dart';
import 'package:flutter_app/ui/mine/model/pointsModel.dart';
import 'package:flutter_app/ui/router/router.dart';
import 'package:flutter_app/ui/sort/good_item_normal.dart';

class PointCenterPage extends StatefulWidget {
  @override
  _PointCenterPageState createState() => _PointCenterPageState();
}

class _PointCenterPageState extends State<PointCenterPage> {
  bool _isLoading = true;

  late PointsModel _data;
  List<String> _banner = [];
  List<PonitBannersItem>? _bannerData = [];
  List<ItemListItem> _rcmdDataList = [];

  String _topBack =
      'https://yanxuan.nosdn.127.net/6b49731e1ed23979a89f119048785bba.png';

  List _topItems = [
    {
      'name': 'Pro会员',
      'dec': '购物享双倍积分',
      'pic': 'assets/images/ji_pro.png',
      'target': 'https://m.you.163.com/supermc/index'
    },
    {
      'name': '口红机挑战',
      'dec': '凭实力赢奖品',
      'pic': 'assets/images/ji_kouh.png',
      'target': 'https://act.you.163.com/act/pub/guJMK5DxL1.html',
    },
    {
      'name': '积分抽奖',
      'dec': '100%中奖',
      'pic': 'assets/images/ji_chouj.png',
      'target': 'https://m.you.163.com/act/pub/PI1Bnd7PfS.html',
    }
  ];

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
      _banner = _bannerData!.map((item) => '${item.picUrl ?? ''}').toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: TopAppBar(
        title: '积分中心',
      ).build(context),
      body: _isLoading ? Loading() : _buildBody(),
    );
  }

  _buildBody() {
    return CustomScrollView(
      slivers: [
        singleSliverWidget(_buildTop()),
        singleSliverWidget(_proWidget()),
        _buildSwiper(),
        singleSliverWidget(_line(10.0)),
        singleSliverWidget(Image.asset('assets/images/point_banner.png')),
        singleSliverWidget(SizedBox(height: 15)),
        singleSliverWidget(_buildTitle('${_data.pointExVirtualAct!.actName}',
            '${_data.pointExVirtualAct!.actDesc}', '每期兑换1件')),
        singleSliverWidget(SizedBox(height: 15)),
        _buildActivity(),
        singleSliverWidget(SizedBox(height: 15)),
        singleSliverWidget(_buildTitle(
            '${_data.pointExExternalRights!.actName}',
            '${_data.pointExExternalRights!.actDesc}',
            '')),
        singleSliverWidget(SizedBox(height: 15)),

        ///积分兑换权益
        singleSliverWidget(_buildActivity2C()),
        singleSliverWidget(SizedBox(height: 15)),
        singleSliverWidget(_line(10.0)),
        singleSliverWidget(Image.asset('assets/images/point_banner2.png')),
        singleSliverWidget(SizedBox(height: 15)),
        _buildChangePoint(),
        singleSliverWidget(_rcmTitle()),
        singleSliverWidget(_buildTitle('精选超值年购', '', '')),
        _rcmdOne(),
        singleSliverWidget(_rcmAll()),
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
            _topBack,
          ),
          fit: BoxFit.fill,
        ),
      ),
      height: 150,
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: 15),
          HeadPortrait(url: '${_data.userSimpleInfo!.userAvatar}'),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '你的可用积分：${_data.availablePoint}',
                  style: t16whiteblod,
                ),
                GestureDetector(
                  child: Container(
                    margin: EdgeInsets.only(top: 3),
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 1),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                        '${_data.userSimpleInfo!.memberLevel == 0 ? '普通会员 >' : 'Pro会员 >'}',
                        style: TextStyle(
                          fontSize: 12,
                          color: textWhite,
                          height: 1.1,
                        )),
                  ),
                  onTap: () {
                    Routers.push(Routers.webView, context,
                        {'url': 'https://m.you.163.com/membership/index'});
                  },
                ),
              ],
            ),
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    height: 60,
                    child: Text(
                      '积分规则',
                      style: t14white,
                    ),
                  ),
                  onTap: () {
                    Routers.push(Routers.webView, context,
                        {'url': '${NetConstants.baseUrl}help/new#/36/81'});
                  },
                ),
                GestureDetector(
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
                        {'url': '${NetConstants.baseUrl}points/detail'});
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _proWidget() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _topItems
            .map((item) => GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                            right: BorderSide(
                                color: Color(0xFFD9D9D9), width: 1))),
                    width: MediaQuery.of(context).size.width / 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          item['pic'],
                          fit: BoxFit.contain,
                          width: 50,
                          height: 50,
                        ),
                        SizedBox(height: 5),
                        Text(
                          item['name'],
                          style: t16blackbold,
                        ),
                        Text(
                          item['dec'],
                          style: t14grey,
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    Routers.push(
                        Routers.webView, context, {'url': item['target']});
                  },
                ))
            .toList(),
      ),
    );
  }

  //轮播图
  _buildSwiper() {
    return SliverToBoxAdapter(
      child: Container(
        color: backWhite,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: IndicatorBanner(
            dataList: _banner,
            fit: BoxFit.contain,
            height: 90,
            corner: 0,
            indicatorType: IndicatorType.none,
            onPress: (index) {
              _goWebview('${_bannerData![index].targetUrl}');
            }),
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
              if (act.isNotEmpty)
                Container(
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

  _buildActivity() {
    var pointExVirtualAct = _data.pointExVirtualAct!;
    List<ActPackets> activitys = pointExVirtualAct.actPackets!;
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
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(color: textYellow, width: 0.5)),
                  child: NetImage(
                    imageUrl: '${item.picUrl}',
                    width: 80,
                    height: 80,
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                '${item.title}',
                style: t12blackBold,
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
              '${NetConstants.baseUrl}points/exVirtual/actPacket?actId=${pointExVirtualAct.actId}&actPacketId=${item.actPacketId}&actPacketGiftId=${item.actPacketGiftId}'
        });
      }).toList(),
    );
  }

  int _currentIndex = 0;

  _buildActivity2C() {
    var pointExVirtualAct = _data.pointExExternalRights!;
    List<ActPackets> activity = pointExVirtualAct.actPackets!;
    var length = activity.length ~/ 4 + 1;
    var list = List.filled(length, '');

    return Container(
      child: Column(
        children: [
          CarouselSlider.builder(
            options: CarouselOptions(
                height: 350,
                aspectRatio: 2.0,
                enlargeCenterPage: false,
                viewportFraction: 1,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                }),
            itemCount: (activity.length / 4).round(),
            itemBuilder: (context, index, realIdx) {
              var sublist = [];
              if (index < activity.length / 4 - 1) {
                sublist = activity.sublist(index * 4, index * 4 + 4);
              } else {
                sublist = activity.sublist(index * 4, activity.length);
              }
              return Wrap(
                spacing: 5,
                runSpacing: 5,
                children: sublist
                    .map((item) => activity2Item(context, item))
                    .toList(),
              );
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: list.asMap().entries.map((entry) {
              return Container(
                width: 12.0,
                height: 3.0,
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: _currentIndex == entry.key ? textOrange : lineColor),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget activity2Item(BuildContext context, item) {
    return GestureDetector(
      child: Container(
        width: MediaQuery.of(context).size.width / 2 - 10,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: backColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 100,
                child: TopRoundNetImage(
                  url: item.picUrl,
                  corner: 4,
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Text(
                  '${item.title}',
                  style: t16blackbold,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 10, bottom: 10),
                child: Text(
                  '${item.needPoint}积分兑',
                  style: TextStyle(
                      color: textYellow,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        var pointExVirtualAct = _data.pointExExternalRights!;
        Routers.push(Routers.webView, context, {
          "url":
              '${NetConstants.baseUrl}points/exVirtual/actPacket?actId=${pointExVirtualAct.actId}&actPacketId=${item.actPacketId}&actPacketGiftId=${item.actPacketGiftId}'
        });
      },
    );
  }

  _buildActivity2() {
    var pointExVirtualAct = _data.pointExExternalRights!;
    List<ActPackets> activity = pointExVirtualAct.actPackets!;
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      sliver: SliverGrid.count(
        crossAxisCount: 2,
        childAspectRatio: 1.25,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: activity.map<Widget>((item) {
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
                    style: t16blackbold,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 10, bottom: 10),
                  child: Text(
                    '${item.needPoint}积分兑',
                    style: TextStyle(
                        color: textYellow,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          );
          return Routers.link(widget, Routers.webView, context, {
            "url":
                '${NetConstants.baseUrl}points/exVirtual/actPacket?actId=${pointExVirtualAct.actId}&actPacketId=${item.actPacketId}&actPacketGiftId=${item.actPacketGiftId}'
          });
        }).toList(),
      ),
    );
  }

  _buildChangePoint() {
    var exchangeModule = _data.exchangeModule!;
    List<PointCommoditiesItem> pointCommodities =
        exchangeModule.pointCommodities!;
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
                    child: NetImage(
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
              widget, Routers.goodDetail, context, {'id': item.itemId});
        }).toList(),
      ),
    );
  }

  _rcmTitle() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      alignment: Alignment.center,
      child: Text(
        '热销好物',
        style: t16blackbold,
      ),
    );
  }

  _rcmdOne() {
    return SliverList(
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
      return _rcmdOneItem(index);
    }, childCount: _data.memLayawayVO!.layawayList!.length));
  }

  _rcmdOneItem(int index) {
    var layawayList = _data.memLayawayVO!.layawayList!;
    var item = layawayList[index];
    return GestureDetector(
      child: Container(
        color: backWhite,
        padding: EdgeInsets.symmetric(horizontal: 10),
        margin: EdgeInsets.only(bottom: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NetImage(
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
        Routers.push(Routers.layawayDetail, context, {'id': item.id});
      },
    );
  }

  Widget _rcmAll() {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.only(bottom: 15, top: 5),
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: lineColor, width: 1))),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '查看全部',
              style: TextStyle(fontSize: 16, color: textBlack, height: 1.15),
            ),
            Image.asset(
              'assets/images/arrow_right.png',
              width: 14,
              height: 14,
            )
          ],
        ),
      ),
      onTap: () {
        Routers.push(Routers.layaway, context);
      },
    );
  }
}
