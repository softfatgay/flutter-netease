
class NetContants{

  ///评论
  static String commentList = 'xhr/comment/listByItemByTag.json';

  ///好评率
  static String commentPraise = 'xhr/comment/itemGoodRates.json';

  ///评价tags
  static String commentTags = 'xhr/comment/tags.json ';


///  https://m.you.163.com/item/cateList.json  分类
///  https://m.you.163.com/item/cateList.json?categoryId=109243029
///
///  https://m.you.163.com/item/list.json?categoryId=1005000   标签
///  https://m.you.163.com/xhr/item/detail.json    (post 详情下半部分数据 参数 id=1023014)
///  https://you.163.com/item/detail.json?id=1009012    商品详情上半部分数据
///  https://m.you.163.com/item/detail.json?id=1009012    (GET)商品详情上半部分数据
///  https://m.you.163.com/xhr/wapitem/hot.json?itemId=1027014   (post 这个接口中可以获得上述商品详情接口)
}