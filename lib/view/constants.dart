import 'package:flutter/material.dart';

inputDeco(Color color, TextEditingController controller) {
  return InputDecoration(
    suffixIcon: IconButton(
      onPressed: controller.clear,
      icon: Icon(
        Icons.backspace_outlined,
        color: Colors.black38,
        size: 20,
      ),
    ),
    hintText: 'hint Text',
    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(32.0)),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: color, width: 1.0),
      borderRadius: BorderRadius.all(Radius.circular(32.0)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: color, width: 2.0),
      borderRadius: BorderRadius.all(Radius.circular(32.0)),
    ),
  );
}

inputDecoForEdit(Color color, TextEditingController controller, String hintText,
    bool status) {
  return InputDecoration(
    suffixIcon: IconButton(
      onPressed: controller.clear,
      icon: Icon(
        Icons.backspace_outlined,
        color: Colors.black38,
        size: 20,
      ),
    ),
    enabled: !status,
    hintText: hintText,
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: color),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: color),
    ),
  );
}
