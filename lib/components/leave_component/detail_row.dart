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
            fontFamily: 'Source Sans Pro',
            fontSize: 16,
          ),
        ),
        Text(
          '${this.valueString}',
          style: TextStyle(
            fontFamily: 'Source Sans Pro',
            fontSize: 17,
          ),
        )
      ],
    );
  }
}
