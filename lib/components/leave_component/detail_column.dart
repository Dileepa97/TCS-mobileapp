import 'package:flutter/material.dart';

class DetailColumn extends StatelessWidget {
  final String keyString;
  final String valueString;

  const DetailColumn({
    Key key,
    this.keyString,
    this.valueString,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '${this.keyString}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Source Sans Pro',
            fontSize: 17,
          ),
        ),
        SizedBox(height: 5),
        Text(
          '${this.valueString}',
          style: TextStyle(
            fontFamily: 'Source Sans Pro',
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
