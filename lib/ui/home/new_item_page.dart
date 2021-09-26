import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/model/itemListItem.dart';
import 'package:flutter_app/ui/router/router.dart';
import 'package:flutter_app/ui/sort/good_item_normal.dart';
import 'package:flutter_app/ui/sort/good_item_widget.dart';
import 'package:flutter_app/component/banner.dart';
import 'package:flutter_app/component/loading.dart';
import 'package:flutter_app/component/sliver_custom_header_delegate.dart';
import 'package:flutter_app/component/slivers.dart';

class NewItemPage extends StatefulWidget {
  final Map params;

  const NewItemPage({Key key, this.params}) : super(key: key);

  @override
  _KingKongPageState createState() => _KingKongPageState();
}

class _KingKongPageState extends State<NewItemPage> {
  var _banner = [];
  bool _initLoading = true;
  List<ItemListItem> _dataList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _getInitData();
  }

  void _getInitData() async {
    String schemeUrl = widget.params["schemeUrl"];
    if (schemeUrl.contains("categoryId")) {
    } else {
      _getNewData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      body: _initLoading
          ? Loading()
          : CustomScrollView(
              slivers: [
                _buildTitle(context),
                singleSliverWidget(Container(
                  height: 20,
                )),
                GoodItemNormalWidget(dataList: _dataList)
              ],
            ),
    );
  }

  _buildTitle(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: SliverCustomHeaderDelegate(
        title: '全部',
        collapsedHeight: 50,
        expandedHeight: 200,
        paddingTop: MediaQuery.of(context).padding.top,
        child: _buildSwiper(context),
      ),
    );
  }

  //轮播图
  _buildSwiper(BuildContext context) {
    return BannerCacheImg(
      imageList: _banner,
      onTap: (index) {
        Routers.push(Routers.image, context, {'images': _banner});
      },
    );
  }

  void _getNewData() async {
    var responseData = await kingKongNewItemData();
    List data = responseData.newItems["itemList"];
    List<ItemListItem> dataList = [];
    data.forEach((element) {
      dataList.add(ItemListItem.fromJson(element));
    });
    setState(() {
      _dataList = dataList;
      List bannerList = responseData.OData["newItemAds"];
      _banner = bannerList.map((item) => item["picUrl"]).toList();
      _initLoading = false;
    });
  }
}
