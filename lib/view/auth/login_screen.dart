import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:timecapturesystem/components/dialog_box.dart';
import 'package:timecapturesystem/components/rounded_button.dart';
import 'package:timecapturesystem/services/AuthService.dart';
import 'package:timecapturesystem/view/auth/profile.dart';

import '../constants.dart';

class LoginScreen extends StatefulWidget {
  static const String id = "login_screen";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  bool spin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: spin,
        child: Padding(
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
                obscureText: true,
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
                onPressed: () async {
                  setState(() {
                    spin = true;
                  });
                  //implement login
                  try {
                    int code = await _authService.login(
                        _usernameController.text, _passwordController.text);
                    if (code == 1) {
                      //login success
                      Navigator.pushNamed(context, Profile.id);
                    } else if (code == 404) {
                      displayDialog(context, "Invalid User",
                          "user with given username has not registered in the system");
                    } else if (code == 401) {
                      displayDialog(context, "Bad Credentials",
                          "Invalid username or password");
                    } else {
                      displayDialog(context, "Unknown Error",
                          "An Unknown Error Occurred");
                    }
                  } catch (e) {
                    displayDialog(context, "Error", e.toString());
                    print(e.toString());
                  }

                  setState(() {
                    spin = false;
                    _usernameController.text = "";
                    _passwordController.text = "";
                  });
                },
                title: 'Login',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//welkfjwkle
