import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/ui/router/router.dart';

class OpenVipWidget extends StatelessWidget {
  const OpenVipWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage('assets/images/vip_back.png'),
            ),
            borderRadius: BorderRadius.circular(8)),
        child: Row(
          children: [
            Image.asset(
              'assets/images/vip_gift_icon.png',
              height: 28,
            ),
            SizedBox(width: 5),
            Expanded(
              child: Text(
                '开通Pro会员享16大权益',
                style: TextStyle(fontSize: 12, color: Color(0xFFF1E0BC)),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                  color: Color(0xFFF1E0BC),
                  borderRadius: BorderRadius.circular(10)),
              child: Text(
                '立即开通',
                style: TextStyle(fontSize: 12, height: 1.1, color: textBlack),
              ),
            )
          ],
        ),
      ),
      onTap: () {
        Routers.push(Routers.webView, context,
            {'url': 'https://m.you.163.com/supermc/index'});
      },
    );
  }
}
