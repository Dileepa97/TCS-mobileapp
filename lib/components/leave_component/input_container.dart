import 'package:flutter/material.dart';

class InputContainer extends StatelessWidget {
  final Widget child;
  final double height;
  InputContainer({this.child, this.height});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.lightBlue[50],
      ),
      child: child,
    );
  }
}
