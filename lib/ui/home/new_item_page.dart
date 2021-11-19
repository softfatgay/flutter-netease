import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/component/app_bar.dart';
import 'package:flutter_app/component/img_error.dart';
import 'package:flutter_app/component/img_palceholder.dart';
import 'package:flutter_app/component/loading.dart';
import 'package:flutter_app/component/round_net_image.dart';
import 'package:flutter_app/component/slivers.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/http_manager/api.dart';
import 'package:flutter_app/model/itemListItem.dart';
import 'package:flutter_app/ui/component/model/normalSearchModel.dart';
import 'package:flutter_app/ui/component/normal_conditions.dart';
import 'package:flutter_app/ui/component/sliverAppBarDelegate.dart';
import 'package:flutter_app/ui/home/model/newItemsDataModel.dart';
import 'package:flutter_app/ui/home/model/preNewItem.dart';
import 'package:flutter_app/ui/router/router.dart';
import 'package:flutter_app/ui/sort/component/good_items.dart';
import 'package:flutter_app/utils/renderBoxUtil.dart';

class NewItemPage extends StatefulWidget {
  final Map? params;

  const NewItemPage({Key? key, this.params}) : super(key: key);

  @override
  _KingKongPageState createState() => _KingKongPageState();
}

class _KingKongPageState extends State<NewItemPage> {
  bool _initLoading = true;
  List<ItemListItem> _editorRecommendItems = [];

  ///全部新品
  List<ItemListItem> _itemList = [];

  ///新品预告
  List<PreNewItem> _preItemList = [];

  ///众筹
  List<ZcItems> _zcItems = [];
  late NewItems _newItems;

  final _scrollController = ScrollController();

  var _searchModel = NormalSearchModel(index: 0, descSorted: true);

  final _key1 = GlobalKey();
  var _key1Height = 0.0;

  bool _isPinned = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(_scrollListener);
    _getInitData(0);
  }

  void _scrollListener() {
    var position = _scrollController.position;
    if (position.pixels > _key1Height) {
      if (_isPinned) {
        setState(() {
          _isPinned = false;
        });
      }
    }
  }

  void _preNewItem() async {
    var responseData = await preNewItem();
    if (mounted) {
      if (responseData.code == '200') {
        List data = responseData.data;
        List<PreNewItem> preItemList = [];
        data.forEach((element) {
          preItemList.add(PreNewItem.fromJson(element));
        });
        setState(() {
          _preItemList = preItemList;
        });
        _key1Height = RenderBoxUtil.offsetY(context, _key1);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backWhite,
      appBar: TopAppBar(
        title: '新品首发',
      ).build(context),
      body: _initLoading ? Loading() : _buildBody(),
    );
  }

  _buildBody() {
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        if (_editorRecommendItems.isNotEmpty) _buildRCMD(),
        if (_editorRecommendItems.isNotEmpty) _RECDGrid(),
        singleSliverWidget(_line()),
        singleSliverWidget(_tipsTitle('全部新品')),
        _buildStickyBar(),
        GoodItems(dataList: _itemList),
        _zcItemsWidget(),
        singleSliverWidget(_tipsTitle('新品预告')),
        singleSliverWidget(Container(key: _key1)),
        _priItems(),
      ],
    );
  }

  Widget _buildStickyBar() {
    return SliverPersistentHeader(
      pinned: true, //是否固定在顶部
      floating: true,
      delegate: SliverAppBarDelegate(
        minHeight: 50, //收起的高度
        maxHeight: 50, //展开的最大高度
        child: Container(
          child: NormalConditionsBar(
            height: 50,
            pressChange: (searchModel) {
              _resetPage(searchModel!);
            },
          ),
        ),
      ),
    );
  }

  void _resetPage(NormalSearchModel searchModel) {
    _searchModel = searchModel;
    _getInitData(1);
  }

  _line() {
    return Container(
      height: 10,
      color: backColor,
    );
  }

  _RECDGrid() {
    _editorRecommendItems.removeAt(0);
    List<ItemListItem> gride = _editorRecommendItems;
    if (gride.length > 0) {
      gride.removeAt(0);
    }
    return GoodItems(
      dataList: gride,
    );
  }

  void _getInitData(int type) async {
    Map<String, dynamic> params = {
      'sortType': _searchModel.sortType,
      'descSorted': _searchModel.descSorted ?? false,
      'categoryL1Id': 0,
      'tagId': 0,
    };
    var responseData = await kingKongNewItemData(params);
    if (responseData.OData != null) {
      if (type == 0) {
        setState(() {
          var newItemsDataModel =
              NewItemsDataModel.fromJson(responseData.OData);
          _editorRecommendItems = newItemsDataModel.editorRecommendItems ?? [];
          _newItems = newItemsDataModel.newItems ?? NewItems();
          _itemList = _newItems.itemList ?? [];
          _zcItems = newItemsDataModel.zcItems ?? [];
          _initLoading = false;
        });
        _preNewItem();
      } else {
        var newItemsDataModel = NewItemsDataModel.fromJson(responseData.OData);
        var newItems = newItemsDataModel.newItems ?? NewItems();
        var list = newItems.itemList ?? [];
        if (list.isNotEmpty) {
          setState(() {
            _itemList = newItems.itemList ?? [];
          });
        }
      }
    }
  }

  _buildRCMD() {
    return singleSliverWidget(Column(
      children: [
        _tipsTitle('推荐关注'),
        _No1Item(),
      ],
    ));
  }

  _tipsTitle(String title) {
    return Container(
      decoration: BoxDecoration(
          color: backWhite,
          border: Border(bottom: BorderSide(color: lineColor, width: 1))),
      width: double.infinity,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Text(
        '$title',
        style: t15black,
      ),
    );
  }

  _No1Item() {
    var item = _editorRecommendItems[0];
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
            color: backWhite,
            border: Border.all(color: lineColor, width: 1),
            borderRadius: BorderRadius.circular(2)),
        child: Row(
          children: [
            RoundNetImage(
              url: '${item.listPicUrl}',
              corner: 2,
              width: MediaQuery.of(context).size.width / 3,
              height: MediaQuery.of(context).size.width / 3,
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${item.simpleDesc}',
                      style: t14grey,
                    ),
                    SizedBox(height: 5),
                    Text(
                      '${item.name}',
                      style: t16black,
                    ),
                    SizedBox(height: 5),
                    Text(
                      '¥${item.sortOriginPrice}',
                      style: t16red,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        Routers.push(Routers.goodDetail, context, {'id': item.id});
      },
    );
  }

  _zcItemsWidget() {
    return singleSliverWidget(Column(
      children: _zcItems.map((e) => _zcItemWidget(e)).toList(),
    ));
  }

  Widget _zcItemWidget(ZcItems item) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          RoundNetImage(
            url: '${item.picUrl}',
            width: MediaQuery.of(context).size.width / 3,
            height: MediaQuery.of(context).size.width / 3,
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${item.name}',
                    style: t14black,
                  ),
                  Row(
                    textBaseline: TextBaseline.alphabetic,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    children: [
                      Text(
                        '¥',
                        style: t12Orange,
                      ),
                      Text(
                        '${item.minPrice}',
                        style: t20Orange,
                      ),
                      Text(
                        '起',
                        style: t10Orange,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: LinearProgressIndicator(
                            color: textOrange,
                            minHeight: 10,
                            backgroundColor: Colors.grey,
                            value: _progressValue(item.actualAmountPercent),
                          ),
                        ),
                      ),
                      Text(
                        '${item.actualAmountPercent!.toStringAsFixed(0)}%',
                        style: t14Orange,
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _progressValue(num? value) {
    if (value! > 100) {
      return 1.0;
    } else {
      return value / 100;
    }
  }

  _priItems() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
          Widget widget = Container(
            width: double.infinity,
            decoration: BoxDecoration(color: Colors.transparent),
            child: _preItem(_preItemList[index]),
          );
          return GestureDetector(
            child: widget,
            onTap: () {
              Routers.push(
                  Routers.goodDetail, context, {'id': _preItemList[index].id});
            },
          );
        }, childCount: _preItemList.length),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.6,
            mainAxisSpacing: 10,
            crossAxisSpacing: marginS),
      ),
    );
  }

  Widget _preItem(PreNewItem item) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.width / 2,
            width: double.infinity,
            child: _netImg('${item.listPicUrl}'),
          ),
          Text(
            '${item.name}',
            style: t14blackBold,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 1, horizontal: 3),
            decoration: BoxDecoration(
              border: Border.all(color: textLightGrey, width: 0.5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              '即将上架',
              style: TextStyle(fontSize: 11, color: textBlack, height: 1.1),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                '¥',
                style: t12red,
              ),
              Text(
                '${item.retailPrice}',
                style: t20redBold,
              ),
            ],
          )
        ],
      ),
    );
  }

  _netImg(String url) {
    return Container(
      decoration: BoxDecoration(
          color: backColor, borderRadius: BorderRadius.circular(8)),
      child: CachedNetworkImage(
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
          ),
        ),
        imageUrl: '$url',
        errorWidget: (context, url, error) {
          return ImgError();
        },
        placeholder: (context, url) {
          return ImgPlaceHolder();
        },
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    super.dispose();
  }
}
