import 'package:cached_network_image/cached_network_image.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/net/DioManager.dart';
import 'package:flutter_app/utils/net_contants.dart';
import 'package:flutter_app/utils/router.dart';
import 'package:flutter_app/utils/toast.dart';
import 'package:flutter_app/utils/util_mine.dart';
import 'package:flutter_app/utils/widget_util.dart';
import 'package:flutter_app/widget/loading.dart';
import 'package:flutter_app/widget/sliver_footer.dart';
import 'package:flutter_app/widget/start_widget.dart';
import 'package:flutter_app/widget/tab_app_bar.dart';

class CommentList extends StatefulWidget {
  final Map arguments;

  CommentList({this.arguments});

  @override
  _CommentListState createState() => _CommentListState();
}

class _CommentListState extends State<CommentList> {
  var tag = '全部';
  int page = 1;
  var praise = {};
  bool isFirstLoading = true;
  var commentTags = [];
  var commentList = [];
  var pagination = {};
  var showTagsNum = 6;

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _getCommentPraise();
    _getCommentTags();
    reset();
    super.initState();


//    https://m.you.163.com/xhr/comment/listByItemByTag.json?itemId=1006013&page=1&tag=全部
//    https://m.you.163.com/xhr/comment/itemGoodRates.json    好评率  itemId: 1023014
//    https://m.you.163.com/xhr/comment/tags.json    //评价tag  itemId: 1023014

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        if (pagination.isNotEmpty) {
          if (pagination['totalPage'] > pagination['page']) {
            setState(() {
              page++;
            });
            _getCommentList();
          }
        }
      }
    });
  }

  void reset() {
    setState(() {
      isFirstLoading = true;
      page = 1;
      commentList.clear();
      commentList = [];
    });
    _getCommentList();
  }

  ///评价列表
  void _getCommentList() {
    var params = {
      'itemId': widget.arguments['id'],
      'page': page,
      'tag': tag,
    };
    DioManager.post(NetContants.commentList, params, (data) {
      setState(() {
        isFirstLoading = false;
        pagination = data['data']['pagination'];
        if (pagination['page'] == 1) {}
        commentList.addAll(data['data']['result']);
      });
    });
  }

  ///好评率
  void _getCommentPraise() {
    var params = {
      'itemId': widget.arguments['id'],
    };
    DioManager.post(NetContants.commentPraise, params, (data) {
      setState(() {
        praise = data['data'];
      });
    });
  }

  ///评价Tag
  void _getCommentTags() {
    var params = {
      'itemId': widget.arguments['id'],
    };
    DioManager.get(NetContants.commentTags, params, (data) {
      setState(() {
        commentTags = data['data'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TabAppBar(
        tabs: [],
        title: '评价',
      ).build(context),
      body: isFirstLoading
          ? Loading()
          : CustomScrollView(
              controller: _scrollController,
              slivers: <Widget>[
                WidgetUtil.buildASingleSliver(buildPraise()),
                WidgetUtil.buildASingleSliver(buildCommentTags()),
                WidgetUtil.buildASingleSliver(buildTagControl()),
                WidgetUtil.buildASingleSliver(buildLine()),
                buildCommentList(),
                SliverFooter(hasMore: pagination['totalPage'] > pagination['page'])
              ],
            ),
    );
  }

  Widget buildTagControl() {
    if (commentTags.length < 6) {
      return Container();
    } else {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: GestureDetector(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                showTagsNum == 6 ? '更多' : '收起',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              Icon(
                showTagsNum == 6 ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up,
                color: Colors.grey,
              )
            ],
          ),
          onTap: () {
            setState(() {
              if (showTagsNum == 6) {
                showTagsNum = commentTags.length;
              } else {
                showTagsNum = 6;
              }
            });
          },
        ),
      );
    }
  }

  Widget buildPraise() {
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
          Container(
            child: StaticRatingBar(
              size: 15,
              rate: (praise['star'] / 100) * 100,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              praise['goodCmtRate'],
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCommentTags() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: tags(),
      ),
    );
  }

  List<Widget> tags() {
    return List.generate(showTagsNum, (index) {
      return GestureDetector(
        child: Container(
          padding: EdgeInsets.fromLTRB(8, 5, 8, 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(2)),
              border: Border.all(
                  width: 0.5, color: tag == commentTags[index]['name'] ? Colors.red : Colors.grey)),
          child: Text(
            '${commentTags[index]['name'] + '(' + commentTags[index]['strCount'] + ')'}',
            style: TextStyle(color: tag == commentTags[index]['name'] ? Colors.red : Colors.grey),
          ),
        ),
        onTap: () {
          setState(() {
            this.tag = commentTags[index]['name'];
          });
          reset();
        },
      );
    });
  }

  Widget buildLine() {
    return Container(
      height: 0.5,
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(color: Colors.grey[200]),
    );
  }

  SliverList buildCommentList() {
    return SliverList(
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
      return Container(
        decoration:
            BoxDecoration(border: Border(bottom: BorderSide(width: 0.5, color: Colors.grey[200]))),
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        padding: EdgeInsets.only(bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                ClipOval(
                  child: Container(
                    width: 30,
                    height: 30,
                    child: CachedNetworkImage(
                      imageUrl: commentList[index]['frontUserAvatar'] == null
                          ? ''
                          : commentList[index]['frontUserAvatar'],
                      errorWidget: (context, url, error) {
                        return ClipOval(
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(color: Colors.grey),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Container(
                  child: Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Text(commentList[index]['frontUserName']),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 2),
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    color: Color(0xFFB19C6D),
                    borderRadius: BorderRadius.circular(2)
                  ),
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(color: Colors.grey, fontSize: 14,letterSpacing: -2),
                      children: [
                        TextSpan(
                          text: 'V',
                          style: TextStyle(color: Colors.white, fontStyle: FontStyle.italic,fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                            text: '${commentList[index]['memberLevel']}',
                            style: TextStyle(fontStyle: FontStyle.normal, fontSize: 8,color: Colors.white)),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: StaticRatingBar(
                    size: 15,
                    rate: double.parse(commentList[index]['memberLevel'].toString()),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              child: Text(
                '${DateUtil.getDateStrByMs(commentList[index]['createTime']) + '   ' + commentList[index]['skuInfo'][0]}',
                style: TextStyle(color: Colors.grey),
                maxLines: 2,
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 5),
              child: Text(commentList[index]['content']),
            ),
            Wrap(
              spacing: 2,
              runSpacing: 5,
              children: commentPic(
                  commentList[index]['picList'] == null ? [] : commentList[index]['picList']),
            ),
            buildCommentReplyVO(index),
            commentReplyVO(index),
          ],
        ),
      );
    }, childCount: commentList.length));
  }

  List<Widget> commentPic(List commentList) => List.generate(commentList.length, (indexC) {
        Widget widget = Container(
          width: 100,
          height: 100,
          child: CachedNetworkImage(
            imageUrl: commentList[indexC],
            fit: BoxFit.cover,
          ),
        );
        return Router.link(widget, Util.image, context, {'id': '${commentList[indexC]}'});
      });

  ///追评
  Widget buildCommentReplyVO(int index) {
    var appendCommentVO = this.commentList[index]['appendCommentVO'];
    if (appendCommentVO == null) {
      return Container();
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Text(
              '追评',
              style: TextStyle(color: Colors.red, fontSize: 16),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            child: Text(
              '${DateUtil.getDateStrByMs(appendCommentVO['createTime'])}',
              style: TextStyle(color: Colors.grey),
              maxLines: 2,
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 2),
            child: appendCommentVO['content'].isNotEmpty
                ? Text('${appendCommentVO['content']}')
                : Container(),
          ),
          Wrap(
            spacing: 2,
            runSpacing: 5,
            children:
                commentPic(appendCommentVO['picList'] == null ? [] : appendCommentVO['picList']),
          ),
        ],
      );
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }

  ///老板回复
  commentReplyVO(int index) {
    if (commentList[index]['commentReplyVO'] == null) {
      return Container();
    } else {
      return Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(5)),
        child: RichText(
          text: TextSpan(
            style: TextStyle(color: Colors.grey, fontSize: 14),
            children: [
              TextSpan(
                text: '小选回复:  ',
                style: TextStyle(color: Colors.black),
              ),
              TextSpan(
                text: '${commentList[index]['commentReplyVO']['replyContent']}',
              ),
            ],
          ),
        ),
      );
    }
  }
}
