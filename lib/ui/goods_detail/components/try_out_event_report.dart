import 'package:flutter/material.dart';
import 'package:flutter_app/component/round_net_image.dart';
import 'package:flutter_app/component/star_widget.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:flutter_app/constant/fonts.dart';
import 'package:flutter_app/ui/goods_detail/model/goodDetail.dart';
// import 'package:flutter_html/flutter_html.dart';
// import 'package:html/parser.dart';

class TryOutEventReportWidget extends StatelessWidget {
  final TryOutEventReport? tryOutEventReport;

  const TryOutEventReportWidget({Key? key, this.tryOutEventReport})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (tryOutEventReport == null) {
      return Container();
    }
    return Column(
      children: [
        _buildIssueTitle(' 甄选家评测 ', null),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            children: [
              _account(),
              SizedBox(height: 10),
              _start(),
              SizedBox(height: 20),
              Container(
                height: 0.5,
                color: Colors.black12,
              ),
              SizedBox(height: 20),
              Text('${tryOutEventReport!.title}'),
              // Html(data: tryOutEventReport!.detail!.reportDetail!),
            ],
          ),
        )
      ],
    );
  }

  _account() {
    return Row(
      children: [
        RoundNetImage(
          url: tryOutEventReport!.avatar ?? '',
          height: 25,
          width: 25,
          corner: 15,
          fontSize: 10,
        ),
        SizedBox(
          width: 10,
        ),
        Text('${tryOutEventReport!.nickName}'),
        SizedBox(
          width: 10,
        ),
        Text(
          '${tryOutEventReport!.job}',
          style: t12grey,
        ),
      ],
    );
  }

  _start() {
    return Row(
      children: [
        Text(
          '评  分：',
          style: t12grey,
        ),
        Container(
          child: StaticRatingBar(
            size: 15,
            rate: (tryOutEventReport!.score! / 100) * 100,
          ),
        ),
      ],
    );
  }

  _buildIssueTitle(String title, GlobalKey? key) {
    return Container(
      key: key,
      decoration: BoxDecoration(color: Colors.white),
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _titleLine(),
          Text(
            '$title',
            style: TextStyle(
              color: textBlack,
              fontSize: 16,
              height: 1,
            ),
          ),
          _titleLine(),
        ],
      ),
    );
  }

  _titleLine() {
    return Container(
      width: 20,
      color: lineColor,
      height: 1,
    );
  }
}
