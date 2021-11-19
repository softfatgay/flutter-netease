import 'package:flutter/material.dart';
import 'package:flutter_app/component/back_loading.dart';
import 'package:flutter_app/component/floating_action_button.dart';
import 'package:flutter_app/component/sliver_footer.dart';
import 'package:flutter_app/component/tab_app_bar.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/model/pagination.dart';
import 'package:flutter_app/ui/goods_detail/model/goodDetail.dart';
import 'package:flutter_app/ui/shopping_cart/components/bottom_pool_widget.dart';
import 'package:flutter_app/ui/shopping_cart/components/good_item_add_cart_widget.dart';
import 'package:flutter_app/ui/shopping_cart/model/itemPoolBarModel.dart';
import 'package:flutter_app/ui/shopping_cart/model/itemPoolModel.dart';
import 'package:flutter_app/ui/sort/model/categoryL1Item.dart';

///去凑单，未达到包邮条件
class AllCartItemPoolPage extends StatefulWidget {
  const AllCartItemPoolPage({Key? key}) : super(key: key);

  @override
  _AllCartItemPoolPageState createState() => _AllCartItemPoolPageState();
}

class _AllCartItemPoolPageState extends State<AllCartItemPoolPage>
    with TickerProviderStateMixin {
  int _page = 1;
  int _pageSize = 10;

  bool _isLoading = true;

  int _activeIndex = 0;
  late TabController _tabController;
  List<CategorytListItem> _categoryList = [];
  List<GoodDetail> _result = [];
  Pagination? _pagination;
  int? _id = 3;
  late ItemPoolModel _itemPoolModel;

  var _itemPoolBarModel = ItemPoolBarModel(0, '');
  final _scrollController = ScrollController();
  bool _isShowFloatBtn = false;

  String _resultKey = '';

  bool _isEmptyResult = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: _categoryList.length, vsync: this);
    _scrollController.addListener(_scrollListener);
    _itemPool();
    _itemPoolBar();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels > 500) {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (_pagination != null) {
          if (_pagination!.totalPage! > _pagination!.page!) {
            setState(() {
              _page++;
            });
            _itemPool();
          }
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
  }

  @override
  Widget build(BuildContext context) {
    List<String?> tabItem = [];
    for (int i = 0; i < (_categoryList.length); i++) {
      tabItem.add(_categoryList[i].categoryVO!.name);
    }
    return Scaffold(
      appBar: TabAppBar(
        controller: _tabController,
        tabs: tabItem,
        scrollable: false,
        title: '${tabItem.length > 0 ? tabItem[_activeIndex] : ''}',
      ).build(context),
      body: _buildBody(),
      floatingActionButton:
          _isShowFloatBtn ? floatingAB(_scrollController) : Container(),
    );
  }

  _buildBody() {
    return Container(
      child: Stack(
        children: [
          _isLoading
              ? Loading()
              : Positioned(
                  bottom: 45,
                  top: 0,
                  left: 0,
                  right: 0,
                  child: CustomScrollView(
                    controller: _scrollController,
                    slivers: [
                      GoodItemAddCartWidget(
                        dataList: _result,
                        addCarSuccess: () {
                          _itemPoolBar();
                        },
                      ),
                      SliverFooter(
                          hasMore: _pagination!.totalPage! > _pagination!.page!)
                    ],
                  ),
                ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: BottomPoolWidget(
              itemPoolBarModel: _itemPoolBarModel,
            ),
          ),
          if (_isEmptyResult)
            Positioned(
                child: Center(
              child: Text(
                '暂时没有结果',
                style: t14grey,
              ),
            ))
        ],
      ),
    );
  }

  void _itemPool({bool showProgress = false}) async {
    Map<String, dynamic> params = {
      'promotionId': 0,
      'page': _page,
      'size': _pageSize,
      'sortType': 0,
      'descSorted': false,
      'source': 0,
      'categoryId': 0,
      'priceRangeId': _id,
      'resultKey': _resultKey,
    };

    var responseData = await getItemPool(params, showProgress: showProgress);
    if (mounted) {
      if (responseData.code == '200') {
        setState(() {
          _isLoading = false;
          _itemPoolModel = ItemPoolModel.fromJson(responseData.data);
          var searchParams = _itemPoolModel.searchParams;
          _resultKey = searchParams!.resultKey ?? '';
          if (_categoryList.isEmpty) {
            _categoryList = _itemPoolModel.categorytList ?? [];
            if (_categoryList.length == 1) {
              _categoryList.addAll(_addCategory());
            }
            _tabController = TabController(
                length: _categoryList.length,
                vsync: this,
                initialIndex:
                    _categoryList.isEmpty ? 0 : _categoryList.length - 1)
              ..addListener(() {
                if (_tabController.index == _tabController.animation!.value) {
                  setState(() {
                    _activeIndex = _tabController.index;
                    _id = _categoryList[_activeIndex].categoryVO!.id as int?;
                    _page = 1;
                    _resultKey = '';
                    _itemPool(showProgress: true);
                  });
                }
              });
          }

          var searcherItemListResult = _itemPoolModel.searcherItemListResult!;
          if (_page == 1 || showProgress) {
            _result.clear();
            _isEmptyResult = searcherItemListResult.result!.isEmpty;
          }
          _result.addAll(searcherItemListResult.result!);
          _pagination = searcherItemListResult.pagination;
        });
      }
    }
  }

  void _itemPoolBar() async {
    Map<String, dynamic> params = {'promotionId': 0};
    var responseData = await itemPoolBar(params);
    if (mounted) {
      if (responseData.code == '200') {
        setState(() {
          _itemPoolBarModel = ItemPoolBarModel.fromJson(responseData.data);
        });
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  _addCategory() {
    List<CategorytListItem> categoryList = [];

    for (int i = 1; i < 4; i++) {
      var item1 = CategorytListItem();
      var categoryVO1 = item1.categoryVO = CategoryL1Item();
      categoryVO1.id = i;
      if (i == 1) {
        categoryVO1.name = '¥0～15';
      } else if (i == 2) {
        categoryVO1.name = '¥15～25';
      }
      if (i == 3) {
        categoryVO1.name = '¥25～40';
      }
      categoryList.add(item1);
    }
    return categoryList;
  }
}
