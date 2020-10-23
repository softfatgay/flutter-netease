import 'dart:io';
import 'dart:ui' as prefix0;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/utils/constans.dart';
import 'package:flutter_app/utils/flutter_activity.dart';
import 'package:flutter_app/utils/router.dart';
import 'package:flutter_app/utils/util_mine.dart';
import 'package:flutter_app/utils/widget_util.dart';
import 'package:flutter_app/widget/back_loading.dart';
import 'package:flutter_app/widget/colors.dart';
import 'package:flutter_app/widget/global.dart';
import 'package:flutter_app/widget/slivers.dart';

//import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

class UserPage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

// https://m.you.163.com/xhr/user/myFund.json?csrf_token=61f57b79a343933be0cb10aa37a51cc8

class _MinePageState extends State<UserPage> {
  List mineItems = [];
  var userInfo;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: <Widget>[
          _buildTop(context),
          _buildTitle(context),
          _buildMineItems(context),
          _buildMonthCard(context),
          _line(),
          _buildActivity(context),
          // _buildAdapter(context),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void _getUserInfo() async {
    String items =
        "https://m.you.163.com/xhr/user/myFund.json?csrf_token=${Constans
        .csrf_token}";
    String userInfoUrl =
        "https://m.you.163.com/xhr/user/checkConfig.json?csrf_token=${Constans
        .csrf_token}";

    String cookie =
        "nts_mail_user=wan_tuan@163.com:-1:1; _ntes_nnid=8a1ab224ed896a0b2b8d6cc94fdcf838,1601349351513; _ntes_nuid=8a1ab224ed896a0b2b8d6cc94fdcf838; mail_psc_fingerprint=591e75bc102317f0c9be6d98242b6313; yx_from=search_pz_baidu_29; yx_csrf=61f57b79a343933be0cb10aa37a51cc8; yx_username=wan_tuan%40163.com; yx_userid=28327067; yx_delete_cookie_flag=true; yx_aui=cd5bc446-7d36-41f2-803d-97315d112ab0; yx_s_tid=tid_web_cabe7cd3d8ed4dd4a7218b149a4a230a_75816cf7a_1; yx_new_user_modal_show=1; YX_SUPPORT_WEBP=1; yx_but_id=2939d92424e34e6cb743d2bc7650367eac87334995b12d3a_v1_nl; yx_page_key_list=; yx_from=search_pz_baidu_29; appid=1065178761;NTES_YD_SESS=0jopjzRqynveWuaFaodmcsgK0N3bY2Mc7JMSPezIaal4O1zGOBYERDpuNoy89eixAlQ5WJxH5MHiFd8nkDPCe5CInkDiOvXlV5X6CDTwLXt5CHFXDJ4aXzvOfnBdxEpSI0YGhNX.aRhZGj5DYi6ifEyo01ngUaK998Pzy8FOmR8DYetgi.75gV7ZX_aZityhPAO9RFzQmLVj5oNXAMBpNsoIpMWjLuKDDVQojQxjUnYik; S_INFO=1603356519|0|3&80##|17621577088;cookie:nts_mail_user=wan_tuan@163.com:-1:1; _ntes_nnid=8a1ab224ed896a0b2b8d6cc94fdcf838,1601349351513; _ntes_nuid=8a1ab224ed896a0b2b8d6cc94fdcf838; mail_psc_fingerprint=591e75bc102317f0c9be6d98242b6313; yx_from=search_pz_baidu_29; yx_csrf=61f57b79a343933be0cb10aa37a51cc8; yx_username=wan_tuan%40163.com; yx_userid=28327067; yx_delete_cookie_flag=true; yx_aui=cd5bc446-7d36-41f2-803d-97315d112ab0; yx_s_tid=tid_web_cabe7cd3d8ed4dd4a7218b149a4a230a_75816cf7a_1; yx_new_user_modal_show=1; YX_SUPPORT_WEBP=1; yx_but_id=2939d92424e34e6cb743d2bc7650367eac87334995b12d3a_v1_nl; yx_page_key_list=; yx_from=search_pz_baidu_29; source=xQY6a3cVRMjNta9PUTKH3ynyo2K/HgOfArQs9i3NfkPq3t73rmlMwi8sfNn3rgCTGXD0iz5Rbf1Itbjs4Y9ub4c5Jz+dClRzTSwDD+QePrbjr9ROCzaoimf8ts1x+dpTEnsxiO3ia2N9dZzdFkd6aOpNDhUdY5YaBqZsCetZvGrQlbrZIkSjiJh2LizLymxSTYi6nKKlhYJpjDxLdKU/LWygTLLsCtYHxdDhivtvs1M=; appid=1065178761;NTES_YD_SESS=0jopjzRqynveWuaFaodmcsgK0N3bY2Mc7JMSPezIaal4O1zGOBYERDpuNoy89eixAlQ5WJxH5MHiFd8nkDPCe5CInkDiOvXlV5X6CDTwLXt5CHFXDJ4aXzvOfnBdxEpSI0YGhNX.aRhZGj5DYi6ifEyo01ngUaK998Pzy8FOmR8DYetgi.75gV7ZX_aZityhPAO9RFzQmLVj5oNXAMBpNsoIpMWjLuKDDVQojQxjUnYik; S_INFO=1603356519|0|3&80##|17621577088; P_INFO=17621577088|1603356519|1|yanxuan_web|00&99|null&null&null#shh&null#10#0|&0|null|17621577088; yx_sid=18d1d216-65f1-41d3-a2bf-a2519ccc0f54; yx_username=wan_tuan%40163.com; yx_userid=28327067; yx_sid=ed3f5fe0-f281-4793-9fdb-66625a65beb6";
    Dio dio = new Dio();
    Map<String, dynamic> headers = new Map();
    headers['Cookie'] = cookie;
    Options options = new Options(headers: headers);
    Future<Response> response;
    response = await dio.get(items, options: options).then((value) {
      setState(() {
        mineItems = value.data["data"];
      });
    });

    Future<Response> response2;
    response = await dio.get(userInfoUrl, options: options).then((value) {
      setState(() {
        userInfo = value.data["data"];
      });
    });


    Map<String, dynamic> qup = {"csrf_token":Constans
        .csrf_token};
    Map<String, dynamic> header = {"Cookie":cookie};

    var userInfo1 = getUserInfo(qup,header: header);

    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");

    print(userInfo1);

  }

// yanxuan.nosdn.127.net/8945ae63d940cc42406c3f67019c5cb6.png
  _buildTop(BuildContext context) {
    return singleSliverWidget(Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(color: Color(0xFFF1BB6A)),
      height: 120,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              image: DecorationImage(
                image: NetworkImage(
                    "http://yanxuan.nosdn.127.net/8945ae63d940cc42406c3f67019c5cb6.png"),
                fit: BoxFit.cover,
              ),
            ), // 通过 container 实现圆角
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userInfo["userSimpleVO"]["nickname"],
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  userInfo["userSimpleVO"]["memberLevel"] == 0
                      ? "普通用户"
                      : "vip用户",
                  style: TextStyle(fontSize: 14, color: Colors.white),
                )
              ],
            ),
          )
        ],
      ),
    ));
  }

  _buildTitle(BuildContext context) {
    return singleSliverWidget(Container(
      margin: EdgeInsets.fromLTRB(15, 15, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "我的资产",
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 15),
            width: double.infinity,
            height: 1,
            color: lineColor,
          )
        ],
      ),
    ));
  }

  _buildMineItems(BuildContext context) {
    return SliverGrid.count(
      crossAxisCount: 5,
      children: mineItems
          .map((item) =>
          Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text(
                      item["fundType"] == 0 || item["fundType"] == 3
                          ? "¥${item["fundValue"]}"
                          : "${item["fundValue"]}",
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Text(item["fundName"]),
                  )
                ],
              ),
            ),
          ))
          .toList(),
    );
  }

  _buildMonthCard(BuildContext context) {
    var monthCardEntrance = userInfo["monthCardEntrance"];

    return singleSliverWidget(monthCardEntrance == null
        ? Container()
        : Container(
      margin: EdgeInsets.all(15),
      padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Color(0xFFF8E4DF)),
      child: Row(
        children: [
          Icon(
            Icons.credit_card,
            color: redColor,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            monthCardEntrance["title"],
            style: TextStyle(color: textRed, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            color: redColor,
            height: 15,
            width: 1,
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
              child: Text(
                monthCardEntrance["content"],
                style: TextStyle(
                  color: textRed,
                ),
              ))
        ],
      ),
    ));
  }

  _line() {
    return singleSliverWidget(Container(height: 10, color: backGrey,));
  }

  _buildAdapter(BuildContext context) {
    return GridView.count(crossAxisCount: 3);
  }

  _buildActivity(BuildContext context) {
    var welfareFissionInfo = userInfo["welfareFissionInfo"];
    return singleSliverWidget(
        welfareFissionInfo == null ? Container() :
        Container(child: CachedNetworkImage(
            imageUrl: userInfo["welfareFissionInfo"]["picUrl"]),));
  }
}
