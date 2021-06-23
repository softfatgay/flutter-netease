import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/model/category.dart';
import 'package:flutter_app/ui/home/model/categoryItemListItem.dart';
import 'package:flutter_app/ui/home/model/kingkongModel.dart';
import 'package:flutter_app/ui/sort/good_item_normal.dart';
import 'package:flutter_app/ui/sort/model/bannerItem.dart';
import 'package:flutter_app/utils/router.dart';
import 'package:flutter_app/utils/user_config.dart';
import 'package:flutter_app/utils/util_mine.dart';
import 'package:flutter_app/widget/banner.dart';
import 'package:flutter_app/widget/loading.dart';
import 'package:flutter_app/widget/page_loading.dart';
import 'package:flutter_app/widget/sliver_custom_header_delegate.dart';
import 'package:flutter_app/widget/slivers.dart';

class KingKongPage extends StatefulWidget {
  final Map arguments;

  const KingKongPage({Key key, this.arguments}) : super(key: key);

  @override
  _KingKongPageState createState() => _KingKongPageState();
}

class _KingKongPageState extends State<KingKongPage> {
  var _banner = List();
  bool _initLoading = true;
  Category _currentCategory;

  ///数据
  List<CategoryItemListItem> _categoryItemList;

  ///_banner
  List<BannerItem> _bannerList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _getInitData();
  }

  // https://m.you.163.com/item/list.json?csrf_token=61f57b79a343933be0cb10aa37a51cc8&__timestamp=1603334436519&style=pd&categoryId=1005002

  // https://m.you.163.com/item/list?categoryId=1013001&style=pd
  //https://m.you.163.com/item/newItem.json?csrf_token=61f57b79a343933be0cb10aa37a51cc8&__timestamp=1603348965153&

  // https://m.you.163.com/xhr/item/getPreNewItem.json?csrf_token=61f57b79a343933be0cb10aa37a51cc8&__timestamp=1603348965388&

  void _getInitData() async {
    var categoryId;

    String schemeUrl = widget.arguments["schemeUrl"];
    if (schemeUrl.contains("categoryId")) {
      var split = schemeUrl.split("?");
      var params = split[1];

      List split2 = params.split("&");
      for (var value in split2) {
        if (value.contains("categoryId")) {
          var split3 = value.split("=");
          var split32 = split3[1];
          categoryId = split32;
        }
      }
    } else {
      _getNewData();
    }

    var responseData = await kingKongData({
      "csrf_token": "61f57b79a343933be0cb10aa37a51cc8",
      "style": "pd",
      "categoryId": categoryId,
      "__timestamp": "${DateTime.now().millisecondsSinceEpoch}"
    });

    var data = responseData.data;

    var kingkongModel = KingkongModel.fromJson(data);

    setState(() {
      _currentCategory = kingkongModel.currentCategory;

      _bannerList = kingkongModel.currentCategory.bannerList;
      _categoryItemList = kingkongModel.categoryItemList;

      // dataList = data["categoryItemList"];
      // currentCategory = data["currentCategory"];
      _banner = _bannerList.map((item) => item.picUrl).toList();
      _initLoading = false;
    });

    print(responseData.data);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> slivers = [_buildTitle(context)];
    if (_categoryItemList != null) {
      for (var value in _categoryItemList) {
        slivers.add(_bodyTitle(value));
        slivers.add(GoodItemNormalWidget(dataList: value.itemList));
      }
    }
    return _initLoading
        ? PageLoading()
        : Scaffold(
            backgroundColor: backColor,
            body: CustomScrollView(
              slivers: slivers,
            ),
          );
  }

  _buildTitle(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: SliverCustomHeaderDelegate(
        title: _initLoading ? 'loading...' : '${_currentCategory.name}',
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

  _bodyTitle(CategoryItemListItem value) {
    Category category = value.category;
    return singleSliverWidget(Container(
      child: Container(
        color: backWhite,
        child: Column(
          children: [
            Container(
              height: 10,
              color: backColor,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              category.name,
              style: t16black,
            ),
            Text(
              category.frontName,
              style: t12grey,
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    ));
  }

  void _getNewData() async {
    var responseData = await kingKongNewItemData({
      "csrf_token": csrf_token,
      "__timestamp": "${DateTime.now().millisecondsSinceEpoch}"
    });
  }
}
