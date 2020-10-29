import 'package:flutter/material.dart';
import 'package:timecapturesystem/view/auth/login_screen.dart';

void displayDialog(context, title, text) => showDialog(
      barrierColor: Colors.transparent,
      context: context,
      builder: (context) =>
          AlertDialog(title: Text(title), content: Text(text)),
    );

void displayRegSuccessDialog(context) => showDialog(
      barrierColor: Colors.white70,
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Registration Success"),
        content: Text(
            "You have successfully registered to time capture system\nPlease check your email for confirmation"),
        actions: [
          FlatButton(
            child: Text("OK"),
            onPressed: () {
              Navigator.popAndPushNamed(context, LoginScreen.id);
            },
          )
        ],
      ),
    );
