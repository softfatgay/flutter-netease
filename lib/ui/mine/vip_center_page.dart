import 'package:flutter/material.dart';
import 'package:flutter_app/component/app_bar.dart';
import 'package:flutter_app/component/back_loading.dart';
import 'package:flutter_app/component/round_net_image.dart';
import 'package:flutter_app/component/slivers.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/http_manager/net_contants.dart';
import 'package:flutter_app/ui/mine/components/head_portrait.dart';
import 'package:flutter_app/ui/mine/model/vipCenterIndexModel.dart';
import 'package:flutter_app/ui/mine/model/vipCenterModel.dart';
import 'package:flutter_app/ui/router/router.dart';
import 'package:flutter_app/utils/local_storage.dart';

@Deprecated('no used')
class VipCenterPage extends StatefulWidget {
  @override
  _VipCenterPageState createState() => _VipCenterPageState();
}

class _VipCenterPageState extends State<VipCenterPage> {
  bool _isLoading = true;
  VipCenterModel? _data;
  String? _name = '';
  String? _pointsCnt = '';

  num _level = 0;

  var _centerIndexModel = VipCenterIndexModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    getDataIndex();
    getUserInfo();
  }

  void getUserInfo() async {
    var sp = await LocalStorage.sp;
    setState(() {
      _name = sp!.getString(LocalStorage.userName);
      _pointsCnt = sp.getString(LocalStorage.pointsCnt);
    });
  }

  void getData() async {
    var responseData = await vipCenter();
    if (responseData.code == '200') {
      setState(() {
        _isLoading = false;
        _data = VipCenterModel.fromJson(responseData.data);
      });
    }
  }

  void getDataIndex() async {
    var responseData = await vipCenterIndex();
    if (responseData.OData != null) {
      setState(() {
        _centerIndexModel = VipCenterIndexModel.fromJson(responseData.OData);
        _level = _centerIndexModel.upgradeInfo!.level ?? 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backWhite,
      appBar: TopAppBar(
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
        // singleSliverWidget(_completeOwnerInfo())
        singleSliverWidget(_line(10.0)),
        singleSliverWidget(_monthGiftList()),
        singleSliverWidget(_line(10.0)),
        singleSliverWidget(_layerwayList()),

        ///更多优惠
        singleSliverWidget(_moreDiscount()),
      ],
    );
  }

  _moreDiscount() {
    return Container(
      child: Column(
        children: [
          Text(
            '更多优惠',
            style: t16black,
          )
        ],
      ),
    );
  }

  _layerwayList() {
    var memLayawayVO = _centerIndexModel.memLayawayVO;
    if (memLayawayVO == null) {
      return Container();
    }
    var layawayList = memLayawayVO.layawayList ?? [];
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: 10),
          child: Text(
            '会员年购服务',
            style: t16black,
          ),
        ),
        Text(
          '更实惠的套餐价，享受一整年的定期配送服务',
          style: TextStyle(color: Color(0xFF7F7F7F), fontSize: 12),
        ),
        SizedBox(height: 10),
        Container(height: 1, color: lineColor),
        Column(
          children: layawayList.map((item) {
            return Container(
              height: 150,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                  border:
                      Border(bottom: BorderSide(color: lineColor, width: 1))),
              child: Row(
                children: [
                  RoundNetImage(
                    url: '${item.primaryPicUrl}',
                    width: 130,
                    height: 130,
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          '${item.name}',
                          style: t14black,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 3),
                        Text(
                          '${item.title}',
                          style: t12grey,
                        ),
                        SizedBox(height: 15),
                        Text(
                          '¥${item.retailPrice}/${item.phaseNum}期',
                          style: t14Orange,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
        GestureDetector(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              '查看更多>',
              style: t14black,
            ),
          ),
          onTap: () {},
        )
      ],
    );
  }

  _monthGiftList() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: 10),
          child: Text(
            '每月礼券',
            style: t16black,
          ),
        ),
        Text(
          '每月3日更新，每张券可领1次',
          style: TextStyle(color: Color(0xFF7F7F7F), fontSize: 12),
        ),
        if (_data != null)
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _data!.monthGiftCouponList!.map((item) {
                return Container(
                  margin: EdgeInsets.only(left: 15, top: 15),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            'assets/images/vip_center_monthitem_back.png')),
                  ),
                  child: Column(
                    children: [
                      Text(
                        '${item.name}',
                        style:
                            TextStyle(color: Color(0xFFCCCCCC), fontSize: 20),
                      ),
                      Text(
                        '${item.rangeName}',
                        style:
                            TextStyle(color: Color(0xFFCCCCCC), fontSize: 14),
                      ),
                      Text(
                        '领取后${item.validTime}天有效',
                        style:
                            TextStyle(color: Color(0xFFCCCCCC), fontSize: 12),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        padding: EdgeInsets.fromLTRB(5, 2, 5, 3),
                        decoration: BoxDecoration(
                            color: Color(0xFFCCCCCC),
                            borderRadius: BorderRadius.circular(4)),
                        child: Text(
                          '升级$_level可领',
                          style: t12white,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        SizedBox(height: 10),
      ],
    );
  }

  _buildTop() {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/vip_center_back.png'),
              fit: BoxFit.cover)),
      height: 180,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              HeadPortrait(
                url: '${_centerIndexModel.avatarUrl}',
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                '${_centerIndexModel.nickname}',
                style: TextStyle(fontSize: 18, color: Colors.white),
              )
            ],
          ),
          if (_centerIndexModel.memRankMetaVO != null)
            Text(
              '${_centerIndexModel.memRankMetaVO!.levelName}',
              style: TextStyle(
                  fontSize: 36, color: textWhite, fontWeight: FontWeight.w400),
            ),
          SizedBox(
            height: 18,
          ),
          if (_centerIndexModel.memRankMetaVO != null)
            Row(
              children: _centerIndexModel.memRankMetaVO!.monthScoreList!
                  .map<Widget>((item) {
                return _topItem(
                    _centerIndexModel.memRankMetaVO!.monthScoreList!, item);
              }).toList(),
            ),
        ],
      ),
    );
  }

  _topItem(List<MonthScoreListItem> monthScoreList, MonthScoreListItem item) {
    var indexOf = monthScoreList.indexOf(item);
    return Expanded(
      flex: 1,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            color: Color(0xFFEFDCB3), borderRadius: BorderRadius.circular(18)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              indexOf == 0 ? Icons.menu : Icons.trending_up,
              color: textYellow,
            ),
            Text(
              indexOf == 0 ? '我的积分:${item.score}' : '当前成长值:${item.score}',
              style: TextStyle(color: textYellow, fontSize: 14),
            )
          ],
        ),
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
    if (_data == null) {
      return Container();
    }
    List privilegeList = _data!.privilegeList ?? [];
    return //横向滑动区域
        SliverToBoxAdapter(
      child: Container(
        height: 100,
        margin: EdgeInsets.only(top: 10),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: privilegeList.length,
          itemBuilder: (context, index) {
            var item = privilegeList[index];
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
                  Text('${item.frontName}')
                ],
              ),
            );
            return Routers.link(widget, Routers.webView, context, {
              "id":
                  '${NetConstants.baseUrl}membership/privilege?type=${item.type}'
            });
          },
        ),
      ),
    );
  }

  _line(double height) {
    return Container(
      height: height,
      color: backColor,
    );
  }

  _completeOwnerInfo() {
    var memGrowthTasks = _data!.memGrowthTasks ?? [];

    List taskData = memGrowthTasks.map((item) {
      if (item.type == 6) {
        return {'title': '完善个人信息', 'dec': 'v1及以上会员专享，仅限一次'};
      } else if (item.type == 7) {
        return {'title': '绑定手机号', 'dec': 'v1及以上会员专享，仅限一次'};
      } else if (item.type == 8) {
        return {'title': '设置支付密码', 'dec': 'v1及以上会员专享，仅限一次'};
      }
    }).toList();
    return Column(
      children: taskData.map((item) {
        Widget widget = Container(
          padding: EdgeInsets.symmetric(vertical: 15),
          margin: EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: lineColor, width: 1))),
          child: Row(
            children: [
              Expanded(
                  child: Container(
                child: Column(
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
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                decoration: BoxDecoration(color: backYellow),
                child: Text(
                  '去完善',
                  style: t14white,
                ),
              )
            ],
          ),
        );
        return widget;
      }).toList(),
    );
  }
}
