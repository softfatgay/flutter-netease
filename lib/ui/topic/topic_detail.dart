import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/http/api.dart';
import 'package:flutter_app/utils/util_mine.dart';
import 'package:flutter_app/utils/widget_util.dart';
import 'package:flutter_app/widget/loading.dart';
import 'package:flutter_html/flutter_html.dart';

/*const SliverAppBar({
Key key,
this.leading,//左侧的图标或文字，多为返回箭头
this.automaticallyImplyLeading = true,//没有leading为true的时候，默认返回箭头，没有leading且为false，则显示title
this.title,//标题
this.actions,//标题右侧的操作
this.flexibleSpace,//可以理解为SliverAppBar的背景内容区
this.bottom,//SliverAppBar的底部区
this.elevation,//阴影
this.forceElevated = false,//是否显示阴影
this.backgroundColor,//背景颜色
this.brightness,//状态栏主题，默认Brightness.dark，可选参数light
this.iconTheme,//SliverAppBar图标主题
this.actionsIconTheme,//action图标主题
this.textTheme,//文字主题
this.primary = true,//是否显示在状态栏的下面,false就会占领状态栏的高度
this.centerTitle,//标题是否居中显示
this.titleSpacing = NavigationToolbar.kMiddleSpacing,//标题横向间距
this.expandedHeight,//合并的高度，默认是状态栏的高度加AppBar的高度
this.floating = false,//滑动时是否悬浮
this.pinned = false,//标题栏是否固定
this.snap = false,//配合floating使用
})*/


class Topicdetail extends StatefulWidget {
  final Map arguments;

  Topicdetail({this.arguments});

  @override
  _TopicdetailState createState() => _TopicdetailState();
}

class _TopicdetailState extends State<Topicdetail> {
  var goodMsg = {};
  bool isLoading = true;
  List commentList = [];
  String title;
  bool titleColor = false;

  String content;
  String htmlContent;

  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Loading();
    } else {
      return Scaffold(
        body: CustomScrollView(
          controller: _scrollController,
          slivers: <Widget>[
            SliverAppBar(
              iconTheme: IconThemeData(color: titleColor?Colors.blue:Colors.grey[200]),
              brightness: Brightness.dark,
              pinned: true,
              elevation: 0,
              expandedHeight: 200.0,
              titleSpacing: 5,
              backgroundColor: Colors.white,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  '${goodMsg['title']}',
                  style: TextStyle(color: titleColor?Colors.blue:Colors.transparent),
                ),
                background: CachedNetworkImage(
                  imageUrl: goodMsg['scene_pic_url'],
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SliverList(
              delegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
                return SingleChildScrollView(
                  child: Html(
                    data: json.decode(htmlContent),
                  ),
                );
              }, childCount: 1),
            ),
            WidgetUtil.buildASingleSliver(buildText()),
            SliverList(
                delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(color: Colors.white),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          commentList[index]['content'],
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.blue),
                        ),
                        width: double.infinity,
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(10),
                        child: Text(
                          commentList[index]['add_time'],
                          textAlign: TextAlign.right,
                          style: TextStyle(color: Colors.grey),
                        ),
                      )
                    ],
                  ),
                );
              },
              childCount: commentList.length,
            )),
            WidgetUtil.buildASingleSliver(buildFooter()),
          ],
        ),
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getInitData();
    _scrollController.addListener((){
      var pixels = _scrollController.position.pixels;
      print(pixels);
      setState(() {
        if (pixels>150) {
          titleColor = true;
        }else{
          titleColor = false;
        }
      });
    });
  }

  _getInitData() async {
    var id = widget.arguments['id'];
    Response data1 = await Api.getTopicMsg(id: id);
    Response data2 =
        await Api.getTopicComment(valueId: id, typeId: 1, page: 1, size: 5);
    setState(() {
      isLoading = false;
      goodMsg = data1.data;
      title = data1.data['title'];
      commentList = data2.data['data'];
      content =
          '${'<p>' + goodMsg['content'].replaceAll('\n    ', '') + '</p>'}';
      htmlContent = json.encode(content).replaceAll('//', 'http://');
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }

  Widget buildText() {
    return Container(
      width: double.infinity,
      color: Colors.white,
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Text('留言',style: TextStyle(color: Colors.blue,fontSize: 18),textAlign: TextAlign.center,),
    );
  }

  Widget buildFooter() {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: FlatButton(
              onPressed: () {},
              child: Text(
                '留言',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              color: Colors.blue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4))),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: FlatButton(
              onPressed: () {},
              child: Text(
                '评论',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              color: Colors.blue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4))),
            ),
          ),
        ),
      ],
    );
  }

}
