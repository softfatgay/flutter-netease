import 'package:flutter/material.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/model/itemListItem.dart';
import 'package:flutter_app/ui/sort/good_item_widget.dart';
import 'package:flutter_app/utils/router.dart';
import 'package:flutter_app/utils/user_config.dart';
import 'package:flutter_app/utils/util_mine.dart';
import 'package:flutter_app/widget/banner.dart';
import 'package:flutter_app/widget/loading.dart';
import 'package:flutter_app/widget/sliver_custom_header_delegate.dart';
import 'package:flutter_app/widget/slivers.dart';

class NewItemPage extends StatefulWidget {
  final Map arguments;

  const NewItemPage({Key key, this.arguments}) : super(key: key);

  @override
  _KingKongPageState createState() => _KingKongPageState();
}

class _KingKongPageState extends State<NewItemPage> {
  var banner = List();
  bool initLoading = true;
  var currentCategory;

  List<ItemListItem> _dataList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _getInitData();
  }

  void _getInitData() async {
    String schemeUrl = widget.arguments["schemeUrl"];
    if (schemeUrl.contains("categoryId")) {
    } else {
      _getNewData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: initLoading
          ? Loading()
          : CustomScrollView(
              slivers: [
                _buildTitle(context),
                singleSliverWidget(Container(
                  height: 20,
                )),
                GoodItemWidget(dataList: _dataList)
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
      imageList: banner,
      onTap: (index) {
        Routers.push(Util.image, context, {'images': banner});
      },
    );
  }

  void _getNewData() async {
    var responseData = await kingKongNewItemData({
      "csrf_token": csrf_token,
      "__timestamp": "${DateTime.now().millisecondsSinceEpoch}"
    });
    List data = responseData.newItems["itemList"];
    List<ItemListItem> dataList = [];
    data.forEach((element) {
      dataList.add(ItemListItem.fromJson(element));
    });
    setState(() {
      _dataList = dataList;
      List bannerList = responseData.OData["newItemAds"];
      banner = bannerList.map((item) => item["picUrl"]).toList();
      initLoading = false;
    });
  }
}
