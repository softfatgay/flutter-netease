import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/utils/constans.dart';
import 'package:flutter_app/utils/router.dart';
import 'package:flutter_app/widget/tab_app_bar.dart';

class ForServicesPage extends StatefulWidget {
  @override
  _ForServicesPageState createState() => _ForServicesPageState();
}

class _ForServicesPageState extends State<ForServicesPage> {
  List _tabs = [
    {
      'id': 0,
      'type': 2,
      'url': 'https://m.you.163.com/aftersale/packageList?type=2',
      'name': '申请退货',
      'icon': Icons.access_time_outlined,
      'color': textBlack
    },
    {
      'id': 1,
      'type': 2,
      'url': 'https://m.you.163.com/aftersale/packageList?type=',
      'name': '申请换货',
      'icon': Icons.loop,
      'color': textBlack
    },
    {
      'id': 2,
      'type': 5,
      'url': 'https://m.you.163.com/aftersale/packageList?type=5',
      'name': '仅退款',
      'icon': Icons.attach_money_sharp,
      'color': textBlack
    },
    {
      'id': 3,
      'type': 4,
      'url': 'https://m.you.163.com/aftersale/packageList?type=4',
      'name': '申请维修',
      'icon': Icons.build_sharp,
      'color': textBlack
    },
    {
      'id': 4,
      'type': 2,
      'url': 'https://m.you.163.com/aftersale/list',
      'name': '售后记录',
      'icon': Icons.description_outlined,
      'color': textBlack
    },
    {
      'id': 5,
      'type': 2,
      'url': 'https://m.you.163.com/priceProtect/list',
      'name': '价格保护',
      'icon': Icons.admin_panel_settings_rounded,
      'color': textBlack
    },
    {
      'id': 6,
      'type': 2,
      'url': 'https://m.you.163.com/invoice/list',
      'name': '发票服务',
      'icon': Icons.description,
      'color': textBlack
    },
    {
      'id': 7,
      'type': 2,
      'url': 'https://cs.you.163.com/client?k=$kefuKey',
      'name': '在线客服',
      'icon': Icons.call,
      'color': textBlack
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TabAppBar(
        controller: null,
        tabs: [],
        title: '售后服务',
      ).build(context),
      body: Column(
        children: _tabs.map((item) {
          return GestureDetector(
            child: Container(
              color: Colors.white,
              child: Container(
                decoration: BoxDecoration(
                    border: item['id'] == 7
                        ? null
                        : Border(
                            bottom: BorderSide(color: lineColor, width: 1))),
                margin: EdgeInsets.only(left: 15),
                padding: EdgeInsets.fromLTRB(0, 15, 15, 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(item['icon'], color: item['color']),
                        Container(
                          margin: EdgeInsets.only(left: 15),
                          child: Text(
                            '${item['name']}',
                            style: t16black,
                          ),
                        )
                      ],
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: textGrey,
                      size: 16,
                    )
                  ],
                ),
              ),
            ),
            onTap: () {
              Routers.push(
                  Routers.webViewPageAPP, context, {'url': item['url']});
            },
          );
        }).toList(),
      ),
    );
  }
}
