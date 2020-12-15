import 'package:flutter/material.dart';

class ShowAlertDialog {
  Future<void> showAlertDialog(
          {String title,
          String body,
          Color color,
          Function onPressed,
          @required BuildContext context}) async =>
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) => AlertDialog(
          title: Text('$title', style: TextStyle(color: color)),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('$body ', style: TextStyle(color: color)),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok', style: TextStyle(color: color)),
              onPressed: onPressed,
            ),
          ],
        ),
      );

  Future<void> showConfirmationDialog(
      {String title,
      List<Widget> children,
      Function onPressedYes,
      Function onPressedNo,
      BuildContext context}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: children,
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Yes',
                style: TextStyle(color: Colors.blueAccent),
              ),
              onPressed: onPressedYes,
            ),
            FlatButton(
              child: Text(
                'No',
                style: TextStyle(color: Colors.redAccent),
              ),
              onPressed: onPressedNo,
            ),
          ],
        );
      },
    );
  }
}
