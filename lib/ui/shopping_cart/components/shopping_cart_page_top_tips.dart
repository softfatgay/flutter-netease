import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/component/global.dart';
import 'package:flutter_app/component/service_tag_widget.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/ui/router/router.dart';
import 'package:flutter_app/ui/shopping_cart/model/postageVO.dart';

class TopTipsWidget extends StatelessWidget {
  final PostageVO postageVO;
  final Function callBack;

  const TopTipsWidget(
      {Key? key, required this.postageVO, required this.callBack})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildTopTips(context);
  }

  _buildTopTips(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          postageVO.postageTip == null ? ServerTagWidget() : _tips(context),
        ],
      ),
    );
  }

  _tips(BuildContext context) {
    var postFree = postageVO.postFree ?? false;
    return GestureDetector(
      child: Container(
        alignment: Alignment.centerLeft,
        color: Color(0xFFFFF8D8),
        padding: EdgeInsets.symmetric(horizontal: 15),
        height: 40,
        child: Row(
          children: [
            Expanded(
              child: Text(
                '${postageVO.postageTip ?? ''}',
                style: t14Orange,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (!postFree) arrowRightIcon
          ],
        ),
      ),
      onTap: () {
        if (!postFree) {
          Routers.push(Routers.cartItemPoolPage, context, {}, (value) {
            callBack();
          });
        }
      },
    );
  }
}
