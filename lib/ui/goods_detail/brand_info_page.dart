import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/component/floating_action_button.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/model/itemListItem.dart';
import 'package:flutter_app/ui/component/model/normalSearchModel.dart';
import 'package:flutter_app/ui/component/normal_conditions.dart';
import 'package:flutter_app/ui/component/sliverAppBarDelegate.dart';
import 'package:flutter_app/ui/goods_detail/model/brandIndexModel.dart';
import 'package:flutter_app/ui/goods_detail/model/goodDetail.dart';
import 'package:flutter_app/ui/sort/good_item_widget.dart';
import 'package:flutter_app/component/app_bar.dart';
import 'package:flutter_app/component/sliver_footer.dart';
import 'package:flutter_app/component/slivers.dart';

class BrandInfoPage extends StatefulWidget {
  final Map params;

  const BrandInfoPage({Key key, this.params}) : super(key: key);

  @override
  _BrandInfoPageState createState() => _BrandInfoPageState();
}

class _BrandInfoPageState extends State<BrandInfoPage> {
  // num _brandId;
  num _goodId;

  BrandInfo _brandInfo;

  BrandIndexModel _brandIndexModel;

  List<ItemListItem> _itemList = [];

  bool _hasMore = true;
  bool _isLoading = true;
  String _extInfo = '';

  double narbarHeight = 40;

  bool resetPage = false;

  final _scrollController = new ScrollController();
  bool _isShowFloatBtn = false;

  var _searchModel = NormalSearchModel(index: 0, descSorted: true);

  @override
  void initState() {
    // TODO: implement initState

    setState(() {
      _brandInfo = widget.params['brandInfo'];
      _goodId = widget.params['id'];
    });
    super.initState();

    _scrollController.addListener(() {
      // 如果下拉的当前位置到scroll的最下面
      if (_scrollController.position.pixels > 500) {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          if (_hasMore) {
            _getBrandIndex();
          }
        }
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
    });

    _getBrandInfo();

    _getBrandIndex();
  }

  void _getBrandInfo() async {
    Map<String, dynamic> params = {
      'itemId': _goodId,
      'brandId': _brandInfo.brandId,
      'type': _brandInfo.type,
      'merchantId': _brandInfo.merchantId ?? 'undefined'
    };
    var responseData = await brandInfo(params);

    var brandInfodata = BrandInfo.fromJson(responseData.data);
    setState(() {
      _brandInfo.subTitle = brandInfodata.subTitle;
      _brandInfo.desc = brandInfodata.desc;
    });
  }

  void _getBrandIndex() async {
    Map<String, dynamic> params = {
      'brandId': _brandInfo.brandId,
      'descSorted': _searchModel.descSorted ?? true,
      'extInfo': _extInfo,
      'itemId': _goodId,
      'merchantId': _brandInfo.merchantId ?? 'undefined',
      'sortType': _searchModel.sortType,
      'type': _brandInfo.type,
    };
    var responseData = await brandIndex(params);
    if (responseData.code == '200') {
      setState(() {
        _isLoading = false;
        _brandIndexModel = BrandIndexModel.fromJson(responseData.data);
        var itemList = _brandIndexModel.itemList;
        if (resetPage) {
          _itemList.clear();
        }
        _itemList.addAll(itemList);
        _hasMore = _brandIndexModel.hasMore;
        _extInfo = _brandIndexModel.extInfo;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      appBar: TopAppBar(title: '${_brandInfo.title ?? ''}').build(context),
      body: _body(),
      floatingActionButton:
          _isShowFloatBtn ? floatingAB(_scrollController) : Container(),
    );
  }

  _body() {
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        singleSliverWidget(_branchWidget()),
        _buildStickyBar(),
        GoodItemWidget(dataList: _itemList),
        SliverFooter(hasMore: _hasMore),
      ],
    );
  }

  Widget _buildStickyBar() {
    return SliverPersistentHeader(
      pinned: true, //是否固定在顶部
      floating: true,
      delegate: SliverAppBarDelegate(
          minHeight: narbarHeight, //收起的高度
          maxHeight: narbarHeight, //展开的最大高度
          child: Container(
            child: NormalConditionsBar(
              height: narbarHeight,
              pressChange: (searchModel) {
                _resetPage(searchModel);
              },
            ),
          )),
    );
  }

  void _resetPage(NormalSearchModel searchModel) {
    setState(() {
      _extInfo = '';
      resetPage = true;
      _searchModel = searchModel;
    });
    _getBrandIndex();
  }

  _branchWidget() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      color: backWhite,
      margin: EdgeInsets.only(bottom: 10),
      child: Column(
        textBaseline: TextBaseline.alphabetic,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              CachedNetworkImage(height: 35, imageUrl: '${_brandInfo.picUrl}'),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${_brandInfo.title ?? ''}',
                      style: t16blackbold,
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      '${_brandInfo.subTitle ?? ''}',
                      style: t12black,
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            '${_brandInfo.desc}',
            style: t12black,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    super.dispose();
  }
}
