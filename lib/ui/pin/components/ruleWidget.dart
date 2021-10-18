import 'package:flutter/material.dart';
import 'package:flutter_app/component/global.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';

class RuleWidget extends StatelessWidget {
  const RuleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backWhite,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        children: [
          GestureDetector(
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    '免单团玩法',
                    style: t14black,
                  ),
                ),
                Text(
                  '详细规则',
                  style: t14grey,
                ),
                arrowRightIcon
              ],
            ),
            onTap: () {},
          ),
          SizedBox(height: 20),
          Image.asset('assets/images/pin_mian_rule.png'),
        ],
      ),
    );
  }
}
