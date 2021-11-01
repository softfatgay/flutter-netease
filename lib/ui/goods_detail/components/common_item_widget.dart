import 'package:cached_network_image/cached_network_image.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/component/round_net_image.dart';
import 'package:flutter_app/component/star_widget.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/ui/goods_detail/model/commondPageModel.dart';
import 'package:flutter_app/ui/router/router.dart';

class CommonItemWidget extends StatelessWidget {
  final ResultItem? item;

  const CommonItemWidget({Key? key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildItem(context);
  }

  _buildItem(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(width: 0.5, color: Colors.grey[200]!))),
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
                    imageUrl: item!.frontUserAvatar == null
                        ? ''
                        : item!.frontUserAvatar!,
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
                  child: Text(item!.frontUserName!),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 2),
                margin: EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                    color: Color(0xFFB19C6D),
                    borderRadius: BorderRadius.circular(2)),
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                        color: Colors.grey, fontSize: 14, letterSpacing: -2),
                    children: [
                      TextSpan(
                        text: 'V',
                        style: TextStyle(
                            color: Colors.white,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                          text: '${item!.memberLevel}',
                          style: TextStyle(
                              fontStyle: FontStyle.normal,
                              fontSize: 8,
                              color: Colors.white)),
                    ],
                  ),
                ),
              ),
              Container(
                child: StaticRatingBar(
                  size: 15,
                  rate: double.parse(
                      item!.star == null ? '0' : item!.star!.toString()),
                ),
              ),
              Expanded(
                child: item!.commentItemTagVO == null
                    ? Container()
                    : Container(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          child: Image.asset(
                              item!.commentItemTagVO!.type == 1
                                  ? 'assets/images/commond_look.png'
                                  : '',
                              height: 40,
                              width: 40),
                          onTap: () {
                            Routers.push(Routers.lookPage, context);
                          },
                        ),
                      ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            child: Text(
              '${DateUtil.formatDateMs(item!.createTime as int) + '   ' + item!.skuInfo![0]}',
              style: t12grey,
              maxLines: 2,
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 5),
            child: Text(
              item!.content!,
              style: t14black,
            ),
          ),
          Wrap(
            spacing: 5,
            runSpacing: 5,
            children: _commentPic(
                context, item!.picList == null ? [] : item!.picList!),
          ),
          _buildCommentReplyVO(context),
          _commentReplyVO(),
        ],
      ),
    );
  }

  List<Widget> _commentPic(BuildContext context, List _commentList) =>
      List.generate(_commentList.length, (indexC) {
        Widget widget = Container(
          width: (MediaQuery.of(context).size.width - 42) / 4,
          height: (MediaQuery.of(context).size.width - 42) / 4,
          child: RoundNetImage(
            url: _commentList[indexC],
            corner: 3,
          ),
        );
        return Routers.link(widget, Routers.image, context,
            {'images': _commentList, 'page': indexC});
      });

  ///追评
  _buildCommentReplyVO(BuildContext context) {
    var appendCommentVO = item!.appendCommentVO;
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
              '${DateUtil.formatDateMs(appendCommentVO.createTime as int)}',
              style: TextStyle(color: Colors.grey),
              maxLines: 2,
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 2),
            child: appendCommentVO.content!.isNotEmpty
                ? Text('${appendCommentVO.content}')
                : Container(),
          ),
          Wrap(
            spacing: 2,
            runSpacing: 5,
            children: _commentPic(
                context,
                appendCommentVO.picList == null
                    ? []
                    : appendCommentVO.picList!),
          ),
        ],
      );
    }
  }

  ///老板回复
  _commentReplyVO() {
    if (item!.commentReplyVO == null) {
      return Container();
    } else {
      return Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: Colors.grey[100], borderRadius: BorderRadius.circular(5)),
        child: RichText(
          text: TextSpan(
            style: TextStyle(color: Colors.grey, fontSize: 14),
            children: [
              TextSpan(
                text: '小选回复:  ',
                style: TextStyle(color: Colors.black),
              ),
              TextSpan(
                text: '${item!.commentReplyVO!.replyContent}',
              ),
            ],
          ),
        ),
      );
    }
  }
}
