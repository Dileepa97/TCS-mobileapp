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
        // Text(
        //   keyString + ' : ',
        //   style: TextStyle(
        //     fontSize: 14,
        //     fontWeight: FontWeight.w600,
        //   ),
        // ),
        DropdownButton<String>(
          value: item,
          hint: Text(
            keyString,
            style: TextStyle(
              fontSize: 14,
              color: Colors.blue[700],
            ),
          ),
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: Colors.blue[700],
          ),
          iconSize: 20,
          // elevation: 16,
          underline: Container(
            // height: 4,
            color: Colors.white,
          ),
          onChanged: onChanged,
          items: items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value.substring(0, 1) +
                    value.substring(1).toLowerCase().replaceAll('_', '\n'),
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.blue[700],
                  fontSize: 18,
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
