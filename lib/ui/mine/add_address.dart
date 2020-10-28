import 'package:flutter/material.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/utils/user_config.dart';
import 'package:flutter_app/widget/MyUnderlineTabIndicator.dart';
import 'package:flutter_app/widget/colors.dart';
import 'package:flutter_app/widget/tab_app_bar.dart';

class AddAddress extends StatefulWidget {
  final Map arguments;

  const AddAddress({Key key, this.arguments}) : super(key: key);

  @override
  _AddAddressState createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> with TickerProviderStateMixin {
  TabController _tabController;
  final _nameController = TextEditingController();
  String addressTips = '省份 城市 区县';
  var tabTitle = List();

  List province = [];
  List city = [];
  List dis = [];
  List town = [];
  int selectType = 0;

  var currentList = List();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TabAppBar(
        title: '地址管理',
      ).build(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              controller: _nameController,
              maxLines: 1,
              cursorColor: redColor,
              decoration: InputDecoration(
                fillColor: Colors.white,
                border: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: redColor,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(2)),
                hintText: '姓名',
                filled: true,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              keyboardType: TextInputType.number,
              controller: _nameController,
              maxLines: 1,
              cursorColor: redColor,
              decoration: InputDecoration(
                fillColor: Colors.white,
                border: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: redColor,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(2)),
                hintText: '手机号',
                filled: true,
              ),
            ),
          ),
          GestureDetector(
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 10),
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border:
                      Border(bottom: BorderSide(width: 1, color: backGrey))),
              child: Text(addressTips),
            ),
            onTap: () {
              _showAddress(context);
            },
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              keyboardType: TextInputType.number,
              controller: _nameController,
              maxLines: 1,
              cursorColor: redColor,
              decoration: InputDecoration(
                fillColor: Colors.white,
                border: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: redColor,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(2)),
                hintText: '详细地址 街道 楼盘号等',
                filled: true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  ///属性选择底部弹窗
  _showAddress(BuildContext context) {
    setState(() {
      selectType = 1;
      currentList = province;
      tabTitle.clear();
      tabTitle.add('省');
      _tabController = TabController(length: tabTitle.length, vsync: this);
    });

    return showModalBottomSheet(
      //设置true,不会造成底部溢出
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return Container(
            child: SingleChildScrollView(
              child: Container(
                height: 350,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TabBar(
                      controller: _tabController,
                      tabs: tabTitle.map((f) => Tab(text: f)).toList(),
                      indicator: MyUnderlineTabIndicator(
                        borderSide: BorderSide(width: 2.0, color: redColor),
                      ),
                      indicatorColor: Colors.red,
                      unselectedLabelColor: Colors.black,
                      labelColor: Colors.red,
                      isScrollable: true,
                    ),
                    Expanded(
                        child: Container(
                      child: ListView(
                        children: currentList.map((item) {
                          return GestureDetector(
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      top: BorderSide(
                                          color: backGrey, width: 1))),
                              margin: EdgeInsets.only(left: 15),
                              padding: EdgeInsets.fromLTRB(0, 15, 15, 15),
                              child: Text(item["zonename"]),
                            ),
                            onTap: () {
                              setState(() {});
                              if (selectType == 1) {
                                print('!!!!!!!!!!!!!!!!!!!!!');
                                print(selectType);
                                _getCity(item['id'], setState);
                              } else if (selectType == 2) {
                                print('=======================');
                                print(selectType);
                                _getDis(item['id'],item['parentid'] ,setState);
                              } else if (selectType == 3) {
                                print('>>>>>>>>>>>>>>>>>>>>>>>>>');
                                print(selectType);
                                _getTown(item['id'], setState);
                              }
                            },
                          );
                        }).toList(),
                      ),
                    ))
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: tabTitle.length, vsync: this);

    _getProvince();
  }

  void _getProvince() async {

    Map<String, dynamic> params = {
      "csrf_token": csrf_token,
      "withOverseasCountry": true
    };

    var responseData = await getProvenceList(params);
    setState(() {
      province = responseData.data;
      currentList = responseData.data;
      print(responseData.data);
    });
  }

  void _getCity(int parentId, setStates) async {

    Map<String, dynamic> params = {
      "csrf_token": csrf_token,
      "parentId": parentId
    };

    var responseData = await getCityList(params);
    setStates(() {
      currentList = responseData.data;
      selectType = 2;
      tabTitle.add('市');
      _tabController = TabController(length: tabTitle.length,initialIndex: 1,  vsync: this);

      print(responseData.data);
    });

    setState(() {
      city = responseData.data;
    });
  }

  void _getDis(int parentId ,int grandParentId, setStates) async {

    Map<String, dynamic> params = {
      "csrf_token": csrf_token,
      "parentId": parentId,
      "grandParentId": grandParentId
    };

    var responseData = await getDisList(params);
    setStates(() {
      currentList = responseData.data;
      selectType = 3;
      tabTitle.add('区县');
      _tabController = TabController(length: tabTitle.length,initialIndex: 2, vsync: this);
      print(responseData.data);
    });

    setState(() {
      city = responseData.data;
    });

  }

  void _getTown(int parentId, setStates) async {
    // csrf_token=61f57b79a343933be0cb10aa37a51cc8&withOverseasCountry=true

    Map<String, dynamic> params = {
      "csrf_token": csrf_token,
      "parentId": parentId
    };

    var responseData = await getTown(params);
    setStates(() {
      currentList = responseData.data;
      selectType = 4;
      tabTitle.add('街道');
      _tabController = TabController(length: tabTitle.length, initialIndex: 3, vsync: this);
      print(responseData.data);
    });

    setState(() {
      city = responseData.data;
    });
  }
}
