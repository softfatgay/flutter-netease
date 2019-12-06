import 'package:cached_network_image/cached_network_image.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/http/api.dart';
import 'package:flutter_app/ui/brand/brand_detail_entity.dart';
import 'package:flutter_app/ui/brand/brand_list_entity.dart';
import 'package:flutter_app/utils/router.dart';
import 'package:flutter_app/utils/util_mine.dart';
import 'package:flutter_app/widget/loading.dart';
import 'package:flutter_app/widget/sliver_custom_header_delegate.dart';

class BrandCopy extends StatefulWidget {
  final Map arguments;

  @override
  _BrandState createState() => _BrandState();

  BrandCopy({this.arguments});
}

class _BrandState extends State<BrandCopy> {
  final int pageSize = 6; //每页条数
  int total = 0; //商品总数
  int page = 1; //请求页
  bool isLoading = true; //首次加载转圈圈
  bool moreLoading = false; //加载更多

  BrandDetailBrand brandDetail; //商品详情
  List<BrandListData> brandList; //商品列表

  ScrollController _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: isLoading
          ? Loading()
          : CustomScrollView(
              controller: _scrollController,
              slivers: <Widget>[
                SliverPersistentHeader(
                  pinned: true,
                  delegate: SliverCustomHeaderDelegate(
                    title: isLoading ? 'loading...' : '${brandDetail.name}',
                    collapsedHeight: 50,
                    expandedHeight: 200,
                    paddingTop: MediaQuery.of(context).padding.top,
                    child: CachedNetworkImage(
                      imageUrl: brandDetail.appListPicUrl,
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getInitdata();

    _scrollController.addListener(() {
      // 如果下拉的当前位置到scroll的最下面
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        LogUtil.e(total, tag: 'total');
        LogUtil.e(brandList.length, tag: 'brandList.length');
        if (!moreLoading && (total > brandList.length)) {
          getMoreData();
        }
      }
    });
  }

  _getInitdata() async {
    BrandDetailEntity brand =
        await Api.getBrandMsg1<BrandDetailEntity>(id: widget.arguments['id']);

    BrandListEntity brandListEntry = await Api.getBrandGoods1(
        page: page, brandId: widget.arguments['id'], size: pageSize);

    setState(() {
      isLoading = false;
      this.brandDetail = brand.brand;
      this.brandList = brandListEntry.data;
      total = brandListEntry.count;
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
        '       ${brandDetail.simpleDesc.replaceAll('\n', '')}',
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
                  imageUrl: brandList[index].listPicUrl,
                  fit: BoxFit.cover,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    brandList[index].name,
                    style: TextStyle(color: Colors.black, fontSize: 14),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  child: Text(
                    '￥${brandList[index].retailPrice}',
                    style: TextStyle(color: Colors.red, fontSize: 20),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          );
          return Router.link(
              widget, Util.goodDetailTag, context, {'id': brandList[index].id});
        }, childCount: brandList.length),
      ),
    );
  }

  Widget buildFooter() {
    if (brandList.length == total) {
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

    BrandListEntity brandListEntry = await Api.getBrandGoods1(
        page: page + 1, brandId: widget.arguments['id'], size: pageSize);

    LogUtil.e(brandListEntry.toJson().toString());

    this.brandList.insertAll(this.brandList.length, brandListEntry.data);
    setState(() {
      total = brandListEntry.count;
      LogUtil.e(total, tag: 'brandListEntry.count');
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
