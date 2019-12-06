import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/http/api.dart';
import 'package:flutter_app/utils/router.dart';
import 'package:flutter_app/utils/util_mine.dart';
import 'package:flutter_app/widget/swiper.dart';
import 'package:flutter_app/widget/topic.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoading = true;
  List banner, channel, brand, news, hot, topic, category = [];

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(
          child: SizedBox(
        width: 24.0,
        height: 24.0,
        child: CircularProgressIndicator(
          strokeWidth: 2.0,
        ),
      ));
    } else {
      var sliversList = [
        buildSwiper(), //banner图
        buildChannel(), //分类
        buildTitle('品牌制造商', false),
        buildBrand(), //品牌制造商
        buildTitle('新品首发'),
        buildNews(),
        buildTitle('人气推荐'),
        buildHot(),
        buildTitle('专题精选'),
        buildTopic(),
      ];

      for (var value in category) {
        sliversList.add(buildTitle(value['name']));
        sliversList
            .add(buildcategory(value['goodsList'], value['name'], value['id']));
      }

      return new SafeArea(
        child: CustomScrollView(
          slivers: sliversList,
        ),
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
  }

  void _getData() async {
    Response data = await Api.getHomeData();
    // 轮播图数据
    var bannerData = data.data['banner'];
    List<Widget> bannerList = List();
    bannerData.forEach((item) => bannerList.add(CachedNetworkImage(
          imageUrl: item['image_url'],
          errorWidget: (context, url, error) => Icon(Icons.error),
        )));

    // channel数据
    var channelData = data.data['channel'];
    // 制造商数据
    var brandData = data.data['brandList'];
    // 新品推荐
    var newsData = data.data['newGoodsList'];
    // 人气推荐
    var hotData = data.data['hotGoodsList'];
    // 专题精选
    var topicList = data.data['topicList'];
    // 推荐商品
    var categoryList = data.data['categoryList'];

    setState(() {
      banner = bannerList;
      channel = channelData;
      brand = brandData;
      news = newsData;
      hot = hotData;
      topic = topicList;
      category = categoryList;
      isLoading = false;
    });
  }

  //轮播图
  SliverList buildSwiper() {
    return SliverList(
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        return SwiperView(banner);
      }, childCount: 1),
    );
  }

  ///  分类
  SliverGrid buildChannel() {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        childAspectRatio: 1.3,
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          Widget widget = Column(
            children: <Widget>[
              Expanded(
                  flex: 2,
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.only(
                      bottom: 4,
                      left: 20,
                      top: 10,
                      right: 20,
                    ),
                    child: Center(
                      child: CachedNetworkImage(
                        imageUrl: channel[index]['icon_url'],
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  )),
              Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.only(
                      bottom: 4,
                    ),
                    color: Colors.white,
                    child: Center(
                      child: Text(
                        channel[index]['name'],
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                  )),
            ],
          );
          return Router.link(
              widget, Util.catalogTag, context, {'id': channel[index]['id']});
        },
        childCount: 5,
      ),
    );
  }

  SliverList buildTitle(String s, [bool param1 = true]) {
    return SliverList(
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
      return Container(
        height: 50,
        decoration: BoxDecoration(
            color: Colors.white,
            border: param1
                ? Border(
                    bottom: BorderSide(color: Colors.grey[200], width: 0.5))
                : null),
        margin: EdgeInsets.only(top: 10),
        child: Center(
          child: Text(
            s,
            style: TextStyle(
                fontWeight: FontWeight.bold, wordSpacing: 2, fontSize: 16),
          ),
        ),
      );
    }, childCount: 1));
  }

  SliverGrid buildBrand() {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        Widget widget = Container(
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                child: Text(
                  brand[index]['name'],
                  style: TextStyle(fontSize: 15),
                ),
              ),
              Container(
                width: double.infinity,
                child: Text(
                  '${brand[index]['floor_price']}元起',
                  style: TextStyle(fontSize: 8, color: Colors.grey),
                ),
              )
            ],
          ),
          padding: EdgeInsets.only(top: 5, left: 10),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(brand[index]['new_pic_url']),
                  fit: BoxFit.fill)),
        );
        return Router.link(widget, Util.brandTag, context, {
          'id': brand[index]['id'],
        });
      }, childCount: brand.length),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 1.6),
    );
  }

  ///新品
  SliverGrid buildNews() {
    return SliverGrid(
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
          Widget widget = Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: CachedNetworkImage(
                      imageUrl: news[index]['list_pic_url'],
                      height: 200,
                      width: double.infinity,
                    ),
                  ),
                  flex: 300,
                ),
                Expanded(
                  child: Container(
                    child: Center(
                      child: Text(
                        news[index]['name'],
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  flex: 40,
                ),
                Expanded(
                  child: Container(
                    child: Center(
                      child: Text(
                        '￥${news[index]['retail_price']}',
                        style: TextStyle(fontSize: 18, color: Colors.red),
                      ),
                    ),
                  ),
                  flex: 40,
                ),
              ],
            ),
          );
          return Router.link(
              widget, Util.goodDetailTag, context, {'id': news[index]['id']});
        }, childCount: news.length),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 2.0,
          crossAxisSpacing: 2.0,
          childAspectRatio: 0.9,
        ));
  }

  ///人气推荐
  SliverList buildHot() {
    return SliverList(
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        Widget widget = Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: Colors.grey[300], width: .5)),
          ),
          padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
          child: Container(
            height: 110,
            child: Row(
              children: <Widget>[
                CachedNetworkImage(
                  imageUrl: hot[index]['list_pic_url'],
                  fit: BoxFit.fill,
                ),
                Expanded(
                    child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 30,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            hot[index]['name'],
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Container(
                        height: 30,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            hot[index]['goods_brief'],
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 30,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '￥${hot[index]['retail_price']}',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ))
              ],
            ),
          ),
        );
        return Router.link(
            widget, Util.goodDetailTag, context, {'id': hot[index]['id']});
      }, childCount: hot.length),
    );
  }

  SliverList buildTopic() {
    return SliverList(
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
      return Topic(topic, context);
    }, childCount: 1));
  }

  SliverGrid buildcategory(goods, typeName, id) {
    return SliverGrid(
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
          if (goods.length == index) {
            Widget widget = Container(
              color: Colors.white,
              child: Center(
                child: Container(
                  height: 70,
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 40,
                        child: Center(
                          child: Text(
                            '更多$typeName好物',
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                      ),
                      Image.asset(
                        'assets/images/more.png',
                        height: 30,
                      )
                    ],
                  ),
                ),
              ),
            );
            return Router.link(widget, Util.catalogTag, context, {'id': id});
          }

          Widget widget = Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: CachedNetworkImage(
                      imageUrl: goods[index]['list_pic_url'],
                      fit: BoxFit.cover,
                    ),
                  ),
                  flex: 350,
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Center(
                      child: Text(
                        goods[index]['name'],
                        style: TextStyle(fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  flex: 50,
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Center(
                      child: Text(
                        '￥${goods[index]['retail_price']}',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                  flex: 60,
                ),
              ],
            ),
          );
          return Router.link(widget, Util.goodDetailTag, context,{'id':goods[index]['id']});
        }, childCount: goods.length + 1),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 2.0,
          crossAxisSpacing: 2.0,
          childAspectRatio: .9,
        ));
  }
}
