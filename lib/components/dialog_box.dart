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
            "You have successfully registered to time capture system\nPlease check your email for confirmation link"),
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

void updateSuccessDialog(context) => showDialog(
      barrierColor: Colors.white70,
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Update Profile Success"),
        content: Text(
            "You have successfully updated your profile\nYou'll be logged out of the system and wont be able to login until an admin re-verify your account"),
        actions: [
          FlatButton(
            child: Text("OK"),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, LoginScreen.id);
            },
          )
        ],
      ),
    );
