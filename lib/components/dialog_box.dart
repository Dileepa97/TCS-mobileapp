import 'package:flutter/material.dart';
import 'package:timecapturesystem/view/auth/login_screen.dart';

void displayDialog(context, title, text) => showDialog(
      barrierColor: Colors.black54,
      context: context,
      builder: (context) =>
          AlertDialog(title: Text(title), content: Text(text)),
    );

void displayRegSuccessDialog(context) => showDialog(
      barrierColor: Colors.black54,
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

Future<bool> displayConfirmationBox(context, content) => showDialog(
      barrierColor: Colors.black54,
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Are you sure ?"),
        content: Text(content),
        actions: [
          FlatButton(
            child: Text("Confirm"),
            onPressed: () {
              Navigator.pop(context);
              return true;
            },
          ),
          FlatButton(
            child: Text("Cancel"),
            onPressed: () {
              Navigator.pop(context);
              return true;
            },
          )
        ],
      ),
    );

Future<bool> displayVerifySureDialog(context) => displayConfirmationBox(context,
    "After user is verified he/she will be able to log into Time Capture System");

Future<bool> displayUnVerifySureDialog(context) => displayConfirmationBox(
    context,
    "After user is un-verified he/she won't be able to log into Time Capture System");

Future<bool> displayUpliftToAdminSureDialog(context) =>
    displayConfirmationBox(context, "User will gain administrative access");

Future<bool> displayUpliftToTeamLeadSureDialog(context) =>
    displayConfirmationBox(context, "User will gain Team-Lead access");

Future<bool> displayDowngradeAdminSureDialog(context) =>
    displayConfirmationBox(context, "User will lose administrative access");

Future<bool> displayDowngradeTeamLeadSureDialog(context) =>
    displayConfirmationBox(context, "User will lose Team-Lead access");

Future<bool> displayDeleteUserSureDialog(context) => displayConfirmationBox(
    context, "All the data that belongs to this user will be deleted forever");

controlButton(text, context) {
  return FlatButton(
    child: Text(text),
    onPressed: () {
      Navigator.pop(context);
    },
  );
}
