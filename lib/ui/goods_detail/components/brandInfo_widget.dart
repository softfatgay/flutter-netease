import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/ui/goods_detail/model/goodDetail.dart';
import 'package:flutter_app/component/global.dart';

typedef void OnPress();

class BrandInfoWidget extends StatelessWidget {
  final BrandInfo? brandInfo;
  final OnPress? onPress;

  const BrandInfoWidget({Key? key, this.brandInfo, this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return brandInfo == null
        ? Container()
        : GestureDetector(
            child: Container(
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              color: backWhite,
              child: Row(
                textBaseline: TextBaseline.alphabetic,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 16,
                      ),
                      CachedNetworkImage(
                          height: 35, imageUrl: '${brandInfo!.picUrl}'),
                    brandInfo!.ownType == 2? CachedNetworkImage(
                          height: 12,
                          imageUrl:
                              'https://yanxuan.nosdn.127.net/9f91c012a7a42c776d785c09f6ed85b4.png'):Container(height: 16,),
                    ],
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child: Text(
                              '${brandInfo!.title}',
                              style: t16blackbold,
                            )),
                            arrowRightIcon
                          ],
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          '${brandInfo!.desc}',
                          style: t12black,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            onTap: () {
              if (onPress != null) {
                onPress!();
              }
            },
          );
  }
}
