import 'package:flutter/material.dart';

typedef void OnTap(int index);

class FlowWidget<String> extends StatefulWidget {
  final List<String> items;
  final Color checkedColor;
  final Color unCheckColor;
  final String checkedItem;
  final OnTap onTap;
  final int showItemCount;
  final double spacing;
  final double runSpacing;

  FlowWidget({this.items, this.checkedColor = Colors.red, this.unCheckColor = Colors.grey, this.checkedItem, this.onTap,this.spacing = 10,this.runSpacing = 10,
    this.showItemCount});

  @override
  _FlowWidgetState createState() => _FlowWidgetState();
}

class _FlowWidgetState extends State<FlowWidget> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: widget.spacing,
      runSpacing: widget.runSpacing,
      children: buildItem(),
    );
  }

  List<Widget> buildItem() {
    return List.generate(widget.showItemCount == null?widget.items.length:widget.showItemCount, (index) {
      Color checkColor =
          widget.checkedItem == widget.items[index] ? widget.checkedColor : widget.unCheckColor;
      return GestureDetector(
        child: Container(
          padding: EdgeInsets.fromLTRB(8, 5, 8, 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(2)),
              border: Border.all(width: 0.5, color: checkColor)),
          child: Text(
            '${widget.items[index]}',
            style: TextStyle(color: checkColor),
          ),
        ),
        onTap: () {
          widget.onTap(index);
        },
      );
    });
  }
}
