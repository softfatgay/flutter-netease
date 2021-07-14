import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/ui/userInfo/model/userInfoModel.dart';
import 'package:flutter_app/utils/router.dart';
import 'package:flutter_app/utils/user_config.dart';
import 'package:flutter_app/widget/cart_check_box.dart';
import 'package:flutter_app/widget/check_box.dart';
import 'package:flutter_app/widget/global.dart';
import 'package:flutter_app/widget/m_textfiled.dart';
import 'package:flutter_app/widget/normal_textfiled.dart';
import 'package:flutter_app/widget/tab_app_bar.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class UserInfoPage extends StatefulWidget {
  const UserInfoPage({Key key}) : super(key: key);

  @override
  _UserInfoPageState createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  UserInfoModel _userInfoModel = UserInfoModel();
  final _nameController = TextEditingController();

  int _sex = 0;

  DateTime _birthDay;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getUserInfo();
  }

  void _getUserInfo() async {
    var params = {
      "csrf_token": csrf_token,
    };
    var responseData = await ucenterInfo(params);
    setState(() {
      _userInfoModel = UserInfoModel.fromJson(responseData.data);
      _nameController.text = _userInfoModel.user.nickname;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TabAppBar(title: '个人信息').build(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildId(),
            _buildAccount(),
            _buildNickame(),
            _buildSexy(),
            _buildBirthday(),
            _favorite()
          ],
        ),
      ),
    );
  }

  _buildId() {
    return Container(
      decoration: BoxDecoration(
          color: backWhite,
          border: Border(bottom: BorderSide(color: lineColor, width: 0.5))),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text('用户ID'),
          ),
          Expanded(
            flex: 2,
            child: Text('${_userInfoModel.user.id}'),
          )
        ],
      ),
    );
  }

  _buildAccount() {
    return Container(
      decoration: BoxDecoration(
          color: backWhite,
          border: Border(bottom: BorderSide(color: lineColor, width: 0.5))),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text('账号关联'),
          ),
          arrowRightIcon
        ],
      ),
    );
  }

  _buildNickame() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
          color: backWhite,
          border: Border(bottom: BorderSide(color: lineColor, width: 0.5))),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text('昵称'),
          ),
          Expanded(
            flex: 2,
            child: Container(
              height: 50,
              child: NormalTextFiled(
                controller: _nameController,
              ),
            ),
          )
        ],
      ),
    );
  }

  _buildSexy() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
          color: backWhite,
          border: Border(bottom: BorderSide(color: lineColor, width: 0.5))),
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text('性别'),
          ),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                MCheckBox(
                  suffixText: '男',
                  check: _sex == 0,
                  onPress: () {
                    setState(() {
                      _sex = 0;
                    });
                  },
                ),
                SizedBox(
                  width: 25,
                ),
                MCheckBox(
                  suffixText: '女',
                  check: _sex == 1,
                  onPress: () {
                    setState(() {
                      _sex = 1;
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

  _buildBirthday() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
          color: backWhite,
          border: Border(bottom: BorderSide(color: lineColor, width: 0.5))),
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text('出生日期'),
          ),
          Expanded(
            flex: 2,
            child: GestureDetector(
              child: Container(
                child: Text(_birthDay == null
                    ? ''
                    : '${_birthDay.year}-${_birthDay.month}-${_birthDay.day}'),
              ),
              onTap: () {
                print('-------');

                DatePicker.showDatePicker(context,
                    showTitleActions: true,
                    minTime: DateTime(1980, 1, 12),
                    maxTime: DateTime(2021, 1, 12),
                    theme: DatePickerTheme(
                      headerColor: backWhite,
                      backgroundColor: backWhite,
                      itemStyle: t14black,
                      doneStyle: t14black,
                    ),
                    onChanged: (date) {}, onConfirm: (DateTime date) {
                  setState(() {
                    _birthDay = date;
                  });
                }, currentTime: DateTime.now(), locale: LocaleType.zh);
              },
            ),
          ),
          arrowRightIcon
        ],
      ),
    );
  }

  _favorite() {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
            color: backWhite,
            border: Border(bottom: BorderSide(color: lineColor, width: 0.5))),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Row(
          children: [
            Expanded(
              child: Text('感兴趣的分类'),
            ),
            arrowRightIcon
          ],
        ),
      ),
      onTap: () {
        Routers.push(Routers.favorite, context);
      },
    );
  }
}
