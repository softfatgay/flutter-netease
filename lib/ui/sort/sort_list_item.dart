import 'package:flutter/material.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/ui/sort/good_item.dart';
import 'package:flutter_app/utils/user_config.dart';
import 'package:flutter_app/widget/footer.dart';
import 'package:flutter_app/widget/loading.dart';
import 'package:flutter_app/widget/slivers.dart';

class SortListItem extends StatefulWidget {
  var arguments;

  SortListItem({this.arguments});

  @override
  _CatalogGoodsState createState() => _CatalogGoodsState();
}

///AutomaticKeepAliveClientMixin  保持滑动不刷新  重写方法 bool get wantKeepAlive => true;
class _CatalogGoodsState extends State<SortListItem>
    with AutomaticKeepAliveClientMixin {
  bool isLoading = true;
  int total = 0;
  List dataList = [];

  bool moreLoading = false;

  ScrollController _scrollController = new ScrollController();

  List itemList = [];
  var category;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getInitData();

    _scrollController.addListener(() {
      // 如果下拉的当前位置到scroll的最下面
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (!moreLoading && (total > dataList.length)) {
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
      "subCategoryId": widget.arguments["id"],
      "categoryId": widget.arguments["superCategoryId"],
    };
    var responseData = await sortListData(map);
    print("========================================");
    print(responseData.data);
    var data = responseData.data;
    setState(() {
      dataList = data["categoryItems"]["itemList"];
      category = data["categoryItems"]["category"];
      isLoading = false;
      total = dataList.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Loading();
    } else {
      return RefreshIndicator(
        onRefresh: _refresh,
        child: CustomScrollView(
          controller: _scrollController,
          slivers: <Widget>[
            category["frontName"] == null || category["frontName"] == ""
                ? singleSliverWidget(Container())
                : SliverPadding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    sliver: singleSliverWidget(Container(
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: Text(category["frontName"]),
                      ),
                    )),
                  ),
            GoodItemWidget(dataList: dataList),
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
    if (dataList.length == total) {
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
