import 'package:flutter/material.dart';

class CustomDropDown extends StatelessWidget {
  final String keyString;
  final dynamic item;
  final dynamic items;
  final dynamic onChanged;

  const CustomDropDown({this.keyString, this.item, this.items, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          keyString + ' : ',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        DropdownButton<String>(
          value: item,
          hint: Text(keyString),
          icon: Icon(Icons.keyboard_arrow_down),
          iconSize: 24,
          elevation: 16,
          underline: Container(
            height: 2,
            color: Colors.black54,
          ),
          onChanged: onChanged,
          items: items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ],
    );
  }
}
