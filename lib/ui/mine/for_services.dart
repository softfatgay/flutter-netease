import 'package:flutter/material.dart';
import 'package:flutter_app/widget/app_bar.dart';
import 'package:flutter_app/widget/colors.dart';
import 'package:flutter_app/widget/tab_app_bar.dart';

class ForServices extends StatefulWidget {
  @override
  _ForServicesState createState() => _ForServicesState();
}

class _ForServicesState extends State<ForServices> {
  List tabs = [
    {'id': 0, 'name': '申请退货'},
    {'id': 1, 'name': '申请换货'},
    {'id': 2, 'name': '仅退款'},
    {'id': 3, 'name': '申请维修'},
    {'id': 4, 'name': '售后记录'},
    {'id': 5, 'name': '价格保护'},
    {'id': 6, 'name': '发票服务'},
    {'id': 7, 'name': '在线客服'},
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
          return Container(
            color: Colors.white,
            child: Container(
              decoration: BoxDecoration(
                  border: item['id'] == 7
                      ? null
                      : Border(bottom: BorderSide(color: backGrey, width: 1))),
              margin: EdgeInsets.only(left: 15),
              padding: EdgeInsets.fromLTRB(0, 12, 15, 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.menu,color: redColor,),
                      Container(
                        margin: EdgeInsets.only(left: 6),
                        child: Text('${item['name']}',style: TextStyle(fontSize: 16,color: textBlack),),
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
          );
        }).toList(),
      ),
    );
  }
}
