import 'package:flutter/material.dart';

class DetailRow extends StatelessWidget {
  final String keyString;
  final String valueString;

  const DetailRow({Key key, this.keyString, this.valueString})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '${this.keyString} : ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        Text(
          '${this.valueString}',
          style: TextStyle(
            fontSize: 16,
          ),
        )
      ],
    );
  }
}
