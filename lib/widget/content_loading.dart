import 'package:flutter/material.dart';

class ContentLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: SizedBox(
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation(Colors.red),
          ),
          height: 24,
          width: 24,
        ),
      ),
    );
  }
}
