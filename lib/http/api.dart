import 'package:dio/dio.dart';
import 'package:flutter_app/http/http.dart';
import 'package:flutter_app/utils/constans.dart';
import 'package:flutter_app/utils/util_mine.dart';

import '../entity_factory.dart';

///实体类转换需要用到用到FlutterJsonBeanFactory插件,之间转换json为实体类

var http = HttpUtils();

class Api {
  ///首页数据
  static Future getHomeData() async {
    return await http.get('/');
  }

  ///专题数据
  static Future getTopicData({int page, int size}) async {
    return await http.get('/topic/list', {'page': page, 'size': size});
  }

  static Future getHome([Map<String, dynamic> params]) async {
    return await http.get(Constans.homeData, params);
  }

  static Future getSort([Map<String, dynamic> params]) async {
    return await http.get(Constans.homeData, params);
  }

  // 获取分类页tabList
  static Future getSortTabs() async {
    return await http.get('/catalog/index');
  }

  // 获取所有商品的数量
  static Future getGoodsCount() async {
    return await http.get('/goods/count');
  }

  // 根据id获取某分类的商品
  static Future getCategoryMsg({int id}) async {
    return await http.get('/catalog/current', {'id': id});
  }

  //商品详情
  static Future getGoodMSG({int id, String token}) async {
    return await http.getToken('/goods/detail', token, {'id': id});
  }

  // 某制造商下的商品
  static Future getBrandGoods({int page, int size, int brandId}) async {
    return await http
        .get('/goods/list', {'page': page, 'size': size, 'brandId': brandId});
  }

  // 某制造商下的商品
  static Future<T> getBrandGoods1<T>({int page, int size, int brandId}) async {
    Response response = await http
        .get('/goods/list', {'page': page, 'size': size, 'brandId': brandId});
    return EntityFactory.generateOBJ<T>(Util.respone2Json(response));
  }

  // 某制造商的相关信息
  static Future getBrandMsg({int id}) async {
    return await http.get('/brand/detail', {'id': id});
  }

  // 某制造商的相关信息
  static Future<T> getBrandMsg1<T>({int id}) async {
    var response = await http.get('/brand/detail', {'id': id});
    return EntityFactory.generateOBJ<T>(Util.respone2Json(response));
  }

  // 获取子分类
  static Future getBrotherCatalog({int id}) async {
    return await http.get('/goods/category', {'id': id});
  }

  // 某分类的商品
  static Future getGoods({
    int page,
    int size,
    int categoryId,
  }) async {
    return await http.get(
        '/goods/list', {'page': page, 'size': size, 'categoryId': categoryId});
  }

  //获取专题详情
  static Future getTopicMsg({int id}) async {
   return await http.get('/topic/detail',{'id':id});
  }

  // 获取某专题的评论
  static Future getTopicComment({
    int valueId,
    int typeId,
    int page,
    int size,
  }) async {
    return await http.get('/comment/list',
        {'valueId': valueId, 'typeId': typeId, 'page': page, 'size': size});
  }

}
