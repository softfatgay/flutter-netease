import 'package:flutter/material.dart';
import 'package:flutter_app/component/app_bar.dart';
import 'package:flutter_app/component/loading.dart';
import 'package:flutter_app/component/sliver_footer.dart';
import 'package:flutter_app/component/slivers.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/http_manager/net_contants.dart';
import 'package:flutter_app/http_manager/response_data.dart';
import 'package:flutter_app/model/pagination.dart';
import 'package:flutter_app/ui/mine/components/coupon_filed_widget.dart';
import 'package:flutter_app/ui/mine/model/couponItemModel.dart';
import 'package:flutter_app/ui/router/router.dart';
import 'package:flutter_app/utils/toast.dart';
import 'package:flutter_app/utils/util_mine.dart';

class CouponPage extends StatefulWidget {
  @override
  _CouponPageState createState() => _CouponPageState();
}

class _CouponPageState extends State<CouponPage> {
  int _page = 1;

  var _nowCoupon = [];

  bool _isLoading = true;
  Pagination _pagination;
  final controller = TextEditingController();

  List<CouponItemModel> _dataList = [];
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGrey,
      appBar: TopAppBar(title: '优惠券').build(context),
      body: _isLoading
          ? Loading()
          : CustomScrollView(
              controller: _scrollController,
              slivers: [
                singleSliverWidget(_addCoupon()),
                singleSliverWidget(_couponTips()),
                _buildList(context),
                SliverFooter(hasMore: !_pagination.lastPage)
              ],
            ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(() {
      // 如果下拉的当前位置到scroll的最下面
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (_pagination != null && !_pagination.lastPage) {
          _getMore();
        }
      }
    });
    _getResult();
  }

  _getResult() async {
    Future.wait([_getData(1), _getData(3)]).then((result) {
      List<CouponItemModel> dataList = [];

      ///可使用
      List data = result[0].data['result'];
      data.forEach((element) {
        var couponItemModel = CouponItemModel.fromJson(element);
        dataList.add(couponItemModel);
      });

      ///添加一个失效标记
      var couponItemModel = CouponItemModel()..title = '已失效';
      dataList.insert(dataList.length, couponItemModel);

      ///已过期
      List unData = result[1].data['result'];

      unData.forEach((element) {
        var couponItemModel = CouponItemModel.fromJson(element);
        dataList.add(couponItemModel);
      });

      setState(() {
        _nowCoupon = data;
        _dataList = dataList;
        _pagination = Pagination.fromJson(result[1].data['pagination']);
        _isLoading = false;
      });
    });
  }

  Future<ResponseData> _getData(int searchType) async {
    Map<String, dynamic> params = {
      "searchType": searchType,
      "page": _page,
    };
    return couponList(params);
  }

  _buildList(BuildContext context) {
    return SliverList(
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
      return _dataList[index].title == null
          ? _buildItem(context, _dataList[index], index)
          : _buildTitle(context);
    }, childCount: _dataList.length));
  }

  _buildItem(BuildContext context, CouponItemModel item, int index) {
    var backColor =
        index < _nowCoupon.length ? Color(0xFFDFB875) : Color(0xFFAFB4BC);
    var tipsColor =
        index < _nowCoupon.length ? Color(0xFFCEAC6C) : Color(0xFFA3A5AD);
    var botomColor =
        index < _nowCoupon.length ? Color(0XFFCEAC6C) : Color(0xFFA3A5AE);
    return Container(
      margin: EdgeInsets.only(top: 10, left: 10, right: 10),
      decoration: BoxDecoration(
          color: backColor, borderRadius: BorderRadius.circular(4)),
      padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(color: backColor),
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      '${item.briefDesc}',
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w700,
                          color: textWhite),
                    ),
                    Text(
                      '${item.unit}',
                      style: TextStyle(color: textWhite),
                    ),
                  ],
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.name, style: t14white),
                        Text('${_valueDate(item)}', style: t12white),
                      ],
                    ),
                  ),
                ),
                if (index < _nowCoupon.length)
                  GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          color: Color(0xFFF8F1E4)),
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                      child: Text(
                        '去使用',
                        style: t12Orange,
                      ),
                    ),
                    onTap: () {
                      Routers.push(Routers.webView, context,
                          {'url': '${NetContants.baseUrl}${item.path}'});
                    },
                  )
              ],
            ),
          ),
          GestureDetector(
            child: Container(
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              decoration: BoxDecoration(
                  color: botomColor,
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(4))),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      item.useCondition,
                      style: t12white,
                      maxLines: item.isSelected == null
                          ? 1
                          : (item.isSelected ? 15 : 1),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Icon(
                    _returnIcon(item),
                    color: Colors.white,
                    size: 16,
                  ),
                ],
              ),
            ),
            onTap: () {
              setState(() {
                if (item.isSelected == null) {
                  item.isSelected = true;
                } else {
                  item.isSelected = !item.isSelected;
                }
              });
            },
          ),
        ],
      ),
    );
  }

  _buildTitle(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 20),
      child: Container(
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.only(left: 15),
                height: 1,
                color: lineColor,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              color: backWhite,
              child: Text(
                '已失效',
                style: t12grey,
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.only(right: 15),
                height: 1,
                color: lineColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _valueDate(CouponItemModel item) {
    print(item.validEndTime);
    print(item.validStartTime);
    String end = '';
    String start = '';

    if (item.validEndTime == null) {
      end = '已过期';
    } else {
      end = '${Util.long2dateD(item.validEndTime * 1000)}';
    }

    if (item.validStartTime == null) {
      start = '';
    } else {
      start = '${Util.long2dateD(item.validStartTime * 1000)}';
    }

    return '$start-$end';
  }

  _cashName(CouponItemModel item) {
    var cash = item.cash ~/ 1;

    return cash == 0 ? item.name : cash;
  }

  _returnIcon(CouponItemModel item) {
    if (item.isSelected == null) {
      return Icons.keyboard_arrow_down_rounded;
    } else {
      if (item.isSelected) {
        return Icons.keyboard_arrow_up_rounded;
      } else {
        return Icons.keyboard_arrow_down_rounded;
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    super.dispose();
  }

  void _getMore() {
    Future.wait([_getData(3)]).then((result) {
      List<CouponItemModel> dataList = [];

      ///已过期
      List unData = result[0].data['result'];
      unData.forEach((element) {
        var couponItemModel = CouponItemModel.fromJson(element);
        dataList.add(couponItemModel);
      });
      setState(() {
        _dataList.insertAll(_dataList.length, dataList);
        _pagination = Pagination.fromJson(result[0].data['pagination']);
      });
    });
  }

  _addCoupon() {
    return Container(
      color: backWhite,
      child: NormalFiledClearWidget(
        controller: controller,
        hintText: '请输入激活码',
        onBtnClick: (value) {
          _couponActivate(value);
        },
      ),
    );
  }

  void _couponActivate(String value) async {
    Map<String, dynamic> params = {'activationCode': value};
    var responseData = await couponActivate(params);
    if (responseData.code == '200') {
      Toast.show(responseData.data['countInfo'], context);
    }
  }

  _couponTips() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: GestureDetector(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          // textBaseline: TextBaseline.alphabetic,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              alignment: Alignment.center,
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: textGrey, width: 1),
              ),
              child: Text(
                '?',
                style: t12grey,
              ),
            ),
            Text(
              '使用说明',
              style: t12grey,
            ),
          ],
        ),
        onTap: () {
          Routers.push(Routers.webView, context,
              {'url': '${NetContants.baseUrl}help/new#/24'});
        },
      ),
    );
  }
}
