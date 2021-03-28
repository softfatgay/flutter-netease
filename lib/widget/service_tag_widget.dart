import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';

class ServiceTagWidget extends StatelessWidget {
  List tags = ['30天无忧退货', '48小时快速退货', '满99免邮费'];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: tags.map((e) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                Container(
                  width: 4,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white,
                   borderRadius: BorderRadius.circular(2),
                  border: Border.all(color: textLightGrey,width: 1)),
                ),
                SizedBox(width: 3),
                Text(
                  '$e',
                  style: t12black,
                )
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
