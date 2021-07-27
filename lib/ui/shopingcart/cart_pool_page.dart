import 'package:flutter/material.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/model/category.dart';
import 'package:flutter_app/model/itemListItem.dart';
import 'package:flutter_app/model/pagination.dart';
import 'package:flutter_app/ui/shopingcart/model/carItem.dart';
import 'package:flutter_app/ui/shopingcart/model/itemPoolModel.dart';
import 'package:flutter_app/ui/sort/good_item_normal.dart';
import 'package:flutter_app/ui/sort/model/categoryL1Item.dart';
import 'package:flutter_app/widget/back_loading.dart';
import 'package:flutter_app/widget/sliver_footer.dart';
import 'package:flutter_app/widget/tab_app_bar.dart';

class CartItemPoolPage extends StatefulWidget {
  const CartItemPoolPage({Key key}) : super(key: key);

  @override
  _CartItemPoolPageState createState() => _CartItemPoolPageState();
}

class _CartItemPoolPageState extends State<CartItemPoolPage>
    with TickerProviderStateMixin {
  int _page = 1;
  int _pageSize = 10;

  bool _isLoading = true;
  bool _firstLoading = true;

  int _activeIndex = 0;
  TabController _mController;
  List<CategorytListItem> _categorytList = [];
  List<ItemListItem> _result = [];
  Pagination _pagination;
  int _id = 0;
  ScrollController _scrollController = ScrollController();
  ItemPoolModel _itemPoolModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _mController = TabController(length: _categorytList.length, vsync: this);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (_pagination != null) {
          if (_pagination.totalPage > _pagination.page) {
            setState(() {
              _page++;
            });
            _itemPool();
          }
        }
      }
    });
    _itemPool();
  }

  @override
  Widget build(BuildContext context) {
    List<String> tabItem = [];
    for (int i = 0; i < (_categorytList.length); i++) {
      tabItem.add(_categorytList[i].categoryVO.name);
    }
    return Scaffold(
      appBar: TabAppBar(
        controller: _mController,
        tabs: tabItem,
        title: '${tabItem.length > 0 ? tabItem[_activeIndex] : ''}',
      ).build(context),
      body: _buildBody(),
    );
  }

  _buildBody() {
    return Container(
      child: _isLoading
          ? Loading()
          : CustomScrollView(
              controller: _scrollController,
              slivers: [
                GoodItemNormalWidget(dataList: _result),
                SliverFooter(hasMore: _pagination.totalPage > _pagination.page)
              ],
            ),
    );
  }

  void _itemPool() async {
    Map<String, dynamic> params = {
      'promotionId': 0,
      'page': _page,
      'size': _pageSize,
      'sortType': 0,
      'descSorted': false,
      'source': 0,
      'categoryId': 0,
      'priceRangeId': _id,
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
      _mController = TabController(
          length: _categorytList.length,
          vsync: this,
          initialIndex: _activeIndex);
      _mController.addListener(() {
        setState(() {
          _activeIndex = _mController.index;
          _id = _categorytList[_activeIndex].categoryVO.id;
          _page = 1;
          _itemPool();
        });
      });
    }
  }
}
