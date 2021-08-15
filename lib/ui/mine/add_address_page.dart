import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/ui/mine/model/addressItem.dart';
import 'package:flutter_app/ui/mine/model/locationItemModel.dart';
import 'package:flutter_app/component/app_bar.dart';
import 'package:flutter_app/component/global.dart';
import 'package:flutter_app/component/m_textfiled.dart';
import 'package:flutter_app/component/my_under_line_tabindicator.dart';

class AddAddressPage extends StatefulWidget {
  final Map params;

  const AddAddressPage({Key key, this.params}) : super(key: key);

  @override
  _AddAddressPageState createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage>
    with TickerProviderStateMixin {
  TabController _tabController;
  final _nameController = TextEditingController();
  final _phoneC = TextEditingController();
  final _addressC = TextEditingController();
  String _addressTips = '省份 城市 区县';
  var _tabTitle = [];

  List<AddressItem> _province = [];
  List<AddressItem> _city = [];
  List<AddressItem> _dis = [];
  List<AddressItem> _town = [];
  int _selectType = 0;

  bool _check = false;

  var _provinceItem = AddressItem();
  var _cityItem = AddressItem();
  var _disItem = AddressItem();
  var _townItem = AddressItem();

  List<AddressItem> _currentList = [];

  LocationItemModel _addressItem;

  num _id = 0;
  String _title = '新增地址';

  @override
  void initState() {
    // TODO: implement initState
    if (widget.params != null) {
      setState(() {
        var argument = widget.params['address'];
        print(']]]]]]]]]');
        if (argument != null) {
          _title = '修改地址';
          _addressItem = argument;
          _nameController.text = _addressItem.name;
          _phoneC.text = _addressItem.mobile;
          _provinceItem.id = _addressItem.provinceId;
          _provinceItem.zonename = _addressItem.provinceName;
          _cityItem.id = _addressItem.cityId;
          _cityItem.zonename = _addressItem.cityName;
          _disItem.id = _addressItem.districtId;
          _disItem.zonename = _addressItem.districtName;
          _townItem.id = _addressItem.townId;
          _townItem.zonename = _addressItem.townName;
          _addressC.text = _addressItem.address;
          _check = _addressItem.dft;
          _id = _addressItem.id;
          _addressTips =
              '${_provinceItem.zonename + ' ' + _cityItem.zonename + ' ' + _disItem.zonename + ' ' + _townItem.zonename}';
        }
      });
    }
    super.initState();

    _tabController = TabController(length: _tabTitle.length, vsync: this);
    _getProvince();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: backColor,
        appBar: TopAppBar(
          title: _title,
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: MTextFiled(
                        keyboardType: TextInputType.text,
                        controller: _nameController,
                        hintText: '姓名',
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: MTextFiled(
                        keyboardType: TextInputType.number,
                        controller: _phoneC,
                        maxLength: 11,
                        hintText: '手机号',
                      ),
                    ),
                    GestureDetector(
                      child: Container(
                        color: Colors.white,
                        child: Container(
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          padding: EdgeInsets.symmetric(
                            vertical: 15,
                          ),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                  bottom: BorderSide(
                                      width: 0.5, color: lineColor))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _addressTips,
                                style: TextStyle(
                                    color: _addressTips == '省份 城市 区县'
                                        ? textHint
                                        : textBlack,
                                    fontSize: 16),
                              ),
                              arrowRightIcon
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: MTextFiled(
                        keyboardType: TextInputType.text,
                        controller: _addressC,
                        hintText: '详细地址 街道 楼盘号等',
                      ),
                    ),
                    GestureDetector(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(color: Color(0xFFFEFEFE)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                            Text(
                              '设为默认',
                              style: t16black,
                            )
                          ],
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          _check = !_check;
                        });
                      },
                    ),
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
      _selectType = 1;
      _currentList = _province;
      _tabTitle.clear();
      _tabTitle.add('省');
      _tabController = TabController(length: _tabTitle.length, vsync: this);
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
                      tabs: _tabTitle.map((f) => Tab(text: f)).toList(),
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
                        children: _currentList.map((item) {
                          return GestureDetector(
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      top: BorderSide(
                                          color: backGrey, width: 1))),
                              margin: EdgeInsets.only(left: 15),
                              padding: EdgeInsets.fromLTRB(0, 15, 15, 15),
                              child: Text(item.zonename),
                            ),
                            onTap: () {
                              if (_selectType == 1) {
                                setState(() {
                                  _provinceItem = item;
                                });
                                print(_selectType);
                                _getCity(item.id, setStates);
                              } else if (_selectType == 2) {
                                setState(() {
                                  _cityItem = item;
                                });
                                print(_selectType);
                                _getDis(item.id, item.parentid, setStates);
                              } else if (_selectType == 3) {
                                setState(() {
                                  _disItem = item;
                                });
                                print(_selectType);
                                _getTown(item.id, setStates);
                              } else {
                                setState(() {
                                  _townItem = item;
                                  _addressTips =
                                      '${_provinceItem.zonename + ' ' + _cityItem.zonename + ' ' + _disItem.zonename + ' ' + _townItem.zonename}';
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
    Map<String, dynamic> params = {"withOverseasCountry": true};
    var responseData = await getProvenceList(params);
    if (responseData.code == '200') {
      List data = responseData.data;
      List<AddressItem> dataList = [];
      data.forEach((element) {
        dataList.add(AddressItem.fromJson(element));
      });
      setState(() {
        _province = dataList;
        _currentList = dataList;
      });
    }
  }

  void _getCity(int parentId, setStates) async {
    Map<String, dynamic> params = {"parentId": parentId};
    var responseData = await getCityList(params);

    List data = responseData.data;
    List<AddressItem> dataList = [];
    data.forEach((element) {
      dataList.add(AddressItem.fromJson(element));
    });

    setStates(() {
      _currentList = dataList;
      _selectType = 2;
      _tabTitle.clear();
      _tabTitle.add('省');
      _tabTitle.add('市');
      _tabController =
          TabController(length: _tabTitle.length, initialIndex: 1, vsync: this);
      _tabController.addListener(() {
        if (_tabController.index == _tabController.animation.value) {
          _tabclick(_tabController.index, setStates);
        }
      });
      _city = dataList;
    });
  }

  void _getDis(int parentId, int grandParentId, setStates) async {
    Map<String, dynamic> params = {
      "parentId": parentId,
      "grandParentId": grandParentId
    };

    var responseData = await getDisList(params);
    List data = responseData.data;
    List<AddressItem> dataList = [];
    data.forEach((element) {
      dataList.add(AddressItem.fromJson(element));
    });

    setStates(() {
      _currentList = dataList;
      _selectType = 3;
      _tabTitle.clear();
      _tabTitle.add('省');
      _tabTitle.add('市');
      _tabTitle.add('区县');
      _tabController =
          TabController(length: _tabTitle.length, initialIndex: 2, vsync: this);
      _tabController.addListener(() {
        if (_tabController.index == _tabController.animation.value) {
          _tabclick(_tabController.index, setStates);
        }
      });
      _dis = dataList;
    });
  }

  void _getTown(int parentId, setStates) async {
    Map<String, dynamic> params = {"parentId": parentId};

    var responseData = await getTown(params);
    List data = responseData.data;
    List<AddressItem> dataList = [];
    data.forEach((element) {
      dataList.add(AddressItem.fromJson(element));
    });

    setStates(() {
      _currentList = dataList;
      _selectType = 4;
      _tabTitle.clear();
      _tabTitle.add('省');
      _tabTitle.add('市');
      _tabTitle.add('区县');
      _tabTitle.add('街道');
      _tabController =
          TabController(length: _tabTitle.length, initialIndex: 3, vsync: this);
      _tabController.addListener(() {
        if (_tabController.index == _tabController.animation.value) {
          _tabclick(_tabController.index, setStates);
        }
      });
      _town = dataList;
    });
  }

  _tabclick(int index, setStates) {
    if (index == 0) {
      setStates(() {
        _currentList = _province;
        _selectType = 1;
      });
    } else if (index == 1) {
      setStates(() {
        _currentList = _city;
        _selectType = 2;
      });
    } else if (index == 2) {
      setStates(() {
        _currentList = _dis;
        _selectType = 3;
      });
    } else if (index == 3) {
      setStates(() {
        _currentList = _town;
        _selectType = 4;
      });
    }
  }

  _addAddress() async {
    Map<String, dynamic> params = {
      'id': _id,
      'provinceId': _provinceItem.id,
      'provinceName': _provinceItem.zonename,
      'cityId': _cityItem.id,
      'cityName': _cityItem.zonename,
      'districtId': _disItem.id,
      'districtName': _disItem.zonename,
      'townId': _townItem.id,
      'townName': _townItem.zonename,
      'address': _addressC.text,
      'name': _nameController.text,
      'mobile': _phoneC.text,
      'dft': _check,
    };

    await addAddress(params).then((responseData) {
      if (responseData.code == '200') {
        Navigator.pop(context);
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _nameController.dispose();
    _phoneC.dispose();
    _addressC.dispose();
    _tabController.dispose();
    super.dispose();
  }
}
