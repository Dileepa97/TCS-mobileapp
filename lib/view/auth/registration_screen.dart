import 'package:flutter/material.dart';
import 'package:timecapturesystem/components/rounded_button.dart';

import '../constants.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = "registration_screen";

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  static const double spaceBetweenFields = 16.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            SizedBox(
              height: 48.0,
            ),
            Hero(
              tag: 'logo',
              child: Container(
                height: 200.0,
                child: Image.asset('images/logo.png'),
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            TextField(
              onChanged: (value) {
                //Do something with the user input.
              },
              decoration: kTextFieldDecoration.copyWith(hintText: 'Username'),
            ),
            SizedBox(
              height: spaceBetweenFields,
            ),
            TextField(
              onChanged: (value) {
                //Do something with the user input.
              },
              decoration: kTextFieldDecoration.copyWith(hintText: 'Full Name'),
            ),
            SizedBox(
              height: spaceBetweenFields,
            ),
            TextField(
              onChanged: (value) {
                //Do something with the user input.
              },
              decoration: kTextFieldDecoration.copyWith(hintText: 'Email'),
            ),
            SizedBox(
              height: spaceBetweenFields,
            ),
            TextField(
              onChanged: (value) {
                //Do something with the user input.
              },
              decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Telephone Number (optional)'),
            ),
            SizedBox(
              height: spaceBetweenFields,
            ),
            TextField(
              onChanged: (value) {
                //Do something with the user input.
              },
              decoration: kTextFieldDecoration.copyWith(hintText: 'Password'),
            ),
            SizedBox(
              height: spaceBetweenFields,
            ),
            TextField(
              onChanged: (value) {
                //Do something with the user input.
              },
              decoration:
                  kTextFieldDecoration.copyWith(hintText: 'Confirm password'),
            ),
            SizedBox(
              height: 24.0,
            ),
            RoundedButton(
              color: Colors.blue,
              onPressed: () {
                //implement registration
              },
              title: 'Register',
            ),
          ],
        ),
      ),
    );
  }
}
