import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/component/app_bar.dart';
import 'package:flutter_app/component/button_widget.dart';

class FeedBack extends StatefulWidget {
  @override
  _FeedBackState createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {
  final _tvController = TextEditingController();
  String _phone = '';
  List _feedbackList = [];

  var _selectType = Map();

  @override
  void initState() {
    // TODO: implement initState
    _getData();
    _getPhone();
    super.initState();
  }

  void _getData() async {
    var responseData = await userMobile();
    setState(() {
      _phone = responseData.data;
    });

    var feedback = await feedbackType();
    if (feedback.data != null) {
      setState(() {
        _feedbackList = feedback.data;
        for (var value in _feedbackList) {
          if (value['type'] == 6) {
            setState(() {
              _selectType = value;
            });
          }
        }
      });
    }
  }

  void _getPhone() async {
    var responseData = await userMobile();
    setState(() {
      _phone = responseData.data;
    });
  }

  void _submit() async {
    Map<String, dynamic> params = {
      "type": _selectType['type'],
      "content": _tvController.text,
      "mobile": _phone,
    };
    var feedback = await feedbackSubmit(params);
    if (feedback.data != null) {
      setState(() {
        _feedbackList = feedback.data;
        for (var value in _feedbackList) {
          if (value['type'] == 6) {
            setState(() {
              _selectType = value;
            });
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      appBar: TopAppBar(
        title: '意见反馈',
      ).build(context),
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    child: Container(
                      color: Colors.white,
                      margin: EdgeInsets.symmetric(vertical: 15),
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              child: Container(
                                child: Text(
                                  '${_selectType['desc'] ?? ''}',
                                  style: t16black,
                                ),
                              ),
                              onTap: () {
                                _buildBottomDecDialog(context);
                              },
                            ),
                          ),
                          Image.asset(
                            'assets/images/arrow_down.png',
                            width: 12,
                            height: 12,
                          ),
                        ],
                      ),
                    ),
                    onTap: () {},
                  ),
                  Container(
                    child: TextField(
                      style: t14black,
                      controller: _tvController,
                      maxLines: 10,
                      maxLength: 500,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        hintStyle: TextStyle(color: textHint),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 0,
                        )),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 0,
                        )),
                        hintText: '对我们网站、商品、服务，你还有什么建议吗？你还希望在严选上买到什么？请告诉我们...',
                        filled: true,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      '手机号码',
                      style: t14grey,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    width: double.infinity,
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                    child: Text('$_phone'),
                  )
                ],
              ),
            ),
          ),
          SafeArea(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: NormalBtn('提交', backRed, () {
                _submit();
                Navigator.pop(context);
              }),
            ),
          ),
        ],
      ),
    );
  }

  _buildBottomDecDialog(BuildContext context) {
    //底部弹出框,背景圆角的话,要设置全透明,不然会有默认你的白色背景
    return showModalBottomSheet(
      //设置true,不会造成底部溢出
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          width: double.infinity,
          constraints: BoxConstraints(maxHeight: 500),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(),
          ),
          child: Container(
              child: SingleChildScrollView(
            child: Column(
              children: _feedbackList.map<Widget>((item) {
                return GestureDetector(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: lineColor, width: 1))),
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Center(
                      child: Text(
                        '${item['desc']}',
                        style: _selectType['desc'] == item['desc']
                            ? t14red
                            : t14black,
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    setState(() {
                      _selectType = item;
                    });
                  },
                );
              }).toList(),
            ),
          )),
        );
      },
    );
  }
}
