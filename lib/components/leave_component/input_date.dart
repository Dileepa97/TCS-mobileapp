import 'package:flutter/material.dart';

import 'convert.dart';

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
            //color: Colors.blueAccent,
          ),
          Text(keyString),
          Text(
            date == null
                ? 'Choose a Date'
                : '${Convert(date: date).stringDate()}',
          ),
        ],
      ),
      onTap: onTap,
    );
  }
}
