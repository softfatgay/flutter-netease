import 'package:flutter/material.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/model/category.dart';
import 'package:flutter_app/model/itemListItem.dart';
import 'package:flutter_app/ui/sort/good_item_widget.dart';
import 'package:flutter_app/ui/sort/model/sortListData.dart';
import 'package:flutter_app/utils/user_config.dart';
import 'package:flutter_app/widget/footer.dart';
import 'package:flutter_app/widget/loading.dart';
import 'package:flutter_app/widget/slivers.dart';

class SortListItemPage extends StatefulWidget {
  var arguments;

  SortListItemPage({this.arguments});

  @override
  _CatalogGoodsState createState() => _CatalogGoodsState();
}

///AutomaticKeepAliveClientMixin  保持滑动不刷新  重写方法 bool get wantKeepAlive => true;
class _CatalogGoodsState extends State<SortListItemPage>
    with AutomaticKeepAliveClientMixin {
  bool _isLoading = true;
  int _total = 0;
  bool _moreLoading = false;
  ScrollController _scrollController = new ScrollController();
  Category category;

  ///商品
  List<ItemListItem> _itemList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getInitData();

    _scrollController.addListener(() {
      // 如果下拉的当前位置到scroll的最下面
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (!_moreLoading && (_total > _itemList.length)) {
          // _getMore();
        }
      }
    });
  }

  _getInitData() async {
    var map = {
      "csrf_token": csrf_token,
      "__timestamp": "${DateTime.now().millisecondsSinceEpoch}",
      "categoryType": "0",
      "subCategoryId": widget.arguments.id,
      "categoryId": widget.arguments.superCategoryId,
    };
    var responseData = await sortListData(map);
    var data = responseData.data;
    var sortListDataModel = SortListData.fromJson(data);

    setState(() {
      _itemList = sortListDataModel.categoryItems.itemList;

      category = sortListDataModel.categoryItems.category;

      // category = data["categoryItems"]["category"];
      _isLoading = false;
      _total = _itemList.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Loading();
    } else {
      return RefreshIndicator(
        onRefresh: _refresh,
        child: CustomScrollView(
          controller: _scrollController,
          slivers: <Widget>[
            category.frontName == null || category.frontName == ""
                ? singleSliverWidget(Container())
                : SliverPadding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    sliver: singleSliverWidget(Container(
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: Text(category.frontName),
                      ),
                    )),
                  ),
            GoodItemWidget(dataList: _itemList),
            singleSliverWidget(buildFooter()),
          ],
        ),
      );
    }
  }

  Future _refresh() async {
    _getInitData();
  }

  Widget buildFooter() {
    if (_itemList.length == _total) {
      return NoMoreText();
    } else {
      return Loading();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
