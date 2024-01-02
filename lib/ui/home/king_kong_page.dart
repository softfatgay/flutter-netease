import 'package:flutter/material.dart';
import 'package:flutter_app/component/floating_action_button.dart';
import 'package:flutter_app/component/indicator_banner.dart';
import 'package:flutter_app/component/page_loading.dart';
import 'package:flutter_app/component/sliver_custom_header_delegate.dart';
import 'package:flutter_app/component/sliver_footer.dart';
import 'package:flutter_app/component/slivers.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/model/category.dart';
import 'package:flutter_app/ui/home/model/categoryItemListItem.dart';
import 'package:flutter_app/ui/home/model/kingkongModel.dart';
import 'package:flutter_app/ui/router/router.dart';
import 'package:flutter_app/ui/sort/component/good_items.dart';
import 'package:flutter_app/ui/sort/model/bannerItem.dart';

class KingKongPage extends StatefulWidget {
  final Map? params;

  const KingKongPage({Key? key, this.params}) : super(key: key);

  @override
  _KingKongPageState createState() => _KingKongPageState();
}

class _KingKongPageState extends State<KingKongPage> {
  List<String> _banner = [];
  bool _initLoading = true;
  Category? _currentCategory;

  ///数据
  List<CategoryItemListItem> _categoryItemList = [];

  ///_banner
  List<BannerItem> _bannerList = [];

  final _scrollController = new ScrollController();
  bool _isShowFloatBtn = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(_scrollerListener);
    _getInitData();
  }

  void _scrollerListener() {
    // 如果下拉的当前位置到scroll的最下面
    if (_scrollController.position.pixels > 500) {
      if (!_isShowFloatBtn) {
        setState(() {
          _isShowFloatBtn = true;
        });
      }
    } else {
      if (_isShowFloatBtn) {
        setState(() {
          _isShowFloatBtn = false;
        });
      }
    }
  }

  void _getInitData() async {
    var categoryId;

    String schemeUrl = widget.params!["schemeUrl"];
    print("----------------${schemeUrl}");
    if (schemeUrl.contains("categoryId")) {
      var split = schemeUrl.split("categoryId=");
      var params = split[1];
      List split2 = params.split("&");
      // for (var value in split2) {
      //   if (value.contains("categoryId")) {
      //     var split3 = value.split("=");
      //     var split32 = split3[1];
      //     categoryId = split32;
      //   }
      // }
      categoryId = split2[0];
    } else {
      _getNewData();
    }

    var responseData = await kingKongData({
      "csrf_token": "61f57b79a343933be0cb10aa37a51cc8",
      "style": "pd",
      "categoryId": categoryId,
      "__timestamp": "${DateTime.now().millisecondsSinceEpoch}"
    });

    if (mounted) {
      var data = responseData.data;
      var kingkongModel = KingkongModel.fromJson(data);

      setState(() {
        _currentCategory = kingkongModel.currentCategory;

        _bannerList = kingkongModel.currentCategory!.bannerList ?? [];
        _categoryItemList = kingkongModel.categoryItemList ?? [];
        _banner = _bannerList.map((item) => '${item.picUrl ?? ''}').toList();
        _initLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> slivers = [_buildTitle(context)];

    for (var value in _categoryItemList) {
      slivers.add(_bodyTitle(value));
      slivers.add(GoodItems(dataList: value.itemList));
    }
    slivers.add(SliverFooter(
      hasMore: false,
      tipsText: '更多精彩，敬请期待',
    ));
    return Scaffold(
      backgroundColor: backWhite,
      body: _initLoading
          ? PageLoading()
          : CustomScrollView(
              controller: _scrollController,
              slivers: slivers,
            ),
      floatingActionButton:
          _isShowFloatBtn ? floatingAB(_scrollController) : Container(),
    );
  }

  _buildTitle(BuildContext context) {
    var height = 80.0;
    if (_banner.isNotEmpty) {
      height = 200.0;
    }

    return SliverPersistentHeader(
      pinned: true,
      delegate: SliverCustomHeaderDelegate(
        title: _initLoading ? 'loading...' : '${_currentCategory!.name}',
        expandedHeight: height,
        paddingTop: MediaQuery.of(context).padding.top,
        child: _buildSwiper(context),
      ),
    );
  }

  //轮播图
  _buildSwiper(BuildContext context) {
    if (_banner.isNotEmpty)
      return IndicatorBanner(
          dataList: _banner,
          fit: BoxFit.cover,
          height: 300,
          corner: 0,
          indicatorType: IndicatorType.line,
          onPress: (index) {
            Routers.push(Routers.webView, context,
                {'url': _bannerList[index].targetUrl});
          });
    else
      return Container(
        padding: EdgeInsets.only(bottom: 12),
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(color: Colors.white),
        alignment: Alignment.bottomCenter,
        child: Text("${_currentCategory?.name ?? ""}",style: t16black,),
      );
  }

  _bodyTitle(CategoryItemListItem value) {
    Category category = value.category!;
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
              '${category.name}',
              style: t16black,
            ),
            Text(
              '${category.frontName}',
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
    // var responseData = await kingKongNewItemData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    super.dispose();
  }
}
