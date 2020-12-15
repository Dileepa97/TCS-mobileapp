import 'package:flutter/material.dart';
import 'package:timecapturesystem/components/rounded_button.dart';

class TwoButtonRow extends StatelessWidget {
  final String title1;
  final String title2;
  final Function onPressed1;
  final Function onPressed2;

  const TwoButtonRow(
      {Key key, this.title1, this.title2, this.onPressed1, this.onPressed2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        RoundedButton(
          color: Colors.lightGreen,
          title: '${this.title1}',
          minWidth: 100.0,
          onPressed: this.onPressed1,
        ),
        RoundedButton(
          color: Colors.red[300],
          title: '${this.title2}',
          minWidth: 100,
          onPressed: this.onPressed2,
        ),
      ],
    );
  }
}
