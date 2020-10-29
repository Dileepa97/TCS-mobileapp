import 'package:flutter/material.dart';

void displayDialog(context, title, text) => showDialog(
      barrierColor: Colors.transparent,
      context: context,
      builder: (context) =>
          AlertDialog(title: Text(title), content: Text(text)),
    );
