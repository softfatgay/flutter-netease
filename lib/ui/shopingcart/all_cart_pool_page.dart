import 'package:flutter/material.dart';
import 'package:flutter_app/component/back_loading.dart';
import 'package:flutter_app/component/floating_action_button.dart';
import 'package:flutter_app/component/sliver_footer.dart';
import 'package:flutter_app/component/tab_app_bar.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/model/pagination.dart';
import 'package:flutter_app/ui/goods_detail/model/goodDetail.dart';
import 'package:flutter_app/ui/shopingcart/components/bottom_pool_widget.dart';
import 'package:flutter_app/ui/shopingcart/components/good_item_add_cart_widget.dart';
import 'package:flutter_app/ui/shopingcart/model/itemPoolBarModel.dart';
import 'package:flutter_app/ui/shopingcart/model/itemPoolModel.dart';

///去凑单，未达到包邮条件
class AllCartItemPoolPage extends StatefulWidget {
  const AllCartItemPoolPage({Key key}) : super(key: key);

  @override
  _AllCartItemPoolPageState createState() => _AllCartItemPoolPageState();
}

class _AllCartItemPoolPageState extends State<AllCartItemPoolPage>
    with TickerProviderStateMixin {
  int _page = 1;
  int _pageSize = 10;

  bool _isLoading = true;

  int _activeIndex = 0;
  TabController _tabController;
  List<CategorytListItem> _categorytList = [];
  List<GoodDetail> _result = [];
  Pagination _pagination;
  int _id = 3;
  ItemPoolModel _itemPoolModel;

  var _itemPoolBarModel = ItemPoolBarModel(0, '');
  final _scrollController = ScrollController();
  bool _isShowFloatBtn = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: _categorytList.length, vsync: this);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels > 500) {
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
  }

  @override
  Widget build(BuildContext context) {
    List<String> tabItem = [];
    for (int i = 0; i < (_categorytList.length); i++) {
      tabItem.add(_categorytList[i].categoryVO.name);
    }
    return Scaffold(
      appBar: TabAppBar(
        controller: _tabController,
        tabs: tabItem,
        isScrollable: false,
        title: '${tabItem.length > 0 ? tabItem[_activeIndex] : ''}',
      ).build(context),
      body: _buildBody(),
      floatingActionButton:
          _isShowFloatBtn ? floatingAB(_scrollController) : Container(),
    );
  }

  _buildBody() {
    return Container(
      child: _isLoading
          ? Loading()
          : Stack(
              children: [
                Positioned(
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
                          hasMore: _pagination.totalPage > _pagination.page)
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
        if (_categorytList.isEmpty) {
          _categorytList = _itemPoolModel.categorytList;
          _tabController = TabController(
              length: _categorytList.length,
              vsync: this,
              initialIndex: _categorytList.length - 1)
            ..addListener(() {
              if (_tabController.index == _tabController.animation.value) {
                setState(() {
                  _activeIndex = _tabController.index;
                  _id = _categorytList[_activeIndex].categoryVO.id;
                  _page = 1;
                  _itemPool();
                });
              }
            });
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

  void _itemPoolBar() async {
    Map<String, dynamic> params = {'promotionId': 0};
    var responseData = await itemPoolBar(params);
    if (responseData.code == '200') {
      setState(() {
        _itemPoolBarModel = ItemPoolBarModel.fromJson(responseData.data);
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
