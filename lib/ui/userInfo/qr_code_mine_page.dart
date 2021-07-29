import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/ui/userInfo/model/qrCodeModel.dart';
import 'package:flutter_app/ui/userInfo/model/qrUserInfoModel.dart';
import 'package:flutter_app/utils/user_config.dart';
import 'package:flutter_app/widget/app_bar.dart';
import 'package:flutter_app/widget/back_loading.dart';
import 'package:flutter_app/widget/round_net_image.dart';
import 'package:flutter_app/widget/tab_app_bar.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodeMinePage extends StatefulWidget {
  @override
  _QRCodeMinePageState createState() => _QRCodeMinePageState();
}

class _QRCodeMinePageState extends State<QRCodeMinePage> {
  QrCodeModel _qrCodeDate;
  QrUserInfoModel _userData;

  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEEEEEE),
      appBar: TopAppBar(
        title: '邀请返利',
      ).build(context),
      body: _isLoading
          ? Loading()
          : Stack(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(20, 50, 20, 20),
                  margin: EdgeInsets.fromLTRB(20, 90, 20, 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: Text(
                          _userData.nickname,
                          style: TextStyle(
                              fontSize: 16,
                              color: textBlack,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '用户ID:${_userData.userId}',
                              style: TextStyle(color: textGrey),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 5),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 2),
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: redColor, width: 0.5),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text(
                                '复制',
                                style: t12red,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        width: double.infinity,
                        child: QrImage(data: _qrCodeDate.qrCode),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Text(
                          '线下店结账时出示二维码\n享受更多权益',
                          style: TextStyle(height: 1.2),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 50),
                  alignment: Alignment.center,
                  height: 80,
                  child: RoundNetImage(
                    url: user_icon_url,
                    corner: 40,
                    height: 80,
                    width: 80,
                  ),
                )
              ],
            ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();

    _getQrCode();
  }

  _getData() async {
    Future.wait([
      qrCode().then((value) {
        return value;
      }),
      getUserSpmcInfo().then((value) {
        return value;
      })
    ]).then((result) {
      setState(() {
        _isLoading = false;
        _qrCodeDate = QrCodeModel.fromJson(result[0].data);
        _userData = QrUserInfoModel.fromJson(result[1].data);
      });
    });
  }

  Timer _timer;

  _getQrCode() async {
    _timer = Timer.periodic(Duration(milliseconds: 5000), (timer) {
      qrCode().then((responseData) {
        setState(() {
          _qrCodeDate = QrCodeModel.fromJson(responseData.data);
        });
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _timer.cancel();
    super.dispose();
  }
}
