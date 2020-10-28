import 'package:flutter/material.dart';
import 'package:timecapturesystem/components/rounded_button.dart';

import '../constants.dart';

class LoginScreen extends StatefulWidget {
  static const String id = "login_screen";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
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
              controller: _usernameController,
              onChanged: (value) {
                //Do something with the user input.
              },
              decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your username'),
            ),
            SizedBox(
              height: 16.0,
            ),
            TextField(
              controller: _passwordController,
              onChanged: (value) {
                //Do something with the user input.
              },
              decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your password.'),
            ),
            SizedBox(
              height: 20.0,
            ),
            RoundedButton(
              color: Colors.lightBlueAccent,
              onPressed: () {
                //implement registration
              },
              title: 'Login',
            ),
          ],
        ),
      ),
    );
  }
}
