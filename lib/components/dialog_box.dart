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
              Navigator.pop(context);
            },
          )
        ],
      ),
    );

void displayPWDResetSuccessDialog(context) => showDialog(
      barrierColor: Colors.black54,
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Success"),
        content: Text(
            "You have successfully reset your password, now you can login with your new password"),
        actions: [
          FlatButton(
            child: Text("OK"),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
          )
        ],
      ),
    );

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
    builder: (context) => AlertDialog(
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
    ),
  );

  return confirm;
}

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
