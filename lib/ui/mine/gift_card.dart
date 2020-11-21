import 'package:flutter/material.dart';
import 'package:flutter_app/widget/app_bar.dart';
import 'package:flutter_app/widget/colors.dart';
import 'package:flutter_app/widget/tab_app_bar.dart';

///账户中没有礼品卡，暂时无法写详细页面
class GiftCard extends StatefulWidget {
  final Map arguments;

  const GiftCard({Key key, this.arguments}) : super(key: key);

  @override
  _GiftCardState createState() => _GiftCardState();
}

class _GiftCardState extends State<GiftCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: backColor,
      appBar: TabAppBar(
        title: '礼品卡',
      ).build(context),
      body: Column(
        children: [
          _buildCard(),
          Expanded(
            child: _noCard(),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, MediaQuery.of(context).padding.bottom),
            height: 60+MediaQuery.of(context).padding.bottom,
            color: Colors.white,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  border: Border.all(color: redColor, width: 1)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add,size: 16,color: textRed,),
                  Text('添加礼品卡',style: t16red,)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  _buildCard() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      color: redColor,
      width: double.infinity,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '礼品卡余额',
                  style: TextStyle(color: textWhite, fontSize: 14),
                ),
                Text(
                  '¥${widget.arguments['value']}',
                  style: TextStyle(color: textWhite, fontSize: 40),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 1),
                      borderRadius: BorderRadius.circular(4)),
                  child: Text(
                    '支付安全',
                    style: TextStyle(color: textWhite, fontSize: 14),
                  ),
                )
              ],
            ),
          ),
          Positioned(
              right: 15,
              child: Container(
                child: Row(
                  children: [
                    Text(
                      '交易记录',
                      style: t14white,
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 14,
                      color: Colors.white,
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }

  _noCard() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          color: Colors.white,
          child: Column(
            children: [
              Image.asset(
                'assets/images/no_gift_card.png',
                width: 100,
                height: 120,
                fit: BoxFit.fitWidth,
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  '去买张礼品卡充值吧',
                  style: t14grey,
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '了解详情',
                      style: t14grey,
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 14,
                      color: textGrey,
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
