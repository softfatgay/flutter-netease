import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/ui/userInfo/model/sizeItemModel.dart';
import 'package:flutter_app/utils/toast.dart';
import 'package:flutter_app/utils/user_config.dart';
import 'package:flutter_app/component/app_bar.dart';
import 'package:flutter_app/component/button_widget.dart';
import 'package:flutter_app/component/check_box.dart';

class AddNewSize extends StatefulWidget {
  final Map params;

  const AddNewSize({Key key, this.params}) : super(key: key);

  @override
  _AddNewSizeState createState() => _AddNewSizeState();
}

class _AddNewSizeState extends State<AddNewSize> {
  final _tController1 = TextEditingController();
  final _tController2 = TextEditingController();
  final _tController3 = TextEditingController();
  final _tController4 = TextEditingController();
  final _tController5 = TextEditingController();
  final _tController6 = TextEditingController();
  final _tController7 = TextEditingController();
  final _tController8 = TextEditingController();
  final _tController9 = TextEditingController();
  final _tController10 = TextEditingController();

  int _sex = 1;
  bool _setDft = false;

  String _womenImg =
      'https://yanxuan.nosdn.127.net/fd85e883e204e0debc8722e14a8f824f.png';
  String _manImg =
      'https://yanxuan.nosdn.127.net/c01a4d2db34e2ef2fc2c8ce368b9beda.png';

  String _sizeImg = '';

  num _id;

  SizeItemModel _sizeItemModel = SizeItemModel();

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      _sizeImg = _manImg;
      if (widget.params != null) {
        _id = widget.params['id'];
        print(_id);
        _querySizeId(_id);
      }
    });
    super.initState();
  }

  _querySizeId(num id) async {
    Map<String, dynamic> params = {'id': id};
    var responseData = await querySizeId(params);
    if (responseData.code == '200') {
      setState(() {
        _sizeItemModel = SizeItemModel.fromJson(responseData.data);
        setState(() {
          _tController1.text = _sizeItemModel.roleName;
          _tController2.text = _setSize(_sizeItemModel.height);
          _tController3.text = _setSize(_sizeItemModel.bodyWeight);
          _tController4.text = _setSize(_sizeItemModel.shoulderBreadth);
          _tController5.text = _setSize(_sizeItemModel.bust);
          _tController6.text = _setSize(_sizeItemModel.waistCircumference);
          _tController7.text = _setSize(_sizeItemModel.hipCircumference);
          _tController8.text = _setSize(_sizeItemModel.footLength);
          _tController9.text = _setSize(_sizeItemModel.footCircumference);
          _tController10.text = _setSize(_sizeItemModel.underBust);
          _setDft = _sizeItemModel.dft;
          _sex = _sizeItemModel.gender;
          if (_sex == 2) {
            _sizeImg = _womenImg;
          }
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopAppBar(title: '添加尺码').build(context),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 65,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildName('角色名称', _tController1),
                  _buildSex(),
                  _buildContent(
                      '身高(cm)', _tController2, '体重(kg)', _tController3),
                  _buildContent(
                      '肩宽(cm)', _tController4, '胸围(cm)', _tController5),
                  _buildContent(
                      '腰围(cm)', _tController6, '臀围(cm)', _tController7),
                  _buildContent(
                      '脚长(cm)', _tController8, '脚围(cm)', _tController9),
                  (_sex == 1 || _sex == 3)
                      ? Container()
                      : _buildContent('下胸围(cm)', _tController10, '', null),
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    child: Text(
                      '信息越完整, 对您选择服饰时越有帮助',
                      style: t12grey,
                    ),
                  ),
                  _checkDft(),
                  Container(height: 10, color: backColor),
                  _sizeModelTitle(),
                  _sizeModelImg()
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: NormalBtn('保存', backRed, () {
                _saveSize();
              }),
            ),
          ),
        ],
      ),
    );
  }

  Container _sizeModelTitle() {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: lineColor, width: 0.5),
        ),
      ),
      child: Text(
        '测量参考',
        style: t16black,
      ),
    );
  }

  _textFiled(TextEditingController controller) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: textBlack, width: 0.5),
          borderRadius: BorderRadius.circular(2)),
      width: 100,
      height: 30,
      child: TextField(
        controller: controller,
        textAlign: TextAlign.center,
        style: TextStyle(textBaseline: TextBaseline.alphabetic, fontSize: 14),
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent, width: 0),
            ),
            contentPadding: EdgeInsets.only(top: 0, bottom: 0),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent, width: 0),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent, width: 0),
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 0, color: Colors.transparent))),
      ),
    );
  }

  _buildName(String title, TextEditingController controller) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Text('$title', style: t14black),
          SizedBox(width: 10),
          _textFiled(controller),
        ],
      ),
    );
  }

  _buildItem(String title, TextEditingController controller) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Text('$title', style: t14black),
          SizedBox(width: 10),
          Expanded(
            child: _textFiled(controller),
          ),
          SizedBox(width: 20)
        ],
      ),
    );
  }

  _buildSex() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.only(top: 10),
      child: Row(
        children: [
          Text(
            '性     别    ',
            style: t14black,
          ),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                MCheckBox(
                  suffixText: '男',
                  check: _sex == 1,
                  onPress: () {
                    setState(() {
                      _sex = 1;
                      _sizeImg = _manImg;
                    });
                  },
                ),
                SizedBox(
                  width: 25,
                ),
                MCheckBox(
                  suffixText: '女',
                  check: _sex == 2,
                  onPress: () {
                    setState(() {
                      _sex = 2;
                      _sizeImg = _womenImg;
                    });
                  },
                ),
                SizedBox(
                  width: 25,
                ),
                MCheckBox(
                  suffixText: '儿童',
                  check: _sex == 3,
                  onPress: () {
                    setState(() {
                      _sex = 3;
                      _sizeImg = _manImg;
                    });
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  _buildContent(String lTitle, TextEditingController lController, String rTitle,
      TextEditingController rController) {
    return Container(
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: _buildItem('$lTitle', lController),
          ),
          Expanded(
            flex: 1,
            child: rController == null
                ? Container()
                : _buildItem('$rTitle', rController),
          ),
        ],
      ),
    );
  }

  _checkDft() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MCheckBox(
            suffixText: '设为默认',
            check: _setDft,
            onPress: () {
              setState(() {
                _setDft = !_setDft;
              });
            },
          ),
        ],
      ),
    );
  }

  _sizeModelImg() {
    return Container(
      child: CachedNetworkImage(imageUrl: _sizeImg),
    );
  }

  void _saveSize() async {
    var params = {
      'csrf_token': csrf_token,
      'dft': _setDft ? 1 : _setDft,
      'roleName': _submitSize(_tController1),
      'gender': _sex,
      'underBust': _submitSize(_tController10),
      'height': _submitSize(_tController2),
      'bodyWeight': _submitSize(_tController3),
      'shoulderBreadth': _submitSize(_tController4),
      'bust': _submitSize(_tController5),
      'waistCircumference': _submitSize(_tController6),
      'hipCircumference': _submitSize(_tController7),
      'footLength': _submitSize(_tController8),
      'footCircumference': _submitSize(_tController9),
    };

    if (_id != null) {
      params['id'] = _id;
    }

    var responseData = await addSize(params);
    if (responseData.code == '200') {
      Toast.show('保存成功', context);
      Navigator.pop(context);
    } else {
      if (responseData.errorCode != null) {
        Toast.show('${responseData.errorCode}', context);
      }
    }
  }

  _submitSize(TextEditingController controller) {
    if (controller.text == '') {
      return -1;
    } else {
      return controller.text;
    }
  }

  _setSize(num value) {
    if (value == -1) {
      return '';
    } else {
      return value.toString();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tController1.dispose();
    _tController2.dispose();
    _tController3.dispose();
    _tController4.dispose();
    _tController5.dispose();
    _tController6.dispose();
    _tController7.dispose();
    _tController8.dispose();
    _tController9.dispose();
    _tController10.dispose();
    super.dispose();
  }
}
