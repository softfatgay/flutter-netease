import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/ui/goods_detail/model/goodDetail.dart';
import 'package:flutter_app/ui/goods_detail/model/skuMapValue.dart';

fullRefundPolicyDialog(
    BuildContext context, FullRefundPolicy fullRefundPolicy) {
  //底部弹出框,背景圆角的话,要设置全透明,不然会有默认你的白色背景
  if (fullRefundPolicy == null) {
    return;
  }
  String title = fullRefundPolicy.detailTitle;
  List<String> content = fullRefundPolicy.content;
  return showModalBottomSheet(
    //设置true,不会造成底部溢出
    isScrollControlled: true,
    context: context,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return Container(
        width: double.infinity,
        constraints: BoxConstraints(maxHeight: 500),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(5.0),
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                child: Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Center(
                        child: Text(
                          '$title',
                          style: t18black,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      child: Container(
                        child: Center(
                          child: InkResponse(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              child: Icon(
                                Icons.close,
                                color: redColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: 1,
                width: double.infinity,
                color: lineColor,
              ),
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  children: content.map<Widget>((item) {
                    return Container(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        item,
                        style: t14grey,
                      ),
                    );
                  }).toList(),
                ),
              ))
            ],
          ),
        ),
      );
    },
  );
}

buildSkuFreightDialog(
    BuildContext context, String title, List<PolicyListItem> contentList) {
  //底部弹出框,背景圆角的话,要设置全透明,不然会有默认你的白色背景
  return showModalBottomSheet(
    //设置true,不会造成底部溢出
    isScrollControlled: true,
    context: context,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return Container(
        constraints: BoxConstraints(maxHeight: 500),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(5.0),
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                child: Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Center(
                        child: Text(
                          '$title',
                          style: t18black,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      child: InkResponse(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Icon(
                            Icons.close,
                            color: redColor,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: 1,
                width: double.infinity,
                color: lineColor,
              ),
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: contentList
                      .map<Widget>((item) => Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(top: 10, bottom: 3),
                                child: Text(
                                  item.title,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                              ),
                              Container(
                                child: Text(
                                  item.content,
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 14),
                                ),
                              )
                            ],
                          ))
                      .toList(),
                ),
              ))
            ],
          ),
        ),
      );
    },
  );
}
