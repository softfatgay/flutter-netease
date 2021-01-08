import 'package:flutter/material.dart';
import 'package:flutter_app/http_manager/net_contants.dart';
import 'package:flutter_app/utils/constans.dart';
import 'package:flutter_app/utils/router.dart';
import 'package:flutter_app/utils/util_mine.dart';
import 'package:flutter_app/widget/app_bar.dart';
import 'package:flutter_app/widget/colors.dart';
import 'package:flutter_app/widget/tab_app_bar.dart';

class ForServices extends StatefulWidget {
  @override
  _ForServicesState createState() => _ForServicesState();
}

class _ForServicesState extends State<ForServices> {

  List tabs = [
    {'id': 0,'type':2,'url':'https://m.you.163.com/aftersale/packageList?type=2', 'name': '申请退货','icon':Icons.access_time_outlined,'color':redLightColor},
    {'id': 1,'type':2,'url':'https://m.you.163.com/aftersale/packageList?type=', 'name': '申请换货','icon':Icons.loop,'color':redLightColor},
    {'id': 2,'type':5,'url':'https://m.you.163.com/aftersale/packageList?type=5', 'name': '仅退款','icon':Icons.attach_money_sharp,'color':redLightColor},
    {'id': 3,'type':4,'url':'https://m.you.163.com/aftersale/packageList?type=4', 'name': '申请维修','icon':Icons.build_sharp,'color':lightBlue},
    {'id': 4,'type':2,'url':'https://m.you.163.com/aftersale/list', 'name': '售后记录','icon':Icons.description_outlined,'color':lightBlue},
    {'id': 5,'type':2,'url':'https://m.you.163.com/priceProtect/list', 'name': '价格保护','icon':Icons.admin_panel_settings_rounded,'color':lightBlue},
    {'id': 6,'type':2,'url':'https://m.you.163.com/invoice/list', 'name': '发票服务','icon':Icons.description,'color':lightBlue},
    {'id': 7,'type':2,'url':'https://cs.you.163.com/client?k=$kefuKey', 'name': '在线客服','icon':Icons.call,'color':lightBlue},
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
        children: tabs.map((item) {
          return GestureDetector(
            child: Container(
              color: Colors.white,
              child: Container(
                decoration: BoxDecoration(
                    border: item['id'] == 7
                        ? null
                        : Border(bottom: BorderSide(color: lineColor, width: 1))),
                margin: EdgeInsets.only(left: 15),
                padding: EdgeInsets.fromLTRB(0, 15, 15, 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(item['icon'],color: item['color']),
                        Container(
                          margin: EdgeInsets.only(left: 15),
                          child: Text('${item['name']}',style: t16black,),
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
            onTap: (){
              Routers.push(Util.webViewPageAPP, context,{'id':item['url']});
            },
          );
        }).toList(),
      ),
    );
  }
}
