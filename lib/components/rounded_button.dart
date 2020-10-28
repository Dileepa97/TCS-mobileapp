import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String title;
  final Function onPressed;
  final Color color;

  RoundedButton({this.title, this.onPressed, this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: this.color,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: this.onPressed,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            this.title,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

//() {
//Navigator.pushNamed(context, LoginScreen.id);
//}
