## [demo.apk下载地址](https://www.pgyer.com/QjBP)

#### 已更新-动态获取cookie。感谢 [Tdreamy](https://github.com/Tdreamy) 提供的思路以及对ios插件的支持

## 注意事项

1. 注意项目中使用的kotlin,androidx版本
2. 主分支的cookie和csrf_token容易过期，过期的话请自行在浏览器中打开网易严选登录，检查模式下查看，并拿到cookie（一般很长，有用的就两三个，在项目中user_config.dart文件中，自行替换）和csrf_token替换

## 深度还原网易严web-app，api全部来自严选

1. 新增购物车，我的界面等
2. 瀑布流
3. 地址操作
4. 实现商品属性等选择
5. 动态实现cookie获取
6. 基础模块已基本实现完毕，后续有时间会持续更新


## 主要功能点
- 项目中部分使用了序列化的方式，解析成大家比较直观的java Model类型
- 添加了flutter与安卓原生的交互
- 项目中使用了插件的方式与原生（android/ios）的交互，获取cookie
- 常见的安卓Material Design风格
- 视频播放(chewie,更改了源码,添加全屏标题返回键,双击手势等一些UI改动。已改版项目中没有使用到，代码在)
- 增加搜索功能(联想词),封装有StafulWidget的组件,带回调参数的,供大家参考(搜索框)
- 网络请求的封装
- stable分支增加网易严选web登录页面（过期和第一次登录），动态获取cookie
- 项目中接口全部使用了网易API接口数据,真实数据,请勿用于商业/恶意攻击等违法行为,否则后果自负
- 本项目纯属学习项目,切勿涉及违法行为
- 数据来之不易，如若有帮助，请帮忙点个👍


## 使用的第三方库
- [Flutter中文网](https://flutterchina.club/)
- [Dio](https://pub.flutter-io.cn/packages/dio)
- [webview_flutter](https://pub.flutter-io.cn/packages/webview_flutter)
- [cached_network_image](https://pub.flutter-io.cn/packages/cached_network_image)
- [flutter_swiper](https://pub.flutter-io.cn/packages/flutter_swiper)
- [Toast](https://pub.flutter-io.cn/packages/toast)
- [flutter_html](https://pub.flutter-io.cn/packages/flutter_html)
- [image_picker](https://pub.flutter-io.cn/packages/image_picker)
- [common_utils](https://pub.flutter-io.cn/packages/common_utils)
- [package_info](https://pub.flutter-io.cn/packages/package_info)



## 最后
谢谢大家

站在巨人的肩上才能看的更远,一起学习

我的邮箱 1137856139@qq.com
