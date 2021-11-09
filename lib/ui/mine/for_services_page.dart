import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/http_manager/net_contants.dart';
import 'package:flutter_app/utils/constans.dart';
import 'package:flutter_app/ui/router/router.dart';
import 'package:flutter_app/component/app_bar.dart';
import 'package:flutter_app/component/global.dart';

class ForServicesPage extends StatefulWidget {
  @override
  _ForServicesPageState createState() => _ForServicesPageState();
}

class _ForServicesPageState extends State<ForServicesPage> {
  List _tabs = [
    {
      'id': 0,
      'type': 2,
      'url': '${NetConstants.baseUrl}aftersale/packageList?type=2',
      'name': '申请退货',
      'icon': 'assets/images/service/tuihuo.png',
      'color': textBlack
    },
    {
      'id': 1,
      'type': 2,
      'url': '${NetConstants.baseUrl}aftersale/packageList?type=',
      'name': '申请换货',
      'icon': 'assets/images/service/huanhuo.png',
      'color': textBlack
    },
    {
      'id': 2,
      'type': 5,
      'url': '${NetConstants.baseUrl}aftersale/packageList?type=5',
      'name': '仅退款',
      'icon': 'assets/images/service/tuikuan.png',
      'color': textBlack
    },
    {
      'id': 3,
      'type': 4,
      'url': '${NetConstants.baseUrl}aftersale/packageList?type=4',
      'name': '申请维修',
      'icon': 'assets/images/service/weixiu.png',
      'color': textBlack
    },
    {
      'id': 4,
      'type': 2,
      'url': '${NetConstants.baseUrl}aftersale/list',
      'name': '售后记录',
      'icon': 'assets/images/service/shouhoujilu.png',
      'color': textBlack
    },
    {
      'id': 5,
      'type': 2,
      'url': '${NetConstants.baseUrl}priceProtect/list',
      'name': '价格保护',
      'icon': 'assets/images/service/jiagebaohu.png',
      'color': textBlack
    },
    {
      'id': 6,
      'type': 2,
      'url': '${NetConstants.baseUrl}invoice/list',
      'name': '发票服务',
      'icon': 'assets/images/service/fapiaofuwu.png',
      'color': textBlack
    },
    {
      'id': 7,
      'type': 2,
      'url': kefuUrl,
      'name': '在线客服',
      'icon': 'assets/images/service/zaixiankefu.png',
      'color': textBlack
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopAppBar(
        title: '售后服务',
      ).build(context),
      body: Container(
        margin: EdgeInsets.only(top: 10),
        child: Column(
          children: _tabs.map((item) {
            return GestureDetector(
              child: Container(
                color: Colors.white,
                child: Container(
                  decoration: BoxDecoration(
                    border: item['id'] == 7
                        ? null
                        : Border(
                            bottom: BorderSide(color: lineColor, width: 0.5),
                          ),
                  ),
                  margin: EdgeInsets.only(left: 15),
                  padding: EdgeInsets.fromLTRB(0, 15, 15, 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            '${item['icon']}',
                            width: 20,
                            height: 20,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 15),
                            child: Text(
                              '${item['name']}',
                              style: t14black,
                            ),
                          ),
                        ],
                      ),
                      arrowRightIcon
                    ],
                  ),
                ),
              ),
              onTap: () {
                Routers.push(Routers.webView, context, {'url': item['url']});
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
