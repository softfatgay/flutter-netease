import 'package:flutter/material.dart';

// Color borderColor = Color.fromARGB(255, 0, 191, 255);
Color? borderColor = Colors.grey[200];

class Count extends StatelessWidget {
  Count({
    this.number,
    this.min,
    this.max,
    this.onChange,
  });

  final ValueChanged<int>? onChange;
  final int? number;
  final int? min;
  final int? max;

  final int a = 1;

  onClickBtn(String type) {
    if (type == 'remove' && number! > min!) {
      onChange!(number! - 1);
    } else if (type == 'add' && number! < max!) {
      onChange!(number! + 1);
    }
  }

// 相当于render
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: 150,
      decoration: BoxDecoration(
        border: Border.all(
          color: borderColor!,
        ),
        borderRadius: BorderRadius.circular(2)
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 35,
            color: this.min! >= this.number! ? Colors.grey[200] : Colors.white,
            child: InkResponse(
              child: Center(
                child: Icon(
                  Icons.remove,
                  color:
                      this.min! >= this.number! ? Colors.grey[500] : Colors.black,
                ),
              ),
              onTap: () {
                this.onClickBtn('remove');
              },
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(color: borderColor!),
                  right: BorderSide(color: borderColor!),
                ),
              ),
              child: Center(
                child: Text(
                  '${this.number}',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),
          Container(
            width: 35,
            color: this.max! <= this.number! ? Colors.grey[200] : Colors.white,
            child: InkResponse(
              child: Center(
                child: Icon(
                  Icons.add,
                  color:
                      this.max! <= this.number! ? Colors.grey[500] : Colors.black,
                ),
              ),
              onTap: () {
                this.onClickBtn('add');
              },
            ),
          ),
        ],
      ),
    );
  }
}
