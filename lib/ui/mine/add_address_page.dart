import 'package:flutter/material.dart';
import 'package:flutter_app/component/app_bar.dart';
import 'package:flutter_app/component/m_textfiled.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/ui/mine/address_selector.dart';
import 'package:flutter_app/ui/mine/model/addressItem.dart';
import 'package:flutter_app/ui/mine/model/locationItemModel.dart';

class AddAddressPage extends StatefulWidget {
  final Map? params;

  const AddAddressPage({Key? key, this.params}) : super(key: key);

  @override
  _AddAddressPageState createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage>
    with TickerProviderStateMixin {
  final _nameController = TextEditingController();
  final _phoneC = TextEditingController();
  final _addressC = TextEditingController();
  String _addressTips = '省份、城市、区县';
  bool _check = false;

  var _provinceItem = AddressItem();
  var _cityItem = AddressItem();
  var _disItem = AddressItem();
  var _townItem = AddressItem();

  late LocationItemModel _addressItem;

  String _dftAddressTips = '省份、城市、区县';
  num? _id = 0;
  String _title = '新增地址';

  @override
  void initState() {
    // TODO: implement initState
    if (widget.params != null) {
      setState(() {
        var argument = widget.params!['address'];
        if (argument != null) {
          _title = '修改地址';
          _addressItem = argument;
          _nameController.text = _addressItem.name!;
          _phoneC.text = _addressItem.mobile!;
          _provinceItem.id = _addressItem.provinceId;
          _provinceItem.zonename = _addressItem.provinceName;
          _cityItem.id = _addressItem.cityId;
          _cityItem.zonename = _addressItem.cityName;
          _disItem.id = _addressItem.districtId;
          _disItem.zonename = _addressItem.districtName;
          _townItem.id = _addressItem.townId;
          _townItem.zonename = _addressItem.townName;
          _addressC.text = _addressItem.address!;
          _check = _addressItem.dft ?? false;
          _id = _addressItem.id;
          _addressTips =
              '${_provinceItem.zonename! + ' ' + _cityItem.zonename! + ' ' + _disItem.zonename! + ' ' + _townItem.zonename!}';
        }
      });
    }
    super.initState();
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
        body: _buildBody(context),
      ),
    );
  }

  _buildBody(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            child: Column(
              children: [
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: MTextFiled(
                    keyboardType: TextInputType.text,
                    controller: _nameController,
                    hintText: '姓名',
                  ),
                ),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                              bottom:
                                  BorderSide(width: 0.5, color: lineColor))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '$_addressTips',
                            style: _addressTips == _dftAddressTips
                                ? t14lightGrey
                                : t16black,
                          ),
                          _addressTips == _dftAddressTips
                              ? Text(
                                  '(请选择乡镇/街道)',
                                  style: t14Orange,
                                )
                              : Container()
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
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: MTextFiled(
                    keyboardType: TextInputType.text,
                    controller: _addressC,
                    hintText: '详细地址 街道 楼盘号等',
                  ),
                ),
                GestureDetector(
                  child: Container(
                    padding: EdgeInsets.only(bottom: 5),
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
                          '设为默认地址',
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
        Row(
          children: [
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  child: Text(
                    '取消',
                    style: TextStyle(color: textGrey, fontSize: 16),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: _addAddress,
                child: Container(
                  alignment: Alignment.center,
                  color: redColor,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  child: Text(
                    '保存',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  _showAddress(BuildContext context) {
    return showModalBottomSheet(
      //设置true,不会造成底部溢出
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setStates) {
          return Container(
            height: 350,
            color: Colors.white,
            child: AddressSelector(
              addressValue: (province, city, dis, town) {
                setState(() {
                  _provinceItem = province;
                  _cityItem = city;
                  _disItem = dis;
                  _townItem = town;
                  _addressTips =
                      '${_provinceItem.zonename! + ' ' + _cityItem.zonename! + ' ' + _disItem.zonename! + ' ' + _townItem.zonename!}';
                });
              },
            ),
          );
        });
      },
    );
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

    var responseData = await addAddress(params);
    if (mounted) {
      if (responseData.code == '200') {
        Navigator.pop(context);
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _nameController.dispose();
    _phoneC.dispose();
    _addressC.dispose();
    super.dispose();
  }
}
