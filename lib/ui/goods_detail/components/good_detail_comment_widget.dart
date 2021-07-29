import 'package:cached_network_image/cached_network_image.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/ui/goods_detail/model/commentsItem.dart';
import 'package:flutter_app/utils/router.dart';
import 'package:flutter_app/widget/global.dart';
import 'package:flutter_app/widget/round_net_image.dart';
import 'package:flutter_app/widget/start_widget.dart';

typedef void OnPress();

///商品详情品论展示区
class GoodDetailCommentWidget extends StatelessWidget {
  final List<CommentsItem> comments;
  final num commentCount;
  final String goodCmtRate;
  final OnPress onPress;
  final num goodId;

  const GoodDetailCommentWidget(
      {Key key,
      this.comments,
      this.commentCount,
      this.goodCmtRate,
      this.goodId,
      this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildWidget(context);
  }

  _buildWidget(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            InkResponse(
              highlightColor: Colors.transparent,
              radius: 0,
              onTap: () {
                Routers.push(Routers.comment, context, {'id': goodId});
              },
              child: Container(
                height: 50,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Text(
                        '用户评价($commentCount)',
                        style: t14black,
                      ),
                    ),
                    Expanded(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          goodCmtRate == null ? "" : goodCmtRate,
                          style: t16red,
                        ),
                        Text(
                          (goodCmtRate == null || goodCmtRate == '')
                              ? '查看全部'
                              : '好评率',
                          style: t12black,
                        ),
                      ],
                    )),
                    arrowRightIcon
                  ],
                ),
              ),
            ),
            Container(
              height: 0.5,
              width: double.infinity,
              margin: EdgeInsets.only(left: 10),
              color: lineColor,
            ),
            comments.length > 0
                ? Container(
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
                                  imageUrl: comments[0].frontUserAvatar ?? '',
                                  errorWidget: (context, url, error) {
                                    return ClipOval(
                                      child: Container(
                                        width: 30,
                                        height: 30,
                                        decoration:
                                            BoxDecoration(color: Colors.grey),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            Container(
                              child: Container(
                                margin: EdgeInsets.only(left: 10),
                                child:
                                    Text('${comments[0].frontUserName ?? ''}'),
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
                                      color: Colors.grey,
                                      fontSize: 14,
                                      letterSpacing: -2),
                                  children: [
                                    TextSpan(
                                      text: 'V',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                        text: '${comments[0].memberLevel}',
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
                                    comments[0].memberLevel.toString()),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          child: Text(
                            '${DateUtil.formatDateMs(comments[0].createTime) + '   ' + comments[0].skuInfo[0]}',
                            style: t12grey,
                            maxLines: 2,
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 5),
                          child: Text(
                            '${comments[0].content}',
                            style: t14black,
                          ),
                        ),
                        Wrap(
                          spacing: 5,
                          runSpacing: 5,
                          children:
                              commentPic(context, comments[0].picList ?? []),
                        )
                      ],
                    ),
                  )
                : Container(),
          ],
        ));
  }

  List<Widget> commentPic(BuildContext context, List commentList) =>
      List.generate(commentList.length, (indexC) {
        Widget widget = Container(
          width: (MediaQuery.of(context).size.width - 40) / 4,
          height: (MediaQuery.of(context).size.width - 40) / 4,
          child: RoundNetImage(
            url: commentList[indexC],
            fit: BoxFit.cover,
            corner: 2,
          ),
        );
        return Routers.link(widget, Routers.image, context,
            {'images': commentList, 'page': indexC});
      });
}
