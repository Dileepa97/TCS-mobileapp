import 'package:flutter/material.dart';

class DividerBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      child: Divider(
        thickness: 1,
      ),
    );
  }
}
