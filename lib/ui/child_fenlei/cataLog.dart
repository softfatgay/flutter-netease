import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/http/api.dart';
import 'package:flutter_app/utils/router.dart';
import 'package:flutter_app/utils/util_mine.dart';
import 'package:flutter_app/utils/widget_util.dart';
import 'package:flutter_app/widget/footer.dart';
import 'package:flutter_app/widget/loading.dart';

class CatalogGoods extends StatefulWidget {
  final int id;

  CatalogGoods(this.id);

  @override
  _CatalogGoodsState createState() => _CatalogGoodsState();
}

///AutomaticKeepAliveClientMixin  保持滑动不刷新  重写方法 bool get wantKeepAlive => true;
class _CatalogGoodsState extends State<CatalogGoods>
    with AutomaticKeepAliveClientMixin {
  bool isLoading = true;
  int page = 1;
  final int pageSize = 20;
  int total = 0;
  static int chunk = 2;
  List dataList = [];

  bool moreLoading = false;

  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getInitData();

    _scrollController.addListener(() {
      // 如果下拉的当前位置到scroll的最下面
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (!moreLoading && (total > dataList.length)) {
          _getMore();
        }
      }
    });
  }

  _getInitData() async {
    Response response =
        await Api.getGoods(page: page, size: pageSize, categoryId: widget.id);
    var data = response.data;
    var goodList = data['data'];
    setState(() {
      dataList.insertAll(dataList.length, goodList);
      isLoading = false;
      total = data['count'];
      page = page + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Loading();
    } else {
      return RefreshIndicator(
        onRefresh: _refresh,
        child: CustomScrollView(
          controller: _scrollController,
          slivers: <Widget>[
            SliverPadding(
              padding: EdgeInsets.all(8),
              sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    Widget widget = Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      ),
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              height: 180,
                              child: CachedNetworkImage(
                                imageUrl: dataList[index]['list_pic_url'],
                                fit: BoxFit.cover,
                              ),
                            ),
                            flex: 1,
                          ),
                          Container(
                            width: double.infinity,
                            child: Center(
                              child: Text(
                                "￥${dataList[index]['retail_price']}",
                                style:
                                    TextStyle(color: Colors.red, fontSize: 15),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 5),
                            width: double.infinity,
                            child: Center(
                              child: Text(
                                "${dataList[index]['name']}",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                    return Router.link(widget, Util.goodDetailTag, context,
                        {'id': dataList[index]['id']});
                  }, childCount: dataList.length),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    childAspectRatio: 0.9,
                    crossAxisSpacing: 8,
                  )),
            ),
            WidgetUtil.buildASingleSliver(buildFooter()),
          ],
        ),
      );
    }
  }

  Future _refresh() async {
    isLoading = true;
    page = 1;
    var data =
        await Api.getGoods(page: page, size: pageSize, categoryId: widget.id);
    var resData = data.data;
    var goodData = resData['data'];
    List newData = [];
    newData.insertAll(0, goodData);
    setState(() {
      page = 2;
      isLoading = false;
      dataList = newData;
    });
  }

  _getMore() async {
    Future.delayed(Duration(seconds: 1)).then((e) async {
      var data =
          await Api.getGoods(page: page, size: pageSize, categoryId: widget.id);

      var resData = data.data;
      var goodsList = resData['data'];
      setState(() {
        dataList.insertAll(dataList.length, goodsList);
        page = page + 1;
        total = data.data['count'];
      });
    });
  }

  Widget buildFooter() {
    if (dataList.length == total) {
      return NoMoreText();
    } else {
      return Loading();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
