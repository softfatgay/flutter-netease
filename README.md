## [demo.apk下载地址](https://www.pgyer.com/QjBP)

#### 已实现登录功能，动态获取cookie。感谢 [Tdreamy](https://github.com/Tdreamy) 提供的思路以及对ios插件的支持

## 注意事项

1. 注意项目中使用的kotlin,androidx版本
2. cookie和csrf_token已实现动态更新，网页登录即可

## 深度还原网易严选web-app

1. 首页，值得买，分类，购物车，我的，搜索，商品详情等等，都已实现（除了下单之后的逻辑）
2. 登录功能已实现

## Screenshots

|         首页         |        分类         |         值得买         |         购物车         |
| :------------------: | :-------------------: | :----------------------: | :----------------------: |
| ![](./screenShot/wechatimg95.jpeg) | ![](./screenShot/wechatimg93.jpeg) | ![](./screenShot/wechatimg94.jpeg) | ![](./screenShot/wechatimg89.jpeg) |

|         个人          |        商品详情        |         添加购物车        |          评论           |
| :-------------------: | :-------------------------: | :----------------------------: | :-------------------------: |
| ![](./screenShot/wechatimg87.jpeg) | ![](./screenShot/wechatimg92.jpeg) | ![](./screenShot/WechatIMG91.jpeg) | ![](./screenShot/wechatimg98.jpeg) |


## 主要功能点
- 网络请求的封装，数据返回请求解析成model模型
- flutter与原生的交互
- 已实现登录功能，网页登录，从原生的CookieManager中获取cookie
- 常见的安卓Material Design风格
- 组件封装（搜索功能(联想词)带回调函数等）供参考
- 项目中数据都是动态接口，全部使用了网易API接口数据,请勿用于商业/恶意攻击等违法行为,否则后果自负
- 本项目纯属学习项目,切勿涉及违法行为
- 数据来之不易，如若有帮助，请帮忙点个👍


## 使用的第三方库
- [Flutter中文网](https://flutterchina.club/)
- [Dio](https://pub.flutter-io.cn/packages/dio)
- [json_annotation](https://pub.flutter-io.cn/packages/json_annotation)
- [webview_flutter](https://pub.flutter-io.cn/packages/webview_flutter)
- [cached_network_image](https://pub.flutter-io.cn/packages/cached_network_image)
- [flutter_swiper](https://pub.flutter-io.cn/packages/flutter_swiper)
- [flutter_html](https://pub.flutter-io.cn/packages/flutter_html)
- [common_utils](https://pub.flutter-io.cn/packages/common_utils)
- 等


## 最后
谢谢大家

站在巨人的肩上才能看的更远

我的邮箱 1137856139@qq.com
