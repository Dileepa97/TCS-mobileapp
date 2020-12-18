import 'package:flutter/material.dart';

class InputTextField extends StatelessWidget {
  final String labelText;
  final dynamic onChanged;
  final int maxLines;

  InputTextField({this.labelText, this.onChanged, this.maxLines});

  @override
  Widget build(BuildContext context) {
    return TextField(
      autocorrect: true,
      maxLines: maxLines,
      textCapitalization: TextCapitalization.sentences,
      //textInputAction: TextInputAction.continueAction,
      decoration: InputDecoration(
        //hintText: 'Leave Title',
        border: InputBorder.none,
        labelText: labelText,
      ),
      onChanged: onChanged,
    );
  }
}
