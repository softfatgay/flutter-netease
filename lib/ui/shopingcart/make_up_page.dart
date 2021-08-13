import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/model/pagination.dart';
import 'package:flutter_app/ui/goods_detail/components/search_nav_bar.dart';
import 'package:flutter_app/ui/goods_detail/model/goodDetail.dart';
import 'package:flutter_app/ui/goods_detail/model/searchParamModel.dart';
import 'package:flutter_app/ui/shopingcart/components/good_item_add_cart_widget.dart';
import 'package:flutter_app/ui/shopingcart/components/pop_menu_widget.dart';
import 'package:flutter_app/ui/shopingcart/components/price_pop_widget.dart';
import 'package:flutter_app/ui/shopingcart/components/type_pop_widget.dart';
import 'package:flutter_app/ui/shopingcart/model/itemPoolModel.dart';
import 'package:flutter_app/widget/back_loading.dart';
import 'package:flutter_app/widget/sliver_footer.dart';

class MakeUpPage extends StatefulWidget {
  final Map params;

  MakeUpPage({this.params});

  @override
  _MakeUpPageState createState() => _MakeUpPageState();
}

class _MakeUpPageState extends State<MakeUpPage> {
  final _scrollController = new ScrollController();

  final _lowPriceController = TextEditingController();
  final _upPriceController = TextEditingController();

  bool _showPopMenu = false;

  ///-------------------------------------------------------------
  ///
  int _popType = 0;
  var _searchModel = SearchParamModel();
  ItemPoolModel _itemPoolModel;
  bool _isLoading = true;
  List<CategorytListItem> _categorytList = [];
  List<GoodDetail> _result = [];
  Pagination _pagination;
  int _page = 1;
  int _pageSize = 10;

  ///降序？
  int _descSorted = -1;

  num _categoryIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      _searchModel.promotionId = widget.params['id'];
      _searchModel.source = 3;
    });
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (!_pagination.lastPage) {
          _page += 1;
          _itemPool();
        }
      }
    });
    // _getKeyword();
    // _searchInit();

    _itemPool();
  }

  void _itemPool() async {
    Map<String, dynamic> params = {
      'promotionId': _searchModel.promotionId,
      'page': _page,
      'size': _pageSize,
      'sortType': _searchModel.sortType,
      'descSorted': _searchModel.descSorted ?? false,
      'source': _searchModel.source,
      'categoryId': _searchModel.categoryId,
      'priceRangeId': _searchModel.promotionId,
    };
    var responseData = await itemPool(params);
    if (responseData.code == '200') {
      setState(() {
        _isLoading = false;
        _itemPoolModel = ItemPoolModel.fromJson(responseData.data);
        _categorytList = _itemPoolModel.categorytList;
        var searcherItemListResult = _itemPoolModel.searcherItemListResult;
        if (_page == 1) {
          _result.clear();
        }
        _result.addAll(searcherItemListResult.result);
        _pagination = searcherItemListResult.pagination;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 0,
          backgroundColor: backWhite,
        ),
        body: Stack(
          children: [
            Positioned(
              top: 35,
              left: 0,
              right: 0,
              bottom: 0,
              child: _isLoading
                  ? Loading()
                  : CustomScrollView(
                      controller: _scrollController,
                      slivers: [
                        GoodItemAddCartWidget(dataList: _result),
                        SliverFooter(hasMore: !_pagination.lastPage)
                      ],
                    ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 35,
                child: SearchNavBar(
                    collapsedHeight: 35,
                    index: _popType,
                    pressIndex: (pressIndex) {
                      setState(() {
                        if (_popType == pressIndex) {
                          _showPopMenu = !_showPopMenu;
                        } else {
                          _showPopMenu = true;
                          if (pressIndex == 0) {
                            _resetPrice();
                          }
                        }
                        _popType = pressIndex;
                      });
                    },
                    descSorted: _searchModel.descSorted),
              ),
            ),
            Positioned(
              top: 35,
              left: 0,
              right: 0,
              bottom: 0,
              child: PopMenuWidet(
                closePop: _closePopmenu,
                showPopMenu: _showPopMenu,
                child: _popChild(),
              ),
            ),
          ],
        ));
  }

  ///价格点击取消
  void _resetPrice() {
    setState(() {
      _categoryIndex = 0;
      _descSorted = -1;
      _lowPriceController.text = '';
      _upPriceController.text = '';
      _searchModel.descSorted = null;
      _searchModel.floorPrice = -1;
      _searchModel.upperPrice = -1;
    });
    _closePopmenu();
    _resetPage();
  }

  ///价格点击确定
  void setPriceSort() {
    _closePopmenu();
    if (_descSorted == -1) {
      _searchModel.descSorted = null;
    } else if (_descSorted == 0) {
      _searchModel.descSorted = false;
    } else if (_descSorted == 1) {
      _searchModel.descSorted = true;
    } else {
      _searchModel.descSorted = null;
    }

    if (_lowPriceController.text.isNotEmpty) {
      _searchModel.floorPrice = num.parse(_lowPriceController.text);
    } else {
      _searchModel.floorPrice = -1;
    }
    if (_upPriceController.text.isNotEmpty) {
      _searchModel.upperPrice = num.parse(_upPriceController.text);
    } else {
      _searchModel.upperPrice = -1;
    }
    _resetPage();
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
    super.dispose();

    _lowPriceController.dispose();
    _upPriceController.dispose();
    _scrollController.dispose();
  }

  _popChild() {
    if (_popType == 0) {
      return null;
    } else if (_popType == 1) {
      return PricePopWidget(
        confirmClick: setPriceSort,
        lowPriceController: _lowPriceController,
        upPriceController: _upPriceController,
        cancelClick: _resetPrice,
        descSorted: _descSorted,
        sortClick: (sortType) {
          setState(() {
            if (_descSorted == sortType) {
              _descSorted = -1;
            } else {
              _descSorted = sortType;
            }
          });
        },
      );
    } else if (_popType == 2) {
      return TypePopWidget(
        categoryList: _categorytList,
        selectIndex: _categoryIndex,
        seletedIndex: (index) {
          setState(() {
            _categoryIndex = index;
            _searchModel.categoryId = _categorytList[index].categoryVO.id;
          });
          _closePopmenu();

          _resetPage();
        },
      );
    }
    return Container();
  }

  _closePopmenu() {
    setState(() {
      _showPopMenu = false;
    });
  }
}
