import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/http_manager/response_data.dart';
import 'package:flutter_app/utils/user_config.dart';
import 'package:flutter_app/utils/util_mine.dart';
import 'package:flutter_app/widget/MySeparator.dart';
import 'package:flutter_app/widget/loading.dart';
import 'package:flutter_app/widget/tab_app_bar.dart';

class CouponPage extends StatefulWidget {
  @override
  _CouponPageState createState() => _CouponPageState();
}

class _CouponPageState extends State<CouponPage> {
  int _page = 1;

  var _nowCoupon = List();
  var _hisCoupon = List();
  var _allDataList = List();

  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TabAppBar(
        title: '优惠券',
      ).build(context),
      body: _isLoading
          ? Loading()
          : CustomScrollView(
              slivers: [_buildList(context)],
            ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getResult();
  }

  _getResult() async {
    Future.wait([_getData(1), _getData(3)]).then((result) {
      setState(() {
        _nowCoupon = result[0].data['result'];
        _hisCoupon = result[1].data['result'];
        _allDataList.insertAll(_allDataList.length, _nowCoupon);
        _allDataList.insert(_allDataList.length, {'coupon_title_name': '已失效'});
        _allDataList.insertAll(_allDataList.length, _hisCoupon);

        _isLoading = false;
      });
    });
  }

  Future<ResponseData> _getData(int searchType) async {
    Map<String, dynamic> header = {
      "cookie": cookie,
    };
    Map<String, dynamic> params = {
      "csrf_token": csrf_token,
      "searchType": searchType,
      "page": _page,
    };

    return couponList(params);
  }

  _buildList(BuildContext context) {
    return SliverList(
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
      return _allDataList[index]['coupon_title_name'] == null
          ? _buildItem(context, _allDataList[index], index)
          : _buildTitle(context);
    }, childCount: _allDataList.length));
  }

  _buildItem(BuildContext context, var item, int index) {
    var backColor = index < _nowCoupon.length ? backRed : Color(0xFFA9ADB6);
    var tipsColor =
        index < _nowCoupon.length ? Color(0xFFBE5A57) : Color(0xFFA3A5AD);

    return Container(
      margin: EdgeInsets.all(15),
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
                color: backColor, borderRadius: BorderRadius.circular(4)),
            padding: EdgeInsets.fromLTRB(0, 30, 0, 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(color: backColor),
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      Text(
                        '${_cashName(item)}',
                        style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w500,
                            color: textWhite),
                      ),
                      Text(
                        '元',
                        style: TextStyle(color: textWhite),
                      ),
                      Expanded(
                          child: Container(
                        margin: EdgeInsets.only(left: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item['name'], style: t16white),
                            Text('${_valueDate(item)}', style: t14white),
                          ],
                        ),
                      ))
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  width: double.infinity,
                  height: 40,
                  child: MySeparator(),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  height: 60,
                  child: Text(
                    item['useCondition'],
                    style: t14white,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5),
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
            decoration: BoxDecoration(
                color: tipsColor, borderRadius: BorderRadius.circular(2)),
            child: Text(
              item['newUserOnly'] == 1 ? '新人专享' : '优惠券',
              style: TextStyle(color: textWhite),
            ),
          ),
        ],
      ),
    );
  }

  _buildTitle(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 20),
      child: Text(
        '已过期',
        style: t18black,
      ),
    );
  }

  _valueDate(item) {
    print(item['validEndTime']);
    print(item['validStartTime']);
    String end = '';
    String start = '';

    if (item['validEndTime'] == null) {
      end = '已过期';
    } else {
      end = '${Util.long2dateD(item['validEndTime'] * 1000)}';
    }

    if (item['validStartTime'] == null) {
      start = '';
    } else {
      start = '${Util.long2dateD(item['validStartTime'] * 1000)}';
    }

    return '$start-$end';
  }

  _cashName(item) {
    var cash = item['cash'] ~/ 1;

    return cash == 0 ? item['name'] : cash;
  }
}
