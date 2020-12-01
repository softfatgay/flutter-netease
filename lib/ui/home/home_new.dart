import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/utils/router.dart';
import 'package:flutter_app/utils/util_mine.dart';
import 'package:flutter_app/widget/back_loading.dart';
import 'package:flutter_app/widget/colors.dart';
import 'package:flutter_app/widget/flow_widget.dart';
import 'package:flutter_app/widget/slivers.dart';
import 'package:flutter_app/widget/swiper.dart';

/*const SliverAppBar({
Key key,
this.leading,//左侧的图标或文字，多为返回箭头
this.automaticallyImplyLeading = true,//没有leading为true的时候，默认返回箭头，没有leading且为false，则显示title
this.title,//标题
this.actions,//标题右侧的操作
this.flexibleSpace,//可以理解为SliverAppBar的背景内容区
this.bottom,//SliverAppBar的底部区
this.elevation,//阴影
this.forceElevated = false,//是否显示阴影
this.backgroundColor,//背景颜色
this.brightness,//状态栏主题，默认Brightness.dark，可选参数light
this.iconTheme,//SliverAppBar图标主题
this.actionsIconTheme,//action图标主题
this.textTheme,//文字主题
this.primary = true,//是否显示在状态栏的下面,false就会占领状态栏的高度
this.centerTitle,//标题是否居中显示
this.titleSpacing = NavigationToolbar.kMiddleSpacing,//标题横向间距
this.expandedHeight,//合并的高度，默认是状态栏的高度加AppBar的高度
this.floating = false,//滑动时是否悬浮
this.pinned = false,//标题栏是否固定
this.snap = false,//配合floating使用
})*/

class HomeNew extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomeNew> with AutomaticKeepAliveClientMixin {
  bool isLoading = true;
  List banner,
      bannerData,
      tagList,
      kingKongModuleItems,
      bigPromotionModuleItems,
      categoryHotSellModuleItems,
      categoryHotSellItems,
      flashSaleModuleItems,
      indexActivityModules,
      newItemList,
      sceneLightShoppingGuideModule = List();
  var categoryHotSellModule;
  var flashSaleModule;
  var kingKongModule;
  var bigPromotionModule;

  void _incrementCounter() {
    _getData();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
  }

  void _getData() async {
    var responseData = await homeData({
      "csrf_token": "61f57b79a343933be0cb10aa37a51cc8",
      "__timestamp": "${DateTime.now().millisecondsSinceEpoch}"
    });
    var data = responseData.data;
    var homeModel = data["data"];
    bannerData = homeModel["focusList"];
    setState(() {
      banner = bannerData
          .map((item) => CachedNetworkImage(
                imageUrl: item['picUrl'],
                fit: BoxFit.fill,
                errorWidget: (context, url, error) => Icon(Icons.error),
              ))
          .toList();

      tagList = homeModel["policyDescList"];
      kingKongModule = homeModel["kingKongModule"];
      kingKongModuleItems = homeModel["kingKongModule"]["kingKongList"];

      ///金刚位下面大图，列表
      bigPromotionModule = homeModel["bigPromotionModule"];
      bigPromotionModuleItems = homeModel["bigPromotionModule"]["floorList"];

      ///新人专享礼包左侧图片写死的   yanxuan.nosdn.127.net/352b0ea9b2d058094956efde167ef852.png
      indexActivityModules = homeModel["indexActivityModule"];

      ///类目热销榜
      categoryHotSellModule = homeModel["categoryHotSellModule"];
      categoryHotSellModuleItems =
          homeModel["categoryHotSellModule"]["categoryList"];

      var list = List();
      for (var i = 0; i < categoryHotSellModuleItems.length; i++) {
        if (i != 0 && i != 1) {
          list.add(categoryHotSellModuleItems[i]);
        }
      }
      categoryHotSellItems = list;
      print("===============================================");
      print(categoryHotSellItems);

      ///限时购
      flashSaleModule = homeModel["flashSaleModule"];
      flashSaleModuleItems = homeModel["flashSaleModule"]["itemList"];

      ///新品首发
      newItemList = homeModel["newItemList"];

      ///底部两个
      sceneLightShoppingGuideModule =
          homeModel["sceneLightShoppingGuideModule"];

      isLoading = false;
    });

    print(banner);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        mini: true,
        backgroundColor: Color(0xB3D2001A),
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.loop),
      ), //
      appBar: AppBar(
          elevation: 1,
          backgroundColor: Colors.white,
          brightness: Brightness.light,
          title: _buildSearch(context)
      ),
      body: isLoading
          ? Loading()
          : CustomScrollView(
        slivers: [
          // _buildSearch(context),
          _buildSwiper(), //banner图
          _topTags(context), //标签
          _kingkong(context), //
          _bigPromotion(context), //活动大图
          _splitLine(),
          _newcomerPack(context), //新人礼包
          _splitLine(),
          _categoryHotSell(context), //类目热销榜
          _categoryHotSellItem(context), //类目热销榜条目

          _splitLine(),
          _flashSaleTitle(context), //限时购
          _flashSaleItem(context), //类目热销榜条目

          _splitLine(),
          _newModulTitle(context), //新品首发
          _newModulItem(context), //新品首发条目
          _splitLine(),
          _bottomView(context),
        ],
      ),
    );
  }

  _buildSearch(BuildContext context) {
    Widget widget = Row(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            "网易严选",
            style: TextStyle(
              fontSize: 20,
              color: Colors.black54
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 35,
            width: double.infinity,
            margin: EdgeInsets.fromLTRB(0, 10, 15, 10),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 237, 237, 237),
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.search,
                  size: 25,
                  color: textGrey,
                ),
                Text(
                  "搜索商品，共43430款好物",
                  style: TextStyle(color: textGrey, fontSize: 16),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          ),
        )
      ],
    );
    return Routers.link(widget, Util.search, context, {'id': "零食"});
    // return singleSliverWidget(
    //     Routers.link(navBar, Util.search, context, {'id': "零食"}));
  }

  //轮播图
  _buildSwiper() {
    return SliverToBoxAdapter(
      child: banner == null
          ? Container()
          : SwiperView(banner, onTap: (index) {
              _goWebview('${bannerData[index]["targetUrl"]}');
            }),
    );
  }

  _topTags(BuildContext context) {
    return singleSliverWidget(Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: tagList
          .map((item) => Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                height: 40,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CachedNetworkImage(
                      width: 20,
                      height: 20,
                      imageUrl: item['icon'],
                      fit: BoxFit.fill,
                    ),
                    Text(item["desc"])
                  ],
                ),
              ))
          .toList(),
    ));
  }

  ///  分类
  _kingkong(BuildContext context) {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5, childAspectRatio: 0.8),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          Widget widget = Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4), color: Colors.white),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(5),
                    child: CachedNetworkImage(
                      imageUrl: kingKongModuleItems[index]['picUrl'] == null
                          ? ""
                          : kingKongModuleItems[index]['picUrl'],
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  flex: 2,
                ),
                Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.only(
                        bottom: 4,
                      ),
                      color: Colors.white,
                      child: Center(
                        child: Text(
                          kingKongModuleItems[index]['text'] == null
                              ? ""
                              : kingKongModuleItems[index]['text'],
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    )),
              ],
            ),
          );
          return Routers.link(widget, Util.kingKong, context,
              {"schemeUrl": kingKongModuleItems[index]["schemeUrl"]});
        },
        childCount:
            kingKongModuleItems == null ? 0 : kingKongModuleItems.length,
      ),
    );
  }

  _bigPromotion(BuildContext context) {
    return singleSliverWidget(Column(
      children: bigPromotionModuleItems
          .map(
            (item) => Container(
              margin: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
              child: GestureDetector(
                child: CachedNetworkImage(
                  imageUrl: item["cells"][0]["picUrl"],
                ),
                onTap: () {
                  Routers.push(Util.webView, context,
                      {'id': item["cells"][0]["schemeUrl"]});
                },
              ),
            ),
          )
          .toList(),
    ));
  }

  _splitLine() {
    return singleSliverWidget(Container(
      height: 10,
      color: Color(0xFFEAEAEA),
    ));
  }

  _newcomerPack(BuildContext context) {
    return singleSliverWidget(Column(children: [
      Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Text(
                "- 新人专享礼包 -",
                style: TextStyle(fontSize: 18),
              ),
            )
          ],
        ),
      ),
      Container(
        height: 240,
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: GestureDetector(
                  child: Container(
                    child: Container(
                      height: 240,
                      margin: EdgeInsets.only(top: 3),
                      color: Color(0xFFF6E5C4),
                      child: CachedNetworkImage(
                          fit: BoxFit.fitWidth,
                          imageUrl:
                              "http://yanxuan.nosdn.127.net/352b0ea9b2d058094956efde167ef852.png"),
                    ),
                  ),
                  onTap: () {
                    _goWebview(
                        'https://act.you.163.com/act/pub/qAU4P437asfF.html');
                  },
                )),
            Container(
              width: 3,
              color: Colors.white,
            ),
            Expanded(
              flex: 1,
              child: Container(
                  height: 240,
                  child: Column(
                      children: indexActivityModules.map((item) {
                    return GestureDetector(
                      child: Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 117,
                            color: Color(0xFFF9DCC9),
                            margin: EdgeInsets.only(top: 3),
                            child: CachedNetworkImage(
                              alignment: Alignment.bottomRight,
                              fit: BoxFit.fitHeight,
                              imageUrl: item["picUrl"],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item["title"],
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: textBlack),
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                Container(
                                  decoration: BoxDecoration(color: backGrey),
                                  child: Text(
                                    item["subTitle"] == ""
                                        ? item["tag"]
                                        : item["subTitle"],
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.grey),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        _goWebview(item['targetUrl']);
                      },
                    );
                  }).toList())),
            ),
          ],
        ),
      ),
      SizedBox(
        height: 20,
      )
    ]));
  }

  _categoryHotSell(BuildContext context) {
    if (categoryHotSellModule == null) {
      return singleSliverWidget(Container());
    }
    return SliverPadding(
      padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
      sliver: singleSliverWidget(
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(0, 5, 15, 15),
              child: Text(
                categoryHotSellModule == null
                    ? ""
                    : categoryHotSellModule["title"],
                style: TextStyle(fontSize: 18),
              ),
            ),
            Container(
              child: Row(
                children: [
                  _hotTopCell(0),
                  SizedBox(
                    width: 5,
                  ),
                  _hotTopCell(1),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Expanded _hotTopCell(int index) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: () {
          Routers.push(Util.hotlist, context);
        },
        child: Container(
          color: index == 0 ? Color(0xFFF7F1DD) : Color(0xFFE4E8F0),
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      categoryHotSellModuleItems[index]["categoryName"],
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      height: 2,
                      width: 30,
                      color: Colors.black,
                    )
                  ],
                ),
                flex: 2,
              ),
              Expanded(
                child: CachedNetworkImage(
                  imageUrl: categoryHotSellModuleItems[index]["picUrl"],
                ),
                flex: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _categoryHotSellItem(BuildContext context) {
    if (categoryHotSellModule == null) {
      return singleSliverWidget(Container());
    }
    return SliverPadding(
      padding: EdgeInsets.fromLTRB(15, 5, 15, 10),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4, crossAxisSpacing: 5, mainAxisSpacing: 5),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Routers.push(Util.hotlist, context);
              },
              child: Column(
                children: <Widget>[
                  Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.only(
                          top: 4,
                        ),
                        color: Color(0xFFF2F2F2),
                        child: Center(
                          child: Text(
                            categoryHotSellItems[index]['categoryName'],
                            style: TextStyle(
                                color: textBlack,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )),
                  Expanded(
                      flex: 3,
                      child: Container(
                        color: Color(0xFFF2F2F2),
                        child: Center(
                          child: CachedNetworkImage(
                            imageUrl: categoryHotSellItems[index]['picUrl'],
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      )),
                ],
              ),
            );
          },
          childCount: categoryHotSellItems.length,
        ),
      ),
    );
  }

  _flashSaleTitle(BuildContext context) {
    if (flashSaleModule == null) {
      return singleSliverWidget(Container());
    }
    return SliverPadding(
      padding: EdgeInsets.fromLTRB(15, 15, 15, 10),
      sliver: singleSliverWidget(Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.only(bottom: 2),
                alignment: Alignment.centerLeft,
                child: Text(
                  "限时购",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 2),
                  child: Text(
                    "更多",
                    style: t16black,
                  ),
                ),
                Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey)
              ],
            )
          ],
        ),
      )),
    );
  }

  _flashSaleItem(BuildContext context) {
    if (flashSaleModuleItems == null) {
      return singleSliverWidget(Container());
    }
    return SliverPadding(
      padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            childAspectRatio: 0.8),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            Widget widget = Column(
              children: <Widget>[
                Container(
                  color: Colors.white,
                  child: Center(
                    child: CachedNetworkImage(
                      imageUrl: flashSaleModuleItems[index]['picUrl'],
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "¥${flashSaleModuleItems[index]['activityPrice']}",
                        style: TextStyle(fontSize: 14, color: Colors.red),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "¥${flashSaleModuleItems[index]['originPrice']}",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      )
                    ],
                  ),
                )
              ],
            );
            return Routers.link(widget, Util.goodDetailTag, context,
                {'id': flashSaleModuleItems[index]['itemId']});
          },
          childCount: flashSaleModuleItems.length,
        ),
      ),
    );
  }

  _newModulTitle(BuildContext context) {
    if (newItemList == null) {
      return singleSliverWidget(Container());
    }
    return SliverPadding(
      padding: EdgeInsets.fromLTRB(15, 15, 15, 10),
      sliver: singleSliverWidget(
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.only(bottom: 2),
                child: Text(
                  "新品首发",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                return Routers.push(Util.kingKong, context,
                    {"schemeUrl": "new"});
              },
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 2),
                    child: Text(
                      "更多",
                      style: t16black,
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _newModulItem(BuildContext context) {
    if (newItemList == null) {
      return singleSliverWidget(Container());
    }
    return SliverPadding(
        padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
        sliver: SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              childAspectRatio: 0.6),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              var item = newItemList[index];
              Widget widget = Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        child: CachedNetworkImage(
                          height: 210,
                          imageUrl: item['scenePicUrl'],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Text(
                        "${item['simpleDesc']}",
                        style: TextStyle(fontSize: 14),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      "¥${item['retailPrice']}",
                      style: TextStyle(
                        color: textRed,
                        fontSize: 18,
                      ),
                    ),
                    Container(
                      constraints: BoxConstraints(minHeight: 18),
                      child: _newItemsTags(item),
                    )
                  ],
                ),
              );
              return Routers.link(
                  widget, Util.goodDetailTag, context, {'id': item['id']});
            },
            childCount: newItemList.length > 6 ? 6 : newItemList.length,
          ),
        ));
  }

  _bottomView(BuildContext context) {
    if (sceneLightShoppingGuideModule == null) {
      return singleSliverWidget(Container());
    }

    return SliverPadding(
      padding: EdgeInsets.fromLTRB(10, 15, 15, 15),
      sliver: singleSliverWidget(Row(
        children: sceneLightShoppingGuideModule.map((item) {
          Widget widget = Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                _goWebview(item["styleItem"]['targetUrl']);
              },
              child: Container(
                color: Color(0xFFF2F2F2),
                margin: EdgeInsets.only(left: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(15, 15, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item["styleItem"]["title"],
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            item["styleItem"]["desc"],
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: CachedNetworkImage(
                          imageUrl: item["styleItem"]["picUrlList"][0],
                        )),
                        Expanded(
                            child: CachedNetworkImage(
                          imageUrl: item["styleItem"]["picUrlList"][1],
                        )),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
          return widget;
        }).toList(),
      )),
    );
  }

  _newItemsTags(item) {
    List itemTagList = item["itemTagList"];
    if (itemTagList != null && itemTagList.length > 1) {
      var itemD = itemTagList[itemTagList.length - 1];
      return Container(
        padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            border: Border.all(width: 1, color: redColor)),
        child: Text(
          itemD["name"],
          style: TextStyle(color: textRed, fontSize: 12),
          maxLines: 1,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
        ),
      );
    } else {
      return Container();
    }
  }

  _goWebview(String url) {
    Routers.push(Util.webView, context, {'id': url});
  }

  @override
  bool get wantKeepAlive => true;
}
