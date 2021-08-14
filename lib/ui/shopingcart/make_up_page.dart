import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/model/pagination.dart';
import 'package:flutter_app/ui/goods_detail/model/goodDetail.dart';
import 'package:flutter_app/ui/goods_detail/model/searchParamModel.dart';
import 'package:flutter_app/ui/shopingcart/components/good_item_add_cart_widget.dart';
import 'package:flutter_app/ui/shopingcart/components/menu_pop_widget.dart';
import 'package:flutter_app/ui/shopingcart/model/itemPoolModel.dart';
import 'package:flutter_app/ui/sort/model/categoryL1Item.dart';
import 'package:flutter_app/widget/back_loading.dart';
import 'package:flutter_app/widget/sliver_footer.dart';

///凑单
class MakeUpPage extends StatefulWidget {
  final Map params;

  MakeUpPage({this.params});

  @override
  _MakeUpPageState createState() => _MakeUpPageState();
}

class _MakeUpPageState extends State<MakeUpPage> {
  final _scrollController = new ScrollController();

  var _searchModel = SearchParamModel();
  ItemPoolModel _itemPoolModel;
  bool _isLoading = true;
  List<CategoryL1Item> _categorytList = [];
  List<GoodDetail> _result = [];
  Pagination _pagination;
  int _page = 1;
  int _pageSize = 10;

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
    _itemPool();
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
      'priceRangeId': _searchModel.promotionId,
    };
    var responseData = await itemPool(params);
    if (responseData.code == '200') {
      setState(() {
        _isLoading = false;
        _itemPoolModel = ItemPoolModel.fromJson(responseData.data);
        if (_categorytList == null || _categorytList.isEmpty) {
          List<CategoryL1Item> categorytList = [];
          var categorytListList = _itemPoolModel.categorytList;
          categorytListList.forEach((element) {
            categorytList.add(element.categoryVO);
          });
          _categorytList = categorytList;
        }
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
              bottom: 0,
              child: MenuPopWidget(
                searchParamModel: _searchModel,
                categorytList: _categorytList,
                menuChange: (searchModel) {
                  setState(() {
                    _searchModel = searchModel;
                  });
                  _resetPage();
                },
              ),
            ),
          ],
        ));
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
    _scrollController.dispose();
  }
}