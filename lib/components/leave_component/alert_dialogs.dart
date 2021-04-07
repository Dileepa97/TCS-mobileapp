import 'package:flutter/material.dart';

class ShowAlertDialog {
  ///alert dialog
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
          ///title text
          title: Text(
            '$title',
            style: TextStyle(
              color: color,
              fontSize: 18,
              fontFamily: 'Source Sans Pro',
            ),
          ),

          ///dialog text
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  '$body ',
                  style: TextStyle(
                    fontWeight: FontWeight.w100,
                    color: color,
                    // fontSize: 17,
                    // fontFamily: 'Source Sans Pro',
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          ///dialog button action
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Ok',
                style: TextStyle(
                  color: color,
                  fontSize: 16,
                  fontFamily: 'Source Sans Pro',
                ),
              ),
              onPressed: onPressed,
            ),
          ],
        ),
      );

  ///confirmation dialog
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
          ///title text
          title: Text(
            '$title',
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'Source Sans Pro',
            ),
          ),

          ///body
          content: SingleChildScrollView(
            child: ListBody(
              children: children,
            ),
          ),

          ///buttons
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Yes',
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontFamily: 'Source Sans Pro',
                  fontSize: 18,
                ),
              ),
              onPressed: onPressedYes,
            ),
            FlatButton(
              child: Text(
                'No',
                style: TextStyle(
                  color: Colors.redAccent,
                  fontFamily: 'Source Sans Pro',
                  fontSize: 18,
                ),
              ),
              onPressed: onPressedNo,
            ),
          ],
        );
      },
    );
  }
}
