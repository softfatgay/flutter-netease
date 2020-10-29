import 'dart:convert';

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
  final _phoneC = TextEditingController();
  final _addressC = TextEditingController();
  String addressTips = '省份 城市 区县';
  var tabTitle = List();

  List province = [];
  List city = [];
  List dis = [];
  List town = [];
  int selectType = 0;

  bool _check = false;

  var provinceItem;
  var cityItem;
  var disItem;
  var townItem;

  var currentList = List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _tabController = TabController(length: tabTitle.length, vsync: this);
    _getProvince();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: (){
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: backGrey,
        appBar: TabAppBar(
          title: '地址管理',
        ).build(context),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                child: Column(
                  children: [
                    Container(
                      color: Colors.white,
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
                      color: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: _phoneC,
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
                        color: Colors.white,
                        child: Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(left: 10),
                          padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                  bottom:
                                  BorderSide(width: 0.5, color: textGrey))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(addressTips),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 16,
                                color: textGrey,
                              )
                            ],
                          ),
                        ),
                      ),
                      onTap: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        _showAddress(context);
                      },
                    ),
                    Container(
                      color: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: TextField(
                        controller: _addressC,
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
                    Container(
                      child: Row(
                        children: [
                          Checkbox(
                            value: _check,
                            //选中时的颜色
                            activeColor: Colors.red,
                            onChanged: (value) {
                              setState(() {
                                _check = !_check;
                              });
                            },
                          ),
                          GestureDetector(
                            child: Text('设为默认'),
                            onTap: () {
                              setState(() {
                                _check = !_check;
                              });
                            },
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              child: Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          alignment: Alignment.center,
                          color: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 18),
                          child: Text(
                            '取消',
                            style: TextStyle(color: textGrey, fontSize: 16),
                          ),
                        ),
                      )),
                  Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: _addAddress,
                        child: Container(
                          alignment: Alignment.center,
                          color: redColor,
                          padding: EdgeInsets.symmetric(vertical: 18),
                          child: Text(
                            '保存',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      )),
                ],
              ),
            )
          ],
        ),
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
      _tabController.addListener(() {
        if (_tabController.index == _tabController.animation.value) {}
      });
    });

    return showModalBottomSheet(
      //设置true,不会造成底部溢出
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setStates) {
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
                              if (selectType == 1) {
                                setState(() {
                                  provinceItem = item;
                                });
                                print('!!!!!!!!!!!!!!!!!!!!!');
                                print(selectType);
                                _getCity(item['id'], setStates);
                              } else if (selectType == 2) {
                                setState(() {
                                  cityItem = item;
                                });
                                print('=======================');
                                print(selectType);
                                _getDis(
                                    item['id'], item['parentid'], setStates);
                              } else if (selectType == 3) {
                                setState(() {
                                  disItem = item;
                                });
                                print('>>>>>>>>>>>>>>>>>>>>>>>>>');
                                print(selectType);
                                _getTown(item['id'], setStates);
                              } else {
                                setState(() {
                                  townItem = item;
                                  addressTips =
                                      '${provinceItem['zonename'] + ' ' + cityItem['zonename'] + ' ' + disItem['zonename'] + ' ' + townItem['zonename']}';
                                  Navigator.pop(context);
                                });
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
      tabTitle.clear();
      tabTitle.add('省');
      tabTitle.add('市');
      _tabController =
          TabController(length: tabTitle.length, initialIndex: 1, vsync: this);
      _tabController.addListener(() {
        if (_tabController.index == _tabController.animation.value) {
          _tabclick(_tabController.index, setStates);
        }
      });

      print(responseData.data);
    });

    setState(() {
      city = responseData.data;
    });
  }

  void _getDis(int parentId, int grandParentId, setStates) async {
    Map<String, dynamic> params = {
      "csrf_token": csrf_token,
      "parentId": parentId,
      "grandParentId": grandParentId
    };

    var responseData = await getDisList(params);
    setStates(() {
      currentList = responseData.data;
      selectType = 3;
      tabTitle.clear();
      tabTitle.add('省');
      tabTitle.add('市');
      tabTitle.add('区县');
      _tabController =
          TabController(length: tabTitle.length, initialIndex: 2, vsync: this);
      _tabController.addListener(() {
        if (_tabController.index == _tabController.animation.value) {
          _tabclick(_tabController.index, setStates);
        }
      });

      print(responseData.data);
    });

    setState(() {
      dis = responseData.data;
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
      tabTitle.clear();
      tabTitle.add('省');
      tabTitle.add('市');
      tabTitle.add('区县');
      tabTitle.add('街道');
      _tabController =
          TabController(length: tabTitle.length, initialIndex: 3, vsync: this);
      _tabController.addListener(() {
        if (_tabController.index == _tabController.animation.value) {
          _tabclick(_tabController.index, setStates);
        }
      });
    });

    setState(() {
      town = responseData.data;
    });
  }

  _tabclick(int index, setStates) {
    print('//////////////////////////////');
    print(city);

    print(index);
    if (index == 0) {
      setStates(() {
        currentList = province;
        selectType = 1;
      });
    } else if (index == 1) {
      setStates(() {
        currentList = city;
        selectType = 2;
      });
    } else if (index == 2) {
      setStates(() {
        currentList = dis;
        selectType = 3;
      });
    } else if (index == 3) {
      setStates(() {
        currentList = town;
        selectType = 4;
      });
    }

    print(city);
  }

  _addAddress() async {
    Map<String, dynamic> header = {
      "Cookie": cookie,
      "csrf_token": csrf_token,
    };
    Map<String, dynamic> params = {
      "csrf_token": csrf_token,
      'id': 0,
      'provinceId': provinceItem['id'],
      'provinceName': provinceItem['zonename'],
      'cityId': cityItem['id'],
      'cityName': cityItem['zonename'],
      'districtId': disItem['id'],
      'districtName': disItem['zonename'],
      'townId': townItem['id'],
      'townName': townItem['zonename'],
      'address': _addressC.text,
      'name': _nameController.text,
      'mobile': _phoneC.text,
      'dft': _check,
    };

    await addAddress(params, header: header).then((responseData) {
      if (responseData.code == '200') {
        Navigator.pop(context);
      }
    });
  }
}
