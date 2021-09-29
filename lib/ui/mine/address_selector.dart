import 'package:flutter/material.dart';
import 'package:flutter_app/component/my_under_line_tabindicator.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/ui/mine/model/addressItem.dart';

typedef void AddressValue(
    AddressItem province, AddressItem city, AddressItem dis, AddressItem town);

class AddressSelector extends StatefulWidget {
  final AddressValue addressValue;

  const AddressSelector({Key key, this.addressValue}) : super(key: key);

  @override
  _AddressSelectorState createState() => _AddressSelectorState();
}

class _AddressSelectorState extends State<AddressSelector>
    with TickerProviderStateMixin {
  TabController _tabController;

  List<AddressItem> _province = [];
  List<AddressItem> _city = [];
  List<AddressItem> _dis = [];
  List<AddressItem> _town = [];
  int _selectType = 1;
  List<AddressItem> _currentList = [];
  var _tabTitle = [];

  var _provinceItem = AddressItem();
  var _cityItem = AddressItem();
  var _disItem = AddressItem();
  var _townItem = AddressItem();

  String _addressTips = '省份 城市 区县';

  @override
  void initState() {
    // TODO: implement initState
    _selectType = 1;
    _currentList = _province;
    _tabTitle.clear();
    _tabTitle.add('省');
    _tabController = TabController(length: _tabTitle.length, vsync: this);
    _tabController.addListener(() {
      if (_tabController.index == _tabController.animation.value) {}
    });
    super.initState();
    _getProvince();
  }

  @override
  Widget build(BuildContext context) {
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
                                top: BorderSide(color: backGrey, width: 1))),
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
                          _getCity(item.id);
                        } else if (_selectType == 2) {
                          setState(() {
                            _cityItem = item;
                          });
                          print(_selectType);
                          _getDis(item.id, item.parentid);
                        } else if (_selectType == 3) {
                          setState(() {
                            _disItem = item;
                          });
                          print(_selectType);
                          _getTown(item.id);
                        } else {
                          setState(() {
                            _townItem = item;
                            _addressTips =
                                '${_provinceItem.zonename + ' ' + _cityItem.zonename + ' ' + _disItem.zonename + ' ' + _townItem.zonename}';
                            if (widget.addressValue != null) {
                              widget.addressValue(_provinceItem, _cityItem,
                                  _disItem, _townItem);
                            }
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

  void _getCity(int parentId) async {
    Map<String, dynamic> params = {"parentId": parentId};
    var responseData = await getCityList(params);

    List data = responseData.data;
    List<AddressItem> dataList = [];
    data.forEach((element) {
      dataList.add(AddressItem.fromJson(element));
    });
    setState(() {
      _currentList = dataList;
      _selectType = 2;
      _tabTitle.clear();
      _tabTitle.add('省');
      _tabTitle.add('市');
      _tabController =
          TabController(length: _tabTitle.length, initialIndex: 1, vsync: this);
      _tabController.addListener(() {
        if (_tabController.index == _tabController.animation.value) {
          _tabclick(_tabController.index);
        }
      });
      _city = dataList;
    });
  }

  void _getDis(int parentId, int grandParentId) async {
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

    setState(() {
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
          _tabclick(_tabController.index);
        }
      });
      _dis = dataList;
    });
  }

  void _getTown(int parentId) async {
    Map<String, dynamic> params = {"parentId": parentId};

    var responseData = await getTown(params);
    List data = responseData.data;
    if (data.isEmpty) {
      if (widget.addressValue != null) {
        widget.addressValue(_provinceItem, _cityItem, _disItem, _townItem);
      }
      Navigator.pop(context);
    }
    List<AddressItem> dataList = [];
    data.forEach((element) {
      dataList.add(AddressItem.fromJson(element));
    });

    setState(() {
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
          _tabclick(_tabController.index);
        }
      });
      _town = dataList;
    });
  }

  _tabclick(int index) {
    if (index == 0) {
      setState(() {
        _currentList = _province;
        _selectType = 1;
      });
    } else if (index == 1) {
      setState(() {
        _currentList = _city;
        _selectType = 2;
      });
    } else if (index == 2) {
      setState(() {
        _currentList = _dis;
        _selectType = 3;
      });
    } else if (index == 3) {
      setState(() {
        _currentList = _town;
        _selectType = 4;
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    super.dispose();
  }
}
