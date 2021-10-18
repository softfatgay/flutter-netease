import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/http_manager/net_contants.dart';
import 'package:flutter_app/ui/goods_detail/model/interstItemModel.dart';
import 'package:flutter_app/utils/toast.dart';
import 'package:flutter_app/utils/user_config.dart';
import 'package:flutter_app/component/app_bar.dart';
import 'package:flutter_app/component/button_widget.dart';
import 'package:flutter_app/component/round_net_image.dart';
import 'package:flutter_app/component/tab_app_bar.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  List<InterstItemModel> _dataList = [];

  List _up = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _interestCategory();
  }

  void _interestCategory() async {
    Map<String, dynamic> headers = {"Cookie": cookie};
    Options options = Options(
      method: 'get',
      headers: headers,
    );
    Response response = await Dio().get(
        '${NetContants.baseUrl}interestCategory/list.json',
        queryParameters: {'csrf_token': csrf_token},
        options: options);
    Map<String, dynamic> dataMap = Map<String, dynamic>.from(response.data);
    List dataMap2 = dataMap['interestCategoryList'];
    List<InterstItemModel> dataList = [];
    dataMap2.forEach((element) {
      dataList.add(InterstItemModel.fromJson(element));
    });
    setState(() {
      _dataList = dataList;
    });

    _dataList.forEach((element) {
      if (element.selectFlag!) {
        _up.add(element.categoryCode);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopAppBar(
        title: '感兴趣',
      ).build(context),
      body: _buildBody(),
    );
  }

  _buildBody() {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(0, 30, 0, 45),
          child: GridView.count(
            crossAxisCount: 3,
            mainAxisSpacing: 20,
            children: _dataList.map((item) => _buildItem(item)).toList(),
          ),
        ),
        Positioned(
          child: Container(
            alignment: Alignment.center,
            height: 30,
            child: Text(
              '多选几个，小选会推荐得更准确哦！',
              textAlign: TextAlign.center,
              style: t12black,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            width: double.infinity,
            child: Row(
              children: [
                Expanded(
                    child: NormalBtn('取消', backWhite, () {
                  Navigator.pop(context);
                }, textStyle: t14grey)),
                Expanded(
                    child: NormalBtn('保存', backRed, () {
                  _submit();
                })),
              ],
            ),
          ),
        )
      ],
    );
  }

  GestureDetector _buildItem(InterstItemModel item) {
    return GestureDetector(
      child: Container(
        child: Column(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Stack(
                  children: [
                    Container(
                      child: RoundNetImage(
                        corner: 4,
                        width: double.infinity,
                        height: double.infinity,
                        url: '${item.picUrl}',
                        fit: BoxFit.fill,
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: item.selectFlag!
                          ? Container(
                              decoration: BoxDecoration(
                                  color: Color(0X33000000),
                                  borderRadius: BorderRadius.circular(4)),
                              child: Icon(
                                Icons.check_circle_rounded,
                                color: Colors.green,
                                size: 35,
                              ),
                            )
                          : Container(),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Text('${item.categoryName}'),
          ],
        ),
      ),
      onTap: () {
        setState(() {
          if (item.selectFlag!) {
            if (_up.indexOf(item.categoryCode) != -1) {
              _up.remove(item.categoryCode);
            }
          } else {
            if (_up.indexOf(item.categoryCode) == -1) {
              _up.add(item.categoryCode);
            }
          }
          item.selectFlag = !item.selectFlag!;
        });
      },
    );
  }

  _submit() async {
    var responseData = await interestCategoryUpsert(data: _up);
    if (responseData.code == '200') {
      Toast.show('保存成功', context);
    }
  }
}
