import 'package:cached_network_image/cached_network_image.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/ui/goods_detail/components/common_item_widget.dart';
import 'package:flutter_app/ui/goods_detail/model/commentsItem.dart';
import 'package:flutter_app/ui/goods_detail/model/commondPageModel.dart';
import 'package:flutter_app/ui/router/router.dart';
import 'package:flutter_app/component/global.dart';
import 'package:flutter_app/component/round_net_image.dart';
import 'package:flutter_app/component/start_widget.dart';

typedef void OnPress();

///商品详情品论展示区
class GoodDetailCommentWidget extends StatelessWidget {
  final List<ResultItem>? comments;
  final num? commentCount;
  final String? goodCmtRate;
  final OnPress? onPress;
  final num? goodId;

  const GoodDetailCommentWidget(
      {Key? key,
      this.comments,
      this.commentCount = 0,
      this.goodCmtRate,
      this.goodId,
      this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildWidget(context);
  }

  _buildWidget(BuildContext context) {
    ResultItem item;
    if (comments!.length > 0) {
      item = comments![0];
    }
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            '${goodCmtRate ?? ''}',
                            style: t16red,
                          ),
                          Text(
                            (goodCmtRate == null || goodCmtRate == '')
                                ? '查看全部'
                                : '好评率',
                            style: t14black,
                          ),
                        ],
                      ),
                    ),
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
            if (comments!.length > 0)
              CommonItemWidget(
                item: comments![0],
              ),
          ],
        ));
  }
}
