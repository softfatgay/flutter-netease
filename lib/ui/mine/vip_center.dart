import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/utils/router.dart';
import 'package:flutter_app/utils/user_config.dart';
import 'package:flutter_app/utils/util_mine.dart';
import 'package:flutter_app/widget/back_loading.dart';
import 'package:flutter_app/widget/head_portrait.dart';
import 'package:flutter_app/widget/slivers.dart';
import 'package:flutter_app/widget/tab_app_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VipCenter extends StatefulWidget {
  var data;

  @override
  _VipCenterState createState() => _VipCenterState();
}

class _VipCenterState extends State<VipCenter> {
  bool _isLoading = true;
  var data;
  var name = '';
  var pointsCnt = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    getUserInfo();
  }

  void getUserInfo() async {
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name');
      pointsCnt = prefs.getString('pointsCnt');
    });
  }

  void getData() async {
    Map<String, dynamic> params = {};
    Map<String, dynamic> header = {"Cookie": cookie};

    var responseData = await vipCenter(params, header: header);
    setState(() {
      _isLoading = false;
      data = responseData.data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TabAppBar(
        title: '会员俱乐部',
      ).build(context),
      body: _isLoading ? Loading() : _buildBody(),
    );
  }

  _buildBody() {
    return CustomScrollView(
      slivers: [
        singleSliverWidget(_buildTop()),
        singleSliverWidget(_title('会员专享特权')),
        _buildPrivilegeList(),
        singleSliverWidget(_line(10.0)),
        singleSliverWidget(_title('任务中心')),
        singleSliverWidget(_completeOwnerInfo())
      ],
    );
  }

  _buildTop() {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(color: backYellow),
      height: 180,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              HeadPortrait(
                url:
                    'https://yanxuan.nosdn.127.net/8945ae63d940cc42406c3f67019c5cb6.png',
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                name,
                style: TextStyle(fontSize: 18, color: Colors.white),
              )
            ],
          ),
          Text(
            '普通会员',
            style: t24white,
          ),
          SizedBox(
            height: 18,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      color: Color(0xFFEFDCB3),
                      borderRadius: BorderRadius.circular(18)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.menu,
                        color: textYellow,
                      ),
                      Text(
                        '我的积分:$pointsCnt',
                        style: TextStyle(color: textYellow, fontSize: 14),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      color: Color(0xFFEFDCB3),
                      borderRadius: BorderRadius.circular(18)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.trending_up,
                        color: textYellow,
                      ),
                      Text(
                        '当前成长值:$pointsCnt',
                        style: TextStyle(color: textYellow, fontSize: 14),
                      )
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  _title(String title) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Row(
          children: [
            Expanded(
                child: Text(
              title,
              style: t16blackbold,
            )),
            Row(
              children: [
                Text(
                  '查看全部',
                  style: t12grey,
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: textGrey,
                )
              ],
            )
          ],
        ));
  }

  _buildPrivilegeList() {
    List privilegeList = data['privilegeList'];
    return //横向滑动区域
        SliverToBoxAdapter(
      child: Container(
        height: 100,
        margin: EdgeInsets.only(top: 10),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: privilegeList.length,
          itemBuilder: (context, index) {
            Widget widget = Container(
              height: 100,
              width: 100.0,
              child: Column(
                children: [
                  Icon(
                    Icons.auto_awesome_mosaic,
                    size: 50,
                    color: textLightYellow,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text('${privilegeList[index]['frontName']}')
                ],
              ),
            );
            return Routers.link(widget, Util.webView, context, {
              "id":
                  'https://m.you.163.com/membership/privilege?type=${privilegeList[index]['type']}'
            });
          },
        ),
      ),
    );
  }

  Widget _line(double height) {
    return Container(
      height: height,
      color: lineColor,
    );
  }

  _completeOwnerInfo() {
    List memGrowthTasks = data['memGrowthTasks'];
    List taskData = memGrowthTasks.map((item) {
      if (item['type'] == 6) {
        return {'title': '完善个人信息', 'dec': 'v1及以上会员专享，仅限一次'};
      } else if (item['type'] == 7) {
        return {'title': '绑定手机号', 'dec': 'v1及以上会员专享，仅限一次'};
      } else if (item['type'] == 8) {
        return {'title': '设置支付密码', 'dec': 'v1及以上会员专享，仅限一次'};
      }
    }).toList();
    return Column(
      children: taskData.map((item) {
        Widget widget = Container(
        padding: EdgeInsets.symmetric(vertical: 15),
        margin: EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: lineColor,width: 1))
          ),
          child: Row(
            children: [
            Expanded(child: Container(
              child:   Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${item['title']}',
                    style: t16black,
                  ),
                  Text(
                    '${item['dec']}',
                    style: t14grey,
                  ),
                ],
              ),
            )),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                decoration: BoxDecoration(color: backYellow),
                child: Text('去完善',style: t14white,),
              )
            ],
          ),
        );
        return widget;
      }).toList(),
    );
  }
}
