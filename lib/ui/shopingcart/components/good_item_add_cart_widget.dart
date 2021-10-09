import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/model/itemTagListItem.dart';
import 'package:flutter_app/ui/goods_detail/model/goodDetail.dart';
import 'package:flutter_app/ui/shopingcart/components/add_good_size_widget.dart';
import 'package:flutter_app/ui/router/router.dart';
import 'package:flutter_app/component/my_vertical_text.dart';
import 'package:flutter_app/component/slivers.dart';
import 'package:flutter_app/component/top_round_net_image.dart';
import 'package:flutter_app/utils/price_util.dart';

const marginS = 8.0;
const mrr = 5.0;

typedef void AddCarSuccess();

class GoodItemAddCartWidget extends StatelessWidget {
  final List<GoodDetail> dataList;
  final AddCarSuccess addCarSuccess;

  const GoodItemAddCartWidget({Key key, this.dataList, this.addCarSuccess})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildItems(dataList);
  }

  _buildItems(List<GoodDetail> data) {
    return data.isEmpty
        ? buildASingleSliverGrid(Container(), 2)
        : SliverPadding(
            padding:
                EdgeInsets.symmetric(horizontal: marginS, vertical: marginS),
            sliver: SliverGrid(
              delegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
                Widget widget = Container(
                  width: double.infinity,
                  decoration: BoxDecoration(color: Colors.transparent),
                  child: _buildGoodItem(context, index, data),
                );
                return GestureDetector(
                  child: widget,
                  onTap: () {
                    print(data[index]);
                    Routers.push(
                        Routers.goodDetail, context, {'id': data[index].id});
                  },
                );
              }, childCount: data.length),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.55,
                  mainAxisSpacing: 0,
                  crossAxisSpacing: marginS),
            ),
          );
  }

  _buildGoodItem(BuildContext context, int index, List<GoodDetail> dataList) {
    var item = dataList[index];
    var imgHeight = MediaQuery.of(context).size.width / 2;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: imgHeight,
            child: Stack(
              children: [
                _roundImg(
                  item.listPicUrl,
                ),
                if (item.colorNum != null && item.colorNum > 0)
                  Container(
                    padding: EdgeInsets.fromLTRB(1, 2, 1, 2),
                    decoration: BoxDecoration(
                      color: Color(0XFFF4F4F4),
                      border: Border.all(color: Color(0xFFA28C63), width: 0.5),
                      borderRadius: BorderRadius.circular(1),
                    ),
                    margin: EdgeInsets.only(top: 5, left: 5),
                    child: MyVerticalText(
                      '${item.colorNum}色可选',
                      TextStyle(color: Color(0xFFA28C63), fontSize: 10),
                    ),
                  ),
                if (item.promDesc != null)
                  Positioned(
                    bottom: 10,
                    left: 10,
                    child: _promDesc(item.promDesc),
                  ),
                if (item.topLogo != null)
                  Positioned(
                    top: 10,
                    right: 5,
                    child: CachedNetworkImage(
                      imageUrl: '${item.topLogo.logoUrl}',
                      width: 20,
                    ),
                  )
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(top: 3),
                child: Text(
                  '${dataList[index].name}',
                  style: t15blackBold,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              _price(item),
              _priceDec(item),
              if (_isShowTips(item))
                Container(
                  margin: EdgeInsets.only(top: 3),
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    '${_getBannerContent(item)}',
                    style: TextStyle(
                        color: textRed,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        height: 1),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
            ],
          ),
          Row(
            children: [
              GestureDetector(
                child: Container(
                  margin: EdgeInsets.only(top: 3),
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 4),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: item.sellVolume == 0 ? lineColor : textBlack,
                        width: 0.5),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Text(
                    '加入购物车',
                    style: TextStyle(
                        fontSize: 12,
                        height: 1.1,
                        color: item.sellVolume == 0 ? lineColor : textBlack),
                  ),
                ),
                onTap: () {
                  if (item.sellVolume != 0) {
                    _buildSizeModel(context, item);
                  }
                },
              ),
              if (item.sellVolume == 0)
                Container(
                  margin: EdgeInsets.only(top: 3, left: 8),
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 4),
                  decoration: BoxDecoration(
                    border: Border.all(color: lineColor, width: 0.5),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    '售罄',
                    style: TextStyle(
                        fontSize: 12, height: 1.1, color: textLightGrey),
                  ),
                )
            ],
          )
        ],
      ),
    );
  }

  _isShowTips(GoodDetail item) {
    bool isShow = false;
    if (item.finalPriceInfoVO.banner != null) {
      var banner = item.finalPriceInfoVO.banner;
      if ((banner.content != null &&
              banner.content.length > 7 &&
              banner.title != banner.content) &&
          !(banner.title == null && banner.content != null)) {
        isShow = true;
      }
    }
    return isShow;
  }

  _getBannerContent(GoodDetail item) {
    var content = '';
    if (item.finalPriceInfoVO.banner != null) {
      content = item.finalPriceInfoVO.banner.content ?? '';
    }
    return content;
  }

  _priceDec(GoodDetail item) {
    var finalPriceInfoVO = item.finalPriceInfoVO;
    var banner = finalPriceInfoVO.banner;
    if (banner == null) {
      return Container();
    } else {
      if (banner.title == null && banner.content != null) {
        return Container(
          margin: EdgeInsets.only(top: 5),
          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          decoration: BoxDecoration(
              color: backRed,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Color(0xFFFFE9EB), width: 1)),
          child: Text(
            '${banner.content}',
            style: TextStyle(fontSize: 12, color: textWhite, height: 1.1),
          ),
        );
      }
    }
    return Container(
      margin: EdgeInsets.only(top: 5),
      decoration: BoxDecoration(
        color: Color(0xFFFFE9EB),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            decoration: BoxDecoration(
                color: backRed,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Color(0xFFFFE9EB), width: 1)),
            child: Text(
              '${banner.title}',
              style: TextStyle(fontSize: 12, color: textWhite, height: 1.1),
            ),
          ),
          SizedBox(width: 3),
          if (_getBannerContent(item).length <= 7)
            Text(
              '${_getBannerContent(item)}',
              style: t12redBold,
            )
        ],
      ),
    );
  }

  _price(GoodDetail item) {
    List<String> priceToStr = ['', ''];
    String pricePrefix = '';
    String priceSuffix = '';
    String counterPrice = '';
    var finalPrice = item.finalPriceInfoVO.priceInfo.finalPrice;
    counterPrice = item.finalPriceInfoVO.priceInfo.counterPrice;
    if (finalPrice != null) {
      priceToStr = PriceUtil.priceToStr(finalPrice.price);
      pricePrefix = finalPrice.prefix ?? '';
      priceSuffix = finalPrice.suffix ?? '';
    } else {
      priceToStr = PriceUtil.priceToStr(item.retailPrice.toString());
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text("$pricePrefix¥", style: t12redBold),
        Text(
          "${priceToStr[0]}",
          style: t20redBold,
        ),
        Text(
          "${priceToStr[1]}$priceSuffix",
          style: t12redBold,
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          _getCounterPrice(item) == null
              ? ""
              : "¥${_getCounterPrice(item) ?? ''}",
          style: TextStyle(
              color: textGrey,
              decoration: TextDecoration.lineThrough,
              fontSize: 11),
        ),
      ],
    );
  }

  _getCounterPrice(GoodDetail item) {
    var finalCounterPrice = item.finalPriceInfoVO.priceInfo.counterPrice;
    var counterPrice = finalCounterPrice ?? (item.counterPrice ?? null);
    return counterPrice;
  }

  _promDesc(String dec) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
          color: backWhite,
          border: Border.all(color: textRed, width: 1),
          borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/good_red.png',
            width: 7,
          ),
          SizedBox(width: 2),
          Text(
            '$dec',
            style: t12red,
          ),
        ],
      ),
    );
  }

  _roundImg(String url) {
    return Container(
      child: CachedNetworkImage(
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Color(0xFFF4F4F4),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
        imageUrl: url,
      ),
    );
  }

  ///属性选择底部弹窗
  _buildSizeModel(BuildContext context, GoodDetail item) {
    //底部弹出框,背景圆角的话,要设置全透明,不然会有默认你的白色背景
    return showModalBottomSheet(
      //设置true,不会造成底部溢出
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return AddGoodSizeWidget(
          goodDetail: item,
          addCarSuccess: () {
            if (addCarSuccess != null) {
              addCarSuccess();
            }
          },
        );
      },
    );
  }
}
