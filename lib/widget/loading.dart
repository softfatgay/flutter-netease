import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Center(
        child: SizedBox(
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
          height: 24,
          width: 24,
        ),
      ),
    );
  }
}
