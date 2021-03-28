import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timecapturesystem/view/auth/login_screen.dart';

void displayDialog(context, title, text) => showDialog(
      barrierColor: Colors.black54,
      context: context,
      builder: (context) => (Platform.isAndroid
          ? AlertDialog(title: Text(title), content: Text(text))
          : CupertinoAlertDialog(
              title: Text(title + "\n"),
              content: Text(text),
            )),
    );

void displayRegSuccessDialog(context) => displayDialog(
    context,
    "Registration Success",
    "You have successfully registered to time capture system, please check your email for confirmation link");

void displayPWDResetSuccessDialog(context) => displayDialog(context, "Success",
    "You have successfully reset your password, now you can login with your new password");

void displayPWDChangedSuccessDialog(context) => showDialog(
      barrierColor: Colors.black54,
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Success"),
        content: Text("You have successfully changed your password"),
        actions: [
          FlatButton(
            child: Text("OK"),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
            },
          )
        ],
      ),
    );

void operationFailed(context) =>
    displayDialog(context, "Failed", "Failed to execute request, try again");

void updateSuccessDialog(context) => showDialog(
      barrierColor: Colors.black54,
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

//TODO:connect with buttons
//TODO:Refactor

//Admin_service dialogs
//TODO : test pass
Future<bool> displayConfirmationBox(context, content) async {
  bool confirm = false;
  await showDialog(
    barrierColor: Colors.black54,
    context: context,
    builder: (context) => (Platform.isAndroid
        ? AlertDialog(
            title: Text("Are you sure ?"),
            content: Text(content),
            actions: [
              FlatButton(
                color: Colors.blueAccent,
                child: Text("Confirm"),
                onPressed: () {
                  confirm = true;
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                color: Colors.redAccent,
                child: Text(
                  "Cancel",
// style: TextStyle(color: Colors.redAccent),
                ),
                onPressed: () {
                  confirm = false;
                  Navigator.pop(context);
                },
              )
            ],
          )
        //how it will display on iOS
        : CupertinoAlertDialog(
            title: Text("Are you sure ?\n"),
            content: Text(content),
            actions: [
              FlatButton(
                child: Text(
                  "Confirm",
                  style: TextStyle(color: Colors.blueAccent),
                ),
                onPressed: () {
                  confirm = true;
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                child: Text(
                  "Cancel",
                  style: TextStyle(color: Colors.redAccent),
                ),
                onPressed: () {
                  confirm = false;
                  Navigator.pop(context);
                },
              )
            ],
          )),
  );
  return confirm;
}

//Admin functions

Future<bool> handleVerifySureDialog(context, isVerified) {
  if (isVerified) {
    return displayConfirmationBox(context,
        "After user is un-verified he/she won't be able to log into Time Capture System");
  } else {
    return displayConfirmationBox(context,
        "After user is verified he/she will be able to log into Time Capture System");
  }
}

Future<bool> displayUpliftToAdminSureDialog(context) {
  return displayConfirmationBox(
      context, "User will gain administrative access");
}

Future<bool> displayUpliftToTeamLeadSureDialog(context) {
  return displayConfirmationBox(context, "User will gain Team-Lead access");
}

Future<bool> displayDowngradeAdminSureDialog(context) {
  return displayConfirmationBox(
      context, "User will lose administrative access");
}

Future<bool> displayDowngradeTeamLeadSureDialog(context) {
  return displayConfirmationBox(context, "User will lose Team-Lead access");
}

Future<bool> displayDeleteUserSureDialog(context) {
  return displayConfirmationBox(context,
      "All the data that belongs to this user will be deleted forever");
}

//Title Title Change Management

Future<bool> displayAddTitleSureDialog(context) {
  return displayConfirmationBox(context,
      "It will be displayed on registration screen and user profile update screen");
}

Future<bool> displayDeleteTitleSureDialog(context) {
  return displayConfirmationBox(context,
      "This will remove the selected title from users who have selected it as their title");
}

Future<bool> displayChangeTitleSureDialog(context) {
  return displayConfirmationBox(context,
      "This will change the title of users who have already been assigned to this title");
}

Future<bool> displayUpdateDialog(context) {
  return displayConfirmationBox(
      context,
      "Since your're updating profile you'll get un-verified, "
      "Hence an admin must verify your account for you to log back into the system again");
}
