# FlutterWant

#### 注意事项:
>项目中使用了kotlin,androidx(编译一直提示没有使用androidx,强迫症就修改了),注意修改gradle文件。注意;项目中使用了与安卓原生的交互,必要的库(lifecycle)在yaml文件中有注释
## 注意：
   登陆的cookie和csrf_token容易过期，过期的话请自行在浏览器中打开网易严选登录，检查模式下查看，并拿到cookie（一般很长，有用的就两三个，在项目中user_config.dart文件中，自行替换）和csrf_token替换，最近在改版，没来得及开发完毕，大部分功能已实现
>
## [关于我](https://github.com/softfatgay)

## [demo.apk下载地址](https://www.pgyer.com/QjBP)


## 深度还原网易严选小程序端，api全部来自严选
    ▸全部界面重做
    ▸新增购物车，我的界面等
    ▸瀑布流
    ▸地址操作
    ▸实现商品属性等选择

>1.项目中使用了序列化的方式，解析成大家比较直观的java Model类型
>
>2.添加了flutter与安卓原生的交互，调用安卓activity，并为其传递参数
>
>3.为了方便大家理解，项目中一些重要的json文件都保存在相应文件夹下
>
>4.其中实现比较复杂的模块，使用了比较简单的形式实现
>
>5.其中部分模块实现安卓原生吸附的效果
>
>6.拍照/相册(我的界面，点击图像),弹出框等其他一些内容
>
>7.视频播放(chewie,更改了源码,添加全屏标题返回键,双击手势等一些UI改动)
>
>8.增加搜索功能(使用网易严选api),封装有StafulWidget的组件,带回调参数的,供大家参考(搜索框)
>
>9.富文本，以及富文本点击事件，跳转安卓原生Webview等其他一些功能
>
>10.项目中首页和分类使用了luoGuoXiong的接口,其他数据已经接入网易API,真是数据,有一部分抓不到,后续会再跟进
>
>11.添加登录模块,pageView实现上下翻页效果
>
>12.项目中详情/搜索/推荐等使用的是网易API接口数据,真实数据,请勿用于商业/恶意使用数据等违法行为,否则后果自负
>
>本项目纯属学习项目,切勿涉及违法行为

## 使用的第三方库
1. [Flutter中文网](https://flutterchina.club/) 
2. [Dio](https://pub.flutter-io.cn/packages/dio)
3. [webview_flutter](https://pub.flutter-io.cn/packages/webview_flutter)
4. [cached_network_image](https://pub.flutter-io.cn/packages/cached_network_image)
5. [flutter_swiper](https://pub.flutter-io.cn/packages/flutter_swiper) 
6. [Toast](https://pub.flutter-io.cn/packages/toast)
7. [flutter_html](https://pub.flutter-io.cn/packages/flutter_html)
8. [image_picker](https://pub.flutter-io.cn/packages/image_picker)
9. [common_utils](https://pub.flutter-io.cn/packages/common_utils)
10. [package_info](https://pub.flutter-io.cn/packages/package_info)



## 最后
*谢谢大家
>
*站在巨人的肩上才能看的更远,一起学习
>
*我的邮箱 1137856139@qq.com
