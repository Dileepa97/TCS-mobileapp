import 'package:flutter/material.dart';

import 'string_builder.dart';

class InputDate extends StatelessWidget {
  final String keyString;
  final DateTime date;
  final dynamic onTap;

  const InputDate({this.keyString, this.onTap, this.date});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            Icons.calendar_today,
            size: 20.0,
          ),
          Text(
            keyString,
            style: TextStyle(
              fontFamily: 'Source Sans Pro',
              fontSize: 15,
            ),
          ),
          Text(
            date == null
                ? 'Choose a Date'
                : '${Convert(date: date).stringDate()}',
            style: TextStyle(
              fontFamily: 'Source Sans Pro',
              fontSize: 15,
            ),
          ),
        ],
      ),
      onTap: onTap,
    );
  }
}
