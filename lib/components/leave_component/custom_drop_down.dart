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
        DropdownButton<String>(
          value: item,
          // isExpanded: true,
          // itemHeight: 10,

          ///hint text
          hint: Text(
            keyString,
            style: TextStyle(
              fontSize: 15,
              color: Colors.blue[700],
              fontFamily: 'Source Sans Pro',
            ),
          ),

          ///button icon
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: Colors.blue[700],
          ),
          iconSize: 20,

          ///underline
          underline: Container(
            color: Colors.white,
          ),

          ///onchange
          onChanged: onChanged,

          ///drop down lists
          items: items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value.substring(0, 1) +
                    value
                        .substring(1)
                        .toLowerCase()
                        .replaceFirst('_', '\n')
                        .replaceFirst('_', ' '),
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.blue[700],
                  fontSize: 17,
                  fontFamily: 'Source Sans Pro',
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
