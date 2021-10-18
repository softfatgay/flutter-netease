import 'package:flutter/material.dart';
import 'package:flutter_app/component/app_bar.dart';
import 'package:flutter_app/component/floating_action_button.dart';
import 'package:flutter_app/component/loading.dart';
import 'package:flutter_app/component/sliver_footer.dart';
import 'package:flutter_app/component/slivers.dart';
import 'package:flutter_app/component/start_widget.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/model/pagination.dart';
import 'package:flutter_app/ui/goods_detail/components/common_item_widget.dart';
import 'package:flutter_app/ui/goods_detail/components/flow_widget.dart';
import 'package:flutter_app/ui/goods_detail/model/commentItem.dart';
import 'package:flutter_app/ui/goods_detail/model/commondPageModel.dart';

class CommentList extends StatefulWidget {
  final Map? params;

  CommentList({this.params});

  @override
  _CommentListState createState() => _CommentListState();
}

class _CommentListState extends State<CommentList> {
  var _tag = '全部';
  var _checkedItem = '全部';
  int _page = 1;
  Praise _praise = Praise();
  bool _isFirstLoading = true;

  var _showTagsNum = 6;

  List<CommentItem> _commentTags = [];

  final _scrollController = ScrollController();

  ///总数据
  late CommondPageModel _commondPageModel;
  Pagination? _pagination;

  ///数据列表
  List<ResultItem> _commentList = [];

  @override
  void initState() {
    _getCommentPraise();
    _getCommentTags();
    _reset();
    super.initState();

//    https://m.you.163.com/xhr/comment/listByItemByTag.json?itemId=1006013&page=1&tag=全部
//    https://m.you.163.com/xhr/comment/itemGoodRates.json    好评率  itemId: 1023014
//    https://m.you.163.com/xhr/comment/tags.json    //评价tag  itemId: 1023014

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (_pagination!.totalPage! > _pagination!.page!) {
          setState(() {
            _page++;
          });
          _getCommentList();
        }
      }
    });
  }

  void _reset() {
    setState(() {
      _page = 1;
      _commentList.clear();
      _commentList = [];
    });
    _getCommentList();
  }

  ///评价列表
  void _getCommentList() async {
    Map<String, dynamic> params = {
      'itemId': widget.params!['id'],
      'page': _page,
      'tag': _tag,
    };
    var responseData = await commentListData(params);
    setState(() {
      _isFirstLoading = false;
      _commondPageModel = CommondPageModel.fromJson(responseData.data);
      _pagination = _commondPageModel.pagination;
      List<ResultItem> commentList = _commondPageModel.result!;
      _commentList.addAll(commentList);
    });
  }

  ///好评率
  void _getCommentPraise() async {
    var params = {'itemId': widget.params!['id']};
    var responseData = await commentPraiseApi(params);
    setState(() {
      _praise = Praise.fromJson(responseData.data);
    });
  }

  ///评价Tag
  void _getCommentTags() async {
    var params = {'itemId': widget.params!['id']};
    var responseData = await commentTagsApi(params);
    List data = responseData.data;
    List<CommentItem> list = [];
    data.forEach((element) {
      list.add(CommentItem.fromJson(element));
    });
    setState(() {
      _commentTags = list;
      if (_commentTags.length > 6) {
        _showTagsNum = 6;
      } else {
        _showTagsNum = _commentTags.length;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopAppBar(
        title: '评价',
      ).build(context),
      body: _isFirstLoading
          ? Loading()
          : CustomScrollView(
              controller: _scrollController,
              slivers: <Widget>[
                singleSliverWidget(_buildPraise()),
                singleSliverWidget(_buildCommentTags()),
                singleSliverWidget(_buildTagControl()),
                singleSliverWidget(_buildLine()),
                (_commentList == null || _commentList.isEmpty)
                    ? singleSliverWidget(Container(
                        child: Center(
                          child: Text(
                            "",
                            style: t18blackbold,
                          ),
                        ),
                      ))
                    : _buildCommentList(),
                SliverFooter(
                    hasMore: _pagination!.totalPage! > _pagination!.page! ||
                        (_commentList.length == 0))
              ],
            ),
      floatingActionButton: floatingAB(_scrollController),
    );
  }

  _buildTagControl() {
    if (_commentTags.length < 6) {
      return Container(height: 20);
    } else {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: GestureDetector(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  _showTagsNum == _commentTags.length ? '收起' : '更多',
                  style: t14grey,
                ),
                SizedBox(width: 4),
                Image.asset(
                  _showTagsNum == _commentTags.length
                      ? 'assets/images/arrow_up.png'
                      : 'assets/images/arrow_down.png',
                  width: 16,
                  height: 16,
                ),
              ],
            ),
          ),
          onTap: () {
            setState(() {
              if (_showTagsNum < _commentTags.length) {
                _showTagsNum = _commentTags.length;
              } else {
                if (_commentTags.length < 6) {
                  _showTagsNum = _commentTags.length;
                } else {
                  _showTagsNum = 6;
                }
              }
            });
          },
        ),
      );
    }
  }

  _buildPraise() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 5),
            child: Text(
              '评分',
              style: TextStyle(color: Colors.black),
            ),
          ),
          if (_praise.star != null)
            Container(
              child: StaticRatingBar(
                size: 15,
                rate: (_praise.star! / 100) * 100,
              ),
            ),
          if (_praise.goodCmtRate != null)
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                _praise.goodCmtRate!,
                style: TextStyle(color: Colors.grey),
              ),
            ),
        ],
      ),
    );
  }

  _buildCommentTags() {
    if (_commentTags.isEmpty) {
      return Loading();
    } else {
      List items = [];
      _commentTags.forEach((item) {
        items.add('${item.name}(${item.strCount})');
      });
      return Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: FlowWidget(
            items: items,
            checkedItem: _checkedItem,
            showItemCount: _showTagsNum,
            onTap: (index) {
              setState(() {
                this._tag = '${_commentTags[index].name}';
                this._checkedItem =
                    '${_commentTags[index].name}(${_commentTags[index].strCount})';
              });
              _reset();
            },
          ));
    }
  }

  _buildLine() {
    return Container(
      height: 0.5,
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(color: Colors.grey[200]),
    );
  }

  _buildCommentList() {
    return SliverList(
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
      return CommonItemWidget(item: _commentList[index]);
    }, childCount: _commentList.length));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    super.dispose();
  }
}
