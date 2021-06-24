import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/utils/flutter_activity.dart';
import 'package:flutter_app/widget/tab_app_bar.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TabAppBar(
        tabs: [],
        title: '关于',
      ).build(context),
      body: CustomScrollView(
        slivers: <Widget>[
          buildOneSliver(buildRichText()),
          buildOneSliver(buildOtherApi()),
        ],
      ),
    );
  }

  SliverList buildOneSliver(Widget child) {
    return SliverList(
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
      return child;
    }, childCount: 1));
  }

  Widget buildRichText() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(15),
            child: RichText(
              text: TextSpan(
                style: TextStyle(color: Colors.black87, fontSize: 14),
                children: [
                  TextSpan(text: '项目地址:  '),
                  TextSpan(
                      text: '项目地址\n\n',
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 16,
                          decoration: TextDecoration.underline),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Flutter2Activity.toActivity(Flutter2Activity.webView,
                              arguments: {
                                'url':
                                    'https://github.com/softfatgay/FlutterWant'
                              });
                        }),
                  TextSpan(text: '关于:         '),
                  TextSpan(
                      text: '我\n\n',
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 16,
                          decoration: TextDecoration.underline),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Flutter2Activity.toActivity(Flutter2Activity.webView,
                              arguments: {
                                'url': 'https://github.com/softfatgay'
                              });
                        }),
                  TextSpan(text: '此项目是基于'),
                  TextSpan(
                      text: 'luoGuoXiong',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                          decoration: TextDecoration.underline),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Flutter2Activity.toActivity(Flutter2Activity.webView,
                              arguments: {'url': 'https://github.com/Peroluo'});
                        }),
                  TextSpan(text: '的flutter项目'),
                  TextSpan(
                      text: 'easyMarketFlutter',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                          decoration: TextDecoration.underline),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Flutter2Activity.toActivity(Flutter2Activity.webView,
                              arguments: {
                                'url':
                                    'https://github.com/Peroluo/easyMarketFlutter'
                              });
                        }),
                  TextSpan(
                      text:
                          '而写的,其中前三个模块的接口也是其项目用的api，其次，再次非常感谢luoGuoXiong，作为一个初学者，给我提供了非常大的帮\n\n'),
                  TextSpan(
                      text: '做的一些改进：\n',
                      style: TextStyle(color: Colors.blue, fontSize: 16)),
                  TextSpan(
                      text:
                          '➤为了演示与luoGuoXiong使用的Dio网络库对比，把几个接口返回数据进行了封装，直接解析成大家比较直观的java Model类型\n'),
                  TextSpan(text: '➤添加了flutter与安卓原生的交互，调用安卓activity，并为其传递参数\n'),
                  TextSpan(text: '➤为了方便大家理解，项目目录重新划分，以文件的形式，把各个模块区分\n'),
                  TextSpan(text: '➤其中实现比较复杂的模块，使用了比较简单的形式实现\n'),
                  TextSpan(text: '➤其中部分模块实现安卓原生吸附的效果\n'),
                  TextSpan(text: '➤拍照/相册(我的界面，点击图像),弹出框等其他一些内容\n'),
                  TextSpan(text: '➤视频播放(chewie,更改了源码,添加全屏标题返回键,双击手势)\n'),
                  TextSpan(text: '➤封装有StafulWidget的组件,带有回调的,供大家参考(搜索框)\n'),
                  TextSpan(text: '➤本页使用了富文本，以及富文本点击事件，跳转安卓原生Webview\n'),
                  TextSpan(text: '➤给'),
                  TextSpan(
                      text: 'luoGuoXiong',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                          decoration: TextDecoration.underline),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Flutter2Activity.toActivity(Flutter2Activity.webView,
                              arguments: {'url': 'https://github.com/Peroluo'});
                        }),
                  TextSpan(text: '点赞\n'),
                  TextSpan(
                      text:
                          '后续我会持续更新此项目，也会持续跟进luoGuoXiong的项目，由于本人没有api接口，只能用他的😀😁😂😃😄\n\n\n'),
                  TextSpan(text: '使用的库：'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildOtherApi() {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 5, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
            child: Text(
              'Dio',
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 18,
                  decoration: TextDecoration.underline),
              textAlign: TextAlign.left,
            ),
            onTap: () {
              Flutter2Activity.toActivity(Flutter2Activity.webView,
                  arguments: {'url': 'https://pub.flutter-io.cn/packages/dio'});
            },
          ),
          GestureDetector(
            child: Text(
              'webview_flutter',
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 18,
                  decoration: TextDecoration.underline),
              textAlign: TextAlign.left,
            ),
            onTap: () {
              Flutter2Activity.toActivity(Flutter2Activity.webView, arguments: {
                'url': 'https://pub.flutter-io.cn/packages/webview_flutter'
              });
            },
          ),
          GestureDetector(
            child: Text(
              'cached_network_image',
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 18,
                  decoration: TextDecoration.underline),
              textAlign: TextAlign.left,
            ),
            onTap: () {
              Flutter2Activity.toActivity(Flutter2Activity.webView, arguments: {
                'url': 'https://pub.flutter-io.cn/packages/cached_network_image'
              });
            },
          ),
          GestureDetector(
            child: Text(
              'flutter_swiper',
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 18,
                  decoration: TextDecoration.underline),
              textAlign: TextAlign.left,
            ),
            onTap: () {
              Flutter2Activity.toActivity(Flutter2Activity.webView, arguments: {
                'url': 'https://pub.flutter-io.cn/packages/flutter_swiper'
              });
            },
          ),
          GestureDetector(
            child: Text(
              'toast',
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 18,
                  decoration: TextDecoration.underline),
              textAlign: TextAlign.left,
            ),
            onTap: () {
              Flutter2Activity.toActivity(Flutter2Activity.webView, arguments: {
                'url': 'https://pub.flutter-io.cn/packages/toast'
              });
            },
          ),
          GestureDetector(
            child: Text(
              'flutter_html',
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 18,
                  decoration: TextDecoration.underline),
              textAlign: TextAlign.left,
            ),
            onTap: () {
              Flutter2Activity.toActivity(Flutter2Activity.webView, arguments: {
                'url': 'https://pub.flutter-io.cn/packages/flutter_html'
              });
            },
          ),
          GestureDetector(
            child: Text(
              'image_picker',
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 18,
                  decoration: TextDecoration.underline),
              textAlign: TextAlign.left,
            ),
            onTap: () {
              Flutter2Activity.toActivity(Flutter2Activity.webView, arguments: {
                'url': 'https://pub.flutter-io.cn/packages/image_picker'
              });
            },
          ),
          GestureDetector(
            child: Text(
              'common_utils',
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 18,
                  decoration: TextDecoration.underline),
              textAlign: TextAlign.left,
            ),
            onTap: () {
              Flutter2Activity.toActivity(Flutter2Activity.webView, arguments: {
                'url': 'https://pub.flutter-io.cn/packages/common_utils'
              });
            },
          ),
          GestureDetector(
            child: Text(
              'package_info',
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 18,
                  decoration: TextDecoration.underline),
              textAlign: TextAlign.left,
            ),
            onTap: () {
              Flutter2Activity.toActivity(Flutter2Activity.webView, arguments: {
                'url': 'https://pub.flutter-io.cn/packages/package_info'
              });
            },
          ),
        ],
      ),
    );
  }

  Widget buildTips() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            child: Text('简介'),
          ),
        ],
      ),
    );
  }
}
