import 'dart:io';
import 'dart:ui' as prefix0;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/utils/flutter_activity.dart';
import 'package:flutter_app/utils/router.dart';
import 'package:flutter_app/utils/util_mine.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  final String icon =
      'http://img2.imgtn.bdimg.com/it/u=664126570,3319232266&fm=26&gp=0.jpg';

  final String imageAsset = 'assets/images/boduoxiaojie.png';
  File image;

  ScrollController _scrollController = ScrollController();
  String title = '';

  List itemList1 = [
    _ItemList(Icon(Icons.headset, color: Colors.blue), '我的客服'),
  ];
  List itemList = [
    _ItemList(Icon(Icons.info_outline, color: Colors.blue), '关于'),
    _ItemList(Icon(Icons.account_box, color: Colors.blue), '登录'),
    _ItemList(Icon(Icons.settings, color: Colors.blue), '设置'),
    _ItemList(Icon(Icons.list, color: Colors.blue), '搜索+下拉菜单'),
    _ItemList(Icon(Icons.collections_bookmark, color: Colors.blue), 'PageView(垂直翻页效果)'),
    _ItemList(Icon(Icons.videocam, color: Colors.blue), '我的收藏(视频播放演示)'),
    _ItemList(Icon(Icons.last_page, color: Colors.blue), '展示条目'),
    _ItemList(Icon(Icons.last_page, color: Colors.blue), '展示条目'),
    _ItemList(Icon(Icons.last_page, color: Colors.blue), '展示条目'),
    _ItemList(Icon(Icons.last_page, color: Colors.blue), '展示条目'),
    _ItemList(Icon(Icons.last_page, color: Colors.blue), '展示条目'),
    _ItemList(Icon(Icons.last_page, color: Colors.blue), '展示条目'),
    _ItemList(Icon(Icons.last_page, color: Colors.blue), '展示条目'),
    _ItemList(Icon(Icons.last_page, color: Colors.blue), '展示条目'),
    _ItemList(Icon(Icons.last_page, color: Colors.blue), '展示条目'),
    _ItemList(Icon(Icons.last_page, color: Colors.blue), '展示条目'),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.offset > 150) {
        setState(() {
          title = '我的';
        });
      } else if (_scrollController.offset <= 150) {
        setState(() {
          title = '';
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: 200,
            backgroundColor: Colors.white,
            title: Text(
              title,
              style: TextStyle(color: Colors.blue),
            ),
            centerTitle: true,
            flexibleSpace: FlexibleSpaceBar(
              background: buildUserMsg(),
            ),
          ),
          buildOneSliver(buildges(buildWidget(itemList1, 0))),
          buildOneBottomSliver(itemList),
        ],
      ),
    );
  }

  SliverList buildOneSliver(Widget widget, {int childCount = 1}) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        return widget;
      }, childCount: childCount),
    );
  }

  Widget buildOrder() {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(4))),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
              decoration: BoxDecoration(),
              child: Text(
                '全部订单',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
              child: Text(
                '运输中',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
              child: Text(
                '待支付',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildUserMsg() {
    return Stack(
      children: <Widget>[
        BackdropFilter(
          filter: prefix0.ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Opacity(
            opacity: 0.7,
            child: Container(
              width: double.infinity,
              child: Image.asset(
                imageAsset,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: GestureDetector(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        child: Text(
                          '波多老师',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 10),
                        child: Text(
                          '我是一头小毛驴,怎么都不会骑我是一头小毛驴,怎么都不会骑',
                          textAlign: TextAlign.left,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    Flutter2Activity.toActivity(Flutter2Activity.webView,
                        arguments: {
                          'url':
                              'https://baike.baidu.com/item/%E6%B3%A2%E5%A4%9A%E9%87%8E%E7%BB%93%E8%A1%A3/1505010?fr=aladdin'
                        });
                  },
                ),
              ),
              GestureDetector(
                child: ClipOval(
                  child: Container(
                    width: 70,
                    height: 70,
                    child: image == null
                        ? Image.asset(
                            imageAsset,
                            fit: BoxFit.cover,
                          )
                        : Image.file(
                            image,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                onTap: () {
                  _showDialog(context);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  SliverList buildOneBottomSliver(List itemList) {
    return SliverList(
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
      if (itemList.length > 0) {
        for (int i = 0; i < (itemList.length); i++) {
          return Router.link(buildWidget(itemList, index), Util.setting,
              context, {'id': index});
        }
      }
      return Container();
    }, childCount: itemList.length));
  }

  Widget buildWidget(List itemList, int index) {
    Widget widget = Container(
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(width: 0.5, color: Colors.grey[200]))),
      padding: EdgeInsets.fromLTRB(0, 15, 15, 15),
      margin: EdgeInsets.only(left: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          itemList[index].icon,
          Expanded(
              child: Container(
            padding: EdgeInsets.only(left: 10),
            child: Text(itemList[index].name),
          )),
          Icon(
            Icons.keyboard_arrow_right,
            color: Colors.grey,
          )
        ],
      ),
    );
    return widget;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }

  _showDialog(BuildContext context) {
    showCupertinoModalPopup(
        context: context,
        builder: (context) {
          var dialog = CupertinoActionSheet(
            title: Text('更改图像'),
            cancelButton: CupertinoActionSheetAction(
                onPressed: () {
                  Navigator.pop(context, 0);
                },
                child: Text('取消')),
            actions: <Widget>[
              CupertinoActionSheetAction(
                onPressed: () {
                  _showImagePicker(ImageSource.camera);
                  Navigator.pop(context, 0);
                },
                child: Text('相机'),
              ),
              CupertinoActionSheetAction(
                onPressed: () {
                  _showImagePicker(ImageSource.gallery);
                  Navigator.pop(context, 0);
                },
                child: Text('相册'),
              ),
            ],
          );
          return dialog;
        });
  }

  _showImagePicker(ImageSource type) async {
    File data = await ImagePicker.pickImage(source: type);
    setState(() {
      image = data;
    });
  }

  Widget buildges(Widget widget) {
    return GestureDetector(
      child: widget,
      onTap: () {
        launch('tel:10086');
      },
    );
  }
}

class _ItemList {
  Icon icon;
  String name;

  _ItemList(this.icon, this.name);
}
