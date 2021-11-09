import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/component/back_loading.dart';
import 'package:flutter_app/component/button_widget.dart';
import 'package:flutter_app/component/floating_action_button.dart';
import 'package:flutter_app/component/global.dart';
import 'package:flutter_app/component/indicator_banner.dart';
import 'package:flutter_app/component/net_image.dart';
import 'package:flutter_app/component/round_net_image.dart';
import 'package:flutter_app/component/sliver_custom_header_delegate.dart';
import 'package:flutter_app/component/slivers.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/globle/scrollState.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/ui/mine/layway/model/laywayDetailModel.dart';
import 'package:flutter_app/ui/router/router.dart';
import 'package:flutter_app/utils/constans.dart';

class LaywayDetailPage extends StatefulWidget {
  final Map? params;

  const LaywayDetailPage({Key? key, this.params}) : super(key: key);

  @override
  _LaywayDetailPageState createState() => _LaywayDetailPageState();
}

class _LaywayDetailPageState extends State<LaywayDetailPage> {
  final _scrollState = ValueNotifier<ScrollState>(ScrollState.shoppingCart);

  final _scrollController = ScrollController();

  num _id = 0;

  late LayawayInModel _layawayModel;
  List<MoreLayawayListItemModel> _moreLayawayList = [];
  List<PolicyListItemModel> _policyList = [];

  List<String> _banner = [];

  bool _isLoading = true;

  List<String> _detailImages = [];

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      _id = widget.params!['id'];
    });
    super.initState();
    _scrollController.addListener(_scrollerListener);
    _layawayDetail();
  }

  void _scrollerListener() {
    if (_scrollController.position.pixels > 500) {
      if (_scrollState.value == ScrollState.shoppingCart) {
        _scrollState.value = ScrollState.toTop;
      }
    } else {
      if (_scrollState.value == ScrollState.toTop) {
        _scrollState.value = ScrollState.shoppingCart;
      }
    }
  }

  _layawayDetail() async {
    var responseData = await layawayDetail({'id': _id});
    if (responseData.OData != null) {
      var laywayDetailModel = LaywayDetailModel.fromJson(responseData.OData);
      setState(() {
        _layawayModel = laywayDetailModel.layaway ?? LayawayInModel();
        _moreLayawayList = laywayDetailModel.moreLayawayList ?? [];
        _policyList = laywayDetailModel.policyList ?? [];
        _isLoading = false;
      });
      if (_layawayModel.primaryPicUrl != null) {
        List<String> banner = [];
        banner.add(_layawayModel.primaryPicUrl ?? '');
        var detail = _layawayModel.detail;

        var encode = detail!.toJson();
        for (String key in encode.keys) {
          if (key.startsWith('picUrl')) {
            banner.add(encode[key]);
          }
        }
        setState(() {
          _banner = banner;
        });
        _getDetailImg(detail);
      }
    }
  }

  void _getDetailImg(DetailModel detail) async {
    var html = detail.detailHtml ?? '';
    RegExp exp = new RegExp(r'[a-z|A-Z|0-9]{32}.jpg');
    List<String> imageUrls = [];
    Iterable<Match> mobiles = exp.allMatches(html);
    for (Match m in mobiles) {
      String? match = m.group(0);
      String imageUrl = 'https://yanxuan.nosdn.127.net/$match';
      if (!imageUrls.contains(imageUrl)) {
        print(imageUrl);
        imageUrls.add(imageUrl);
      }
    }
    setState(() {
      _detailImages = imageUrls;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      body: Stack(
        children: <Widget>[
          _isLoading ? Loading() : _buildContent(),
          Positioned(
            bottom: MediaQuery.of(context).padding.bottom,
            left: 0,
            right: 0,
            child: _buildFoot(),
          ),
        ],
      ),
      floatingActionButton: ValueListenableBuilder(
          valueListenable: _scrollState,
          builder: (BuildContext context, ScrollState value, Widget? child) {
            return _scrollState.value == ScrollState.toTop
                ? floatingAB(_scrollController)
                : floatingABCart(context);
          }),
    );
  }

  _buildFoot() {
    return Row(
      children: [
        _kefuWidget(),
        Expanded(child: NormalBtn('立即购买', backRed, () {}, textStyle: t16white)),
      ],
    );
  }

  _kefuWidget() {
    return GestureDetector(
      child: Container(
        color: backWhite,
        height: 45,
        width: 100,
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Image.asset(
          'assets/images/mine/kefu.png',
          width: 30,
          height: 30,
        ),
      ),
      onTap: () {
        Routers.push(Routers.webView, context, {'url': kefuUrl});
      },
    );
  }

  _buildContent() {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom + 45),
      child: CustomScrollView(
        controller: _scrollController,
        slivers: [
          _buildTitle(context),
          _buildDec(),
          if (_policyList.isNotEmpty) _buildService(),
          _buildContantner(),
          singleSliverWidget(_buildGoodDetail()),
          singleSliverWidget(_buildIssueTitle('常见问题')),
          singleSliverWidget(_buildIssueList()),
          singleSliverWidget(_rcmdTitle()),
          _rcmd(),
        ],
      ),
    );
  }

  _rcmdTitle() {
    return Container(
      alignment: Alignment.center,
      color: backWhite,
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Text(
        '更多年购套餐',
        style: t16black,
      ),
    );
  }

  _rcmd() {
    return SliverGrid.count(
      crossAxisCount: 2,
      childAspectRatio: 0.8,
      children: _moreLayawayList.map<Widget>((item) {
        Widget widget = GestureDetector(
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: backWhite,
                border: Border.all(color: textLightGrey, width: 0.5)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(top: 15),
                    child: NetImage(
                      imageUrl: '${item.primaryPicUrl}',
                      corner: 0,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  '${item.name}',
                  style: t16black,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      '¥${item.retailPrice}',
                      style: t16red,
                    ),
                    Text(
                      '共${item.phaseNum}期',
                      style: t16grey,
                    ),
                  ],
                )
              ],
            ),
          ),
          onTap: () {
            Routers.push(Routers.layawayDetail, context, {'id': item.id});
          },
        );
        return widget;
      }).toList(),
    );
  }

  _buildIssueList() {
    var issueList = _layawayModel.issueList ?? [];
    return Column(
        children: issueList
            .map((item) => Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(color: Colors.white),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Text(
                          '• ${item.question}',
                          style: t14black,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10, left: 6),
                        child: Text(
                          '${item.answer}',
                          style: t14lightGrey,
                        ),
                      ),
                    ],
                  ),
                ))
            .toList());
  }

  _buildIssueTitle(String title) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _titleLine(),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            child: Text(
              '$title',
              style: TextStyle(
                color: textBlack,
                fontSize: 16,
                height: 1,
              ),
            ),
          ),
          _titleLine(),
        ],
      ),
    );
  }

  _titleLine() {
    return Container(
      width: 20,
      color: textLightGrey,
      height: 1,
    );
  }

  _buildGoodDetail() {
    final List<Widget> imgWidget = [];
    final imgList = _detailImages.isEmpty
        ? List.filled(0, Container())
        : _detailImages
            .map<Widget>((e) => GestureDetector(
                  child: CachedNetworkImage(
                    imageUrl: '$e',
                    fit: BoxFit.cover,
                  ),
                  onTap: () {
                    // Routers.push(Util.image, context, {'images': _detailImages});
                  },
                ))
            .toList();
    imgWidget.addAll(imgList);
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      child: Column(
        children: imgWidget,
      ),
      color: Colors.white,
      width: double.infinity,
      alignment: Alignment.center,
    );
  }

  _buildContantner() {
    return singleSliverWidget(Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: backWhite,
                border: Border(bottom: BorderSide(color: lineColor, width: 1))),
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            child: Text(
              'V1、V2、V3、V4、V5、V6会员可购买，共${_layawayModel.phaseNum}期，每期包含',
              style: t14black,
            ),
          ),
          _buildItem(),
        ],
      ),
    ));
  }

  _buildItem() {
    var phaseSkuList = _layawayModel.phaseSkuList;
    if (phaseSkuList != null && phaseSkuList.isNotEmpty) {
      var item = phaseSkuList[0];
      var skuList = item.skuList;
      if (skuList != null && skuList.isNotEmpty) {
        var skuListItem = skuList[0];
        return Column(
          children: skuList.map((e) => _detailGoodItem(skuListItem)).toList(),
        );
      }
    }
    return Container();
  }

  Widget _detailGoodItem(LayawaySkuListItemModel skuListItem) {
    return GestureDetector(
      child: Container(
        color: backWhite,
        child: Row(
          children: [
            Expanded(
                child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Row(
                children: [
                  RoundNetImage(
                    url: '${skuListItem.picUrl}',
                    width: 76,
                    height: 76,
                    backColor: backColor,
                    corner: 4,
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${skuListItem.itemName}',
                          style: t14black,
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'X${skuListItem.count}',
                            style: t14black,
                          ),
                        ),
                        Text(
                          '${skuListItem.specification}',
                          style: t12grey,
                        ),
                        SizedBox(height: 3),
                        Text(
                          '¥${skuListItem.originalPrice}',
                          style: t14black,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )),
            SizedBox(width: 20),
            Image.asset(
              'assets/images/arrow_right.png',
              width: 16,
              height: 16,
            ),
            SizedBox(width: 10),
          ],
        ),
      ),
      onTap: () {
        Routers.push(Routers.goodDetail, context, {'id': skuListItem.itemId});
      },
    );
  }

  _buildService() {
    return singleSliverWidget(Container(
      color: backWhite,
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 14),
      child: Row(
        children: [
          Text(
            '服务：',
            style: t14black,
          ),
          Expanded(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _policyList
                    .map((item) => Container(
                          child: Row(
                            children: [
                              Container(
                                height: 4,
                                width: 4,
                                color: backRed,
                              ),
                              Expanded(
                                child: Text(
                                  '${item.title}',
                                  style: t14grey,
                                ),
                              )
                            ],
                          ),
                        ))
                    .toList()),
          ),
          arrowRightIcon
        ],
      ),
    ));
  }

  _buildDec() {
    return singleSliverWidget(Container(
      color: backWhite,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Column(
        children: [
          Text(
            '${_layawayModel.name}',
            style: t16black,
          ),
          Text(
            '${_layawayModel.title}',
            style: t14lightGrey,
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '¥${_layawayModel.retailPrice}',
                style: TextStyle(
                    fontSize: 25, color: textRed, fontWeight: FontWeight.w600),
              ),
              Text(
                '¥${_layawayModel.originalPrice}',
                style: TextStyle(
                    fontSize: 15,
                    color: textLightGrey,
                    decoration: TextDecoration.lineThrough),
              ),
            ],
          )
        ],
      ),
    ));
  }

  _buildTitle(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: SliverCustomHeaderDelegate(
        title: '${_layawayModel.name}',
        expandedHeight: MediaQuery.of(context).size.width,
        paddingTop: MediaQuery.of(context).padding.top,
        child: _buildSwiper(context),
      ),
    );
  }

  //轮播图
  _buildSwiper(BuildContext context) {
    return IndicatorBanner(
        dataList: _banner,
        fit: BoxFit.cover,
        height: MediaQuery.of(context).size.width,
        margin: EdgeInsets.all(0),
        corner: 0,
        indicatorType: IndicatorType.num,
        onPress: (index) {
          Routers.push(
              Routers.image, context, {'images': _banner, 'page': index});
        });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollState.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
