import 'package:flutter/material.dart';
import 'package:flutter_app/component/app_bar.dart';
import 'package:flutter_app/component/back_loading.dart';
import 'package:flutter_app/component/floating_action_button.dart';
import 'package:flutter_app/component/sliver_footer.dart';
import 'package:flutter_app/component/slivers.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/model/pagination.dart';
import 'package:flutter_app/ui/component/menu_pop_widget.dart';
import 'package:flutter_app/ui/component/model/searchParamModel.dart';
import 'package:flutter_app/ui/goods_detail/model/goodDetail.dart';
import 'package:flutter_app/ui/router/router.dart';
import 'package:flutter_app/ui/shopping_cart/components/bottom_pool_widget.dart';
import 'package:flutter_app/ui/shopping_cart/components/good_item_add_cart_widget.dart';
import 'package:flutter_app/ui/shopping_cart/model/itemPoolBarModel.dart';
import 'package:flutter_app/ui/shopping_cart/model/itemPoolModel.dart';
import 'package:flutter_app/ui/shopping_cart/model/makeUpCartInfoModel.dart';
import 'package:flutter_app/ui/sort/model/categoryL1Item.dart';

///凑单
class MakeUpPage extends StatefulWidget {
  final Map? params;

  MakeUpPage({this.params});

  @override
  _MakeUpPageState createState() => _MakeUpPageState();
}

class _MakeUpPageState extends State<MakeUpPage> {
  final _scrollController = new ScrollController();
  bool _isShowFloatBtn = false;
  var _searchModel = SearchParamModel();
  late ItemPoolModel _itemPoolModel;
  bool _isLoading = true;
  List<CategoryL1Item?> _categoryList = [];
  List<GoodDetail> _result = [];
  Pagination? _pagination;
  int _page = 1;
  int _pageSize = 10;

  var _from;
  var _itemPoolBarModel = ItemPoolBarModel(0, '');
  var _makeUpCartInfoModel = MakeUpCartInfoModel(validTimeDesc: '');

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      _searchModel.promotionId = widget.params!['id'];
      if (widget.params!['from'] != null) {
        _from = widget.params!['from'];

        if (_from == Routers.goodDetail) {
          ///商品详情过来
          _searchModel.source = 0;
        } else {
          ///购物车点击过来
          _searchModel.source = 0;
        }
      } else {
        ///红包点击过来
        _searchModel.source = 3;
      }
    });
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels > 500) {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          if (!_pagination!.lastPage!) {
            _page += 1;
            _itemPool();
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
    _itemPool();
    _itemPoolBar();
    _getMakeUpCartInfo();
  }

  void _itemPoolBar() async {
    Map<String, dynamic> params = {'promotionId': _searchModel.promotionId};
    var responseData = await itemPoolBar(params);
    if (responseData.code == '200') {
      setState(() {
        _itemPoolBarModel = ItemPoolBarModel.fromJson(responseData.data);
      });
    }
  }

  _getMakeUpCartInfo() async {
    Map<String, dynamic> params = {
      'promotionId': _searchModel.promotionId,
    };
    var responseData = await getMakeUpCartInfo(params);
    if (responseData.code == '200') {
      setState(() {
        _makeUpCartInfoModel = MakeUpCartInfoModel.fromJson(responseData.data);
      });
    }
  }

  void _itemPool() async {
    Map<String, dynamic> params = {
      'promotionId': _searchModel.promotionId,
      'floorPrice': _searchModel.floorPrice,
      'upperPrice': _searchModel.upperPrice,
      'page': _page,
      'size': _pageSize,
      'sortType': _searchModel.sortType,
      'descSorted': _searchModel.descSorted ?? false,
      'source': _searchModel.source,
      'categoryId': _searchModel.categoryId,
      'priceRangeId': 0,
    };

    if (_searchModel.floorPrice == -1) {
      params.remove('floorPrice');
    }
    if (_searchModel.upperPrice == -1) {
      params.remove('upperPrice');
    }

    var responseData = await itemPool(params);
    if (responseData.code == '200') {
      setState(() {
        _isLoading = false;
        _itemPoolModel = ItemPoolModel.fromJson(responseData.data);
        if (_categoryList.isEmpty) {
          List<CategoryL1Item?> categoryList = [];
          var categoryListList = _itemPoolModel.categorytList!;
          categoryListList.forEach((element) {
            categoryList.add(element.categoryVO);
          });
          _categoryList = categoryList;
        }
        var searcherItemListResult = _itemPoolModel.searcherItemListResult!;
        if (_page == 1) {
          _result.clear();
        }
        _result.addAll(searcherItemListResult.result!);
        _pagination = searcherItemListResult.pagination;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backWhite,
      appBar: TopAppBar(
        title: '凑单',
      ).build(context),
      body: Stack(
        children: [
          Positioned(
            top: 35,
            left: 0,
            right: 0,
            bottom: _from == null
                ? MediaQuery.of(context).padding.bottom
                : 45 + MediaQuery.of(context).padding.bottom,
            child: _isLoading
                ? Loading()
                : CustomScrollView(
                    controller: _scrollController,
                    slivers: [
                      singleSliverWidget(_topBarInfo()),
                      GoodItemAddCartWidget(
                        dataList: _result,
                        addCarSuccess: () {
                          _itemPoolBar();
                        },
                      ),
                      SliverFooter(hasMore: !_pagination!.lastPage!)
                    ],
                  ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: MenuPopWidget(
              searchParamModel: _searchModel,
              categorytList: _categoryList,
              menuChange: (searchModel) {
                setState(() {
                  _searchModel = searchModel!;
                });
                _resetPage();
              },
            ),
          ),
          if (_from != null)
            Positioned(
              bottom: MediaQuery.of(context).padding.bottom,
              left: 0,
              right: 0,
              child: BottomPoolWidget(
                itemPoolBarModel: _itemPoolBarModel,
                from: _from,
              ),
            ),
        ],
      ),
      floatingActionButton:
          _isShowFloatBtn ? floatingAB(_scrollController) : Container(),
    );
  }

  void _resetPage() {
    setState(() {
      _page = 1;
      _isLoading = true;
    });
    _itemPool();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    super.dispose();
  }

  _topBarInfo() {
    if (_makeUpCartInfoModel.validTimeDesc == null) {
      return Container();
    }
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      color: backLightYellow,
      alignment: Alignment.center,
      child: Text(
        '${_makeUpCartInfoModel.validTimeDesc}',
        style: t12Orange,
      ),
    );
  }
}
