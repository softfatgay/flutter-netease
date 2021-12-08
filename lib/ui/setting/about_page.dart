import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/component/app_bar.dart';
import 'package:flutter_app/component/slivers.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/ui/router/router.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopAppBar(
        title: '关于',
      ).build(context),
      body: CustomScrollView(
        slivers: <Widget>[
          singleSliverWidget(buildRichText()),
          singleSliverWidget(_buildOtherApi()),
          singleSliverWidget(_email()),
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
          GestureDetector(
            child: Container(
              margin: EdgeInsets.only(top: 15),
              padding: EdgeInsets.only(left: 15),
              child: Text(
                'Demo.apk下载地址',
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline),
                textAlign: TextAlign.left,
              ),
            ),
            onTap: () {
              _launchURL('http://d.firim.top/7c8n');
            },
          ),
          Container(
            padding: EdgeInsets.all(15),
            child: RichText(
              text: TextSpan(
                style: TextStyle(color: Colors.black87, fontSize: 14),
                children: [
                  TextSpan(text: '项目地址:  ', style: t16blackBold),
                  TextSpan(
                      text: '项目地址\n\n',
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          _goWebview(
                              'https://github.com/softfatgay/flutter-netease');
                        }),
                  TextSpan(text: '关于:          ', style: t16blackBold),
                  TextSpan(
                      text: '我',
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          _goWebview('https://github.com/softfatgay');
                        })
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('深度还原网易严选webApp', style: t20blackBold),
                SizedBox(height: 10),
                _desApp('已实现登录功能，动态获取cookie。感谢 Tdreamy 提供的思路以及对ios插件的支持'),
                _desApp('首页，值得买，分类，购物车，我的，搜索，商品详情等等，都已实现（除了下单之后的逻辑）'),
                _desApp('升级到null-safety'),
                _desApp('后续有时间会持续完善此项目'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _desApp(String des) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('• ', style: t20blackBold),
          Expanded(
            child: Text('$des', style: t16black),
          ),
        ],
      ),
    );
  }

  _buildOtherApi() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('使用的一些三方库', style: t20blackBold),
          SizedBox(height: 10),
          _buildLink('dio', 'https://pub.flutter-io.cn/packages/dio'),
          _buildLink('webview_flutter',
              'https://pub.flutter-io.cn/packages/webview_flutter'),
          _buildLink('cached_network_image',
              'https://pub.flutter-io.cn/packages/cached_network_image'),
          _buildLink('carousel_slider',
              'https://pub.flutter-io.cn/packages/carousel_slider'),
          _buildLink('flutter_html',
              'https://pub.flutter-io.cn/packages/flutter_html'),
          _buildLink('flutter_staggered_grid_view',
              'https://pub.flutter-io.cn/packages/flutter_staggered_grid_view'),
          _buildLink('common_utils ',
              'https://pub.flutter-io.cn/packages/common_utils'),
          Text('...等', style: t16black),
        ],
      ),
    );
  }

  _buildLink(String name, String url) {
    return GestureDetector(
      child: Text(
        '$name',
        style: TextStyle(
            color: Colors.blue,
            fontSize: 18,
            decoration: TextDecoration.underline),
        textAlign: TextAlign.left,
      ),
      onTap: () {
        _goWebview(url);
      },
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

  _launchURL(apkUrl) async {
    if (await canLaunch(apkUrl)) {
      await launch(apkUrl);
    } else {
      throw 'Could not launch $apkUrl';
    }
  }

  Widget _email() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '我的邮箱',
            style: t20blackBold,
          ),
          GestureDetector(
            child: Container(
              decoration: BoxDecoration(
                  border:
                      Border(bottom: BorderSide(color: Colors.blue, width: 1))),
              child: Text(
                'wan_tuan@163.com',
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    height: 2),
                textAlign: TextAlign.left,
              ),
            ),
            onTap: () async {
              var url = 'mailto:wan_tuan@163.com?subject=flutter-netease';
              if (await canLaunch(url)) {
                _launchURL(url);
              }
            },
          )
        ],
      ),
    );
  }

  _goWebview(String url) {
    Routers.push(Routers.webView, context, {'url': url});
  }
}
