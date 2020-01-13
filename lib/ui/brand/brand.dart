import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/http/api.dart';
import 'package:flutter_app/utils/router.dart';
import 'package:flutter_app/utils/util_mine.dart';
import 'package:flutter_app/widget/loading.dart';
import 'package:flutter_app/widget/sliver_custom_header_delegate.dart';

class Brand extends StatefulWidget {
  final Map arguments;

  @override
  _BrandState createState() => _BrandState();

  Brand({this.arguments});
}

class _BrandState extends State<Brand> {
  final int pageSize = 6; //每页条数
  int total = 0; //商品总数
  int page = 1; //请求页
  bool isLoading = true; //首次加载转圈圈
  Map brandMsg; //商品详情
  List brandGoods; //商品列表
  bool moreLoading = false; //加载更多

  ScrollController _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Loading();
    } else {
      return Material(
        child: CustomScrollView(
          controller: _scrollController,
          slivers: <Widget>[
            SliverPersistentHeader(
              pinned: true,
              delegate: SliverCustomHeaderDelegate(
                title: isLoading ? 'loading...' : '${brandMsg['name']}',
                collapsedHeight: 50,
                expandedHeight: 200,
                paddingTop: MediaQuery.of(context).padding.top,
                child: CachedNetworkImage(
                  imageUrl: brandMsg['app_list_pic_url'],
                  fit: BoxFit.cover,
                ),
              ),
            ),
            buildSliver(buildDescription()),
            buildBrandGoods(),
            buildSliver(buildFooter()),
          ],
        ),
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getInitdata();

    _scrollController.addListener(() {
      // 如果下拉的当前位置到scroll的最下面
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (!moreLoading && (total > brandGoods.length)) {
          getMoreData();
        }
      }
    });
  }

  _getInitdata() async {
    var list = await Future.wait([
      Api.getBrandGoods(
          page: page, brandId: widget.arguments['id'], size: pageSize),
      Api.getBrandMsg(id: widget.arguments['id'])
    ]);

    setState(() {
      isLoading = false;
      brandMsg = list[1].data['brand'];
      brandGoods = list[0].data['data'];
      total = list[0].data['count'];
    });
  }

  SliverList buildSliver(Widget child) {
    return SliverList(
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
      return child;
    }, childCount: 1));
  }

  Widget buildDescription() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(10),
      child: Text(
        '       ${brandMsg['simple_desc'].replaceAll('\n', '')}',
        style: TextStyle(color: Colors.grey),
      ),
    );
  }

  SliverPadding buildBrandGoods() {
    return SliverPadding(
      padding: const EdgeInsets.all(8.0),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
            childAspectRatio: 1),
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
          Widget widget = Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(5.0))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CachedNetworkImage(
                  height: 100,
                  width: double.infinity,
                  imageUrl: brandGoods[index]['list_pic_url'],
                  fit: BoxFit.cover,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    brandGoods[index]['name'],
                    style: TextStyle(color: Colors.black, fontSize: 14),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  child: Text(
                    '￥${brandGoods[index]['retail_price']}',
                    style: TextStyle(color: Colors.red, fontSize: 20),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          );
          return Router.link(widget, Util.goodDetailTag, context,
              {'id': brandGoods[index]['id']});
        }, childCount: brandGoods.length),
      ),
    );
  }

  Widget buildFooter() {
    if (brandGoods.length == total) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Center(
          child: Text(
            '没有更多了',
            style: TextStyle(color: Colors.grey),
          ),
        ),
      );
    } else {
      return Loading();
    }
  }

  void getMoreData() async {
    setState(() {
      moreLoading = true;
    });
    var data = await Api.getBrandGoods(
        brandId: widget.arguments['id'], page: page + 1, size: pageSize);

    brandGoods.insertAll(brandGoods.length, data.data['data']);
    setState(() {
      total = data.data['count'];
      page = page + 1;
      moreLoading = false;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }
}
