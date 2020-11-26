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

void displayVerifySureDialog(context) => showDialog(
      barrierColor: Colors.white70,
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Are you sure to verify this user ?"),
        content: Text(
            "After user is verified he/she will be able to log into Time Capture System"),
        actions: [
          FlatButton(
            child: Text("Confirm"),
            onPressed: () {},
          ),
          FlatButton(
            child: Text("Cancel"),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );

void displayUnVerifySureDialog(context) => showDialog(
      barrierColor: Colors.white70,
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Are you sure to UN-VERIFY this user ?"),
        content: Text(
            "After user is un-verified he/she won't be able to log into Time Capture System"),
        actions: [
          FlatButton(
            child: Text("Confirm"),
            onPressed: () {},
          ),
          FlatButton(
            child: Text("Cancel"),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );

void displayUpliftToAdminSureDialog(context) => showDialog(
      barrierColor: Colors.white70,
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Are you sure ?"),
        content: Text("User will gain administrative access"),
        actions: [
          FlatButton(
            child: Text("Confirm"),
            onPressed: () {},
          ),
          FlatButton(
            child: Text("Cancel"),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );

void displayUpliftToTeamLeadSureDialog(context) => showDialog(
      barrierColor: Colors.white70,
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Are you sure ?"),
        content: Text("User will gain Team-Lead access"),
        actions: [
          FlatButton(
            child: Text("Confirm"),
            onPressed: () {},
          ),
          FlatButton(
            child: Text("Cancel"),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );

void displayDowngradeAdminSureDialog(context) => showDialog(
      barrierColor: Colors.white70,
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Are you sure ?"),
        content: Text("User will lose administrative access"),
        actions: [
          FlatButton(
            child: Text("Confirm"),
            onPressed: () {},
          ),
          FlatButton(
            child: Text("Cancel"),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );

void displayDowngradeTeamLeadSureDialog(context) => showDialog(
      barrierColor: Colors.white70,
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Are you sure ?"),
        content: Text("User will lose Team-Lead access"),
        actions: [
          FlatButton(
            child: Text("Confirm"),
            onPressed: () {},
          ),
          FlatButton(
            child: Text("Cancel"),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
