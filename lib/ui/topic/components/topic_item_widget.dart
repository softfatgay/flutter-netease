import 'package:flutter/material.dart';
import 'package:flutter_app/component/round_net_image.dart';
import 'package:flutter_app/component/top_round_net_image.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/ui/router/router.dart';
import 'package:flutter_app/ui/topic/model/topicItem.dart';

class TopicItemWidget extends StatelessWidget {
  final TopicItem? item;

  const TopicItemWidget({Key? key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildItem(context, item!);
  }

  _buildItem(BuildContext context, TopicItem item) {
    Widget widget = Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(6)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _image(item),
          _desText(item),
          _suggestUser(item),
          _buyBtn(context, item),
        ],
      ),
    );
    String schemeUrl = item.schemeUrl!;
    if (!schemeUrl.startsWith('http')) {
      schemeUrl = 'https://m.you.163.com$schemeUrl';
    }
    return Routers.link(widget, Routers.webView, context, {'url': schemeUrl});
  }

  _suggestUser(TopicItem item) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          RoundNetImage(
            url: item.avatar,
            height: 20,
            width: 20,
            corner: 10,
          ),
          Expanded(
            child: Container(
              child: Container(
                margin: EdgeInsets.only(left: 5),
                child: Text(
                  item.nickname ?? '',
                  style: t12grey,
                ),
              ),
            ),
          ),
          Container(
              child: item.readCount == null
                  ? Container()
                  : Icon(
                      Icons.remove_red_eye,
                      color: textGrey,
                      size: 16,
                    )),
          Container(
            child: Text(
              item.readCount == null
                  ? ''
                  : (item.readCount! > 1000
                      ? '${int.parse((item.readCount! / 1000).toStringAsFixed(0))}K'
                      : '${item.readCount}'),
              style: t12grey,
            ),
          ),
        ],
      ),
    );
  }

  _desText(TopicItem item) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Text(
        item.title!,
        textAlign: TextAlign.left,
        style: t14black,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  _image(TopicItem item) {
    return Expanded(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
        ),
        child: Container(
          child: TopRoundNetImage(
            corner: 6,
            url: _getImage(item),
          ),
        ),
      ),
    );
  }

  _getImage(TopicItem item) {
    if (item.newAppBanner != null && item.newAppBanner!.isNotEmpty) {
      return item.newAppBanner;
    }
    return item.picUrl;
  }

  _buyBtn(BuildContext context, TopicItem item) {
    var buyNow = item.buyNow;
    return buyNow == null
        ? Container()
        : GestureDetector(
            child: Container(
              decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: lineColor, width: 1))),
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                      child: Text(
                    '${buyNow.itemName}',
                    style: t12black,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )),
                  Text(
                    '去购买',
                    style: t12red,
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 12,
                    color: textRed,
                  )
                ],
              ),
            ),
            onTap: () {
              Routers.push(
                  Routers.goodDetail, context, {'id': '${buyNow.itemId}'});
            },
          );
  }
}
