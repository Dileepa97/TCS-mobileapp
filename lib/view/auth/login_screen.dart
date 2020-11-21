import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:timecapturesystem/components/dialog_box.dart';
import 'package:timecapturesystem/components/rounded_button.dart';
import 'package:timecapturesystem/services/AuthService.dart';

import 'package:timecapturesystem/main.dart' as app;
import 'package:timecapturesystem/view/auth/registration_screen.dart';

import '../constants.dart';

class LoginScreen extends StatefulWidget {
  static const String id = "login_screen";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool spin = false;

  Color usernameInitColor = Colors.lightBlueAccent;
  Color passwordInitColor = Colors.lightBlueAccent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: spin,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                SizedBox(
                  height: 80.0,
                ),
                Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
                SizedBox(
                  height: 40.0,
                ),
                TextField(
                  controller: _usernameController,
                  onChanged: (value) {
                    //Do something with the user input.
                  },
                  onTap: () {
                    setState(() {
                      usernameInitColor = Colors.lightBlueAccent;
                    });
                  },
                  decoration: inputDeco(usernameInitColor)
                      .copyWith(hintText: 'Username'),
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
                  onTap: () {
                    setState(() {
                      passwordInitColor = Colors.lightBlueAccent;
                    });
                  },
                  decoration: inputDeco(passwordInitColor)
                      .copyWith(hintText: 'Password'),
                ),
                SizedBox(
                  height: 20.0,
                ),
                RoundedButton(
                  color: Colors.lightBlueAccent,
                  onPressed: () async {
                    if (_usernameController.text.isEmpty ||
                        _passwordController.text.isEmpty) {
                      if (_usernameController.text.isEmpty) {
                        setState(() {
                          usernameInitColor = Colors.redAccent;
                        });
                      }
                      if (_passwordController.text.isEmpty) {
                        setState(() {
                          passwordInitColor = Colors.redAccent;
                        });
                      }

                      return;
                    }

                    setState(() {
                      spin = true;
                    });
                    //implement login
                    try {
                      int code = await AuthService.login(
                          _usernameController.text, _passwordController.text);
                      if (code == 1) {
                        //login success
                        app.main();
                        Navigator.popAndPushNamed(context, '/');
                      } else {
                        if (code == 404) {
                          displayDialog(context, "Invalid User",
                              "user with given username has not registered in the system");
                        } else if (code == 401) {
                          displayDialog(context, "Bad Credentials",
                              "Invalid username or password");
                        } else {
                          displayDialog(context, "Unknown Error",
                              "An Unknown Error Occurred");
                        }
                        setState(() {
                          usernameInitColor = Colors.redAccent;
                          passwordInitColor = Colors.redAccent;
                          spin = false;
                        });
                      }
                    } catch (e) {
                      displayDialog(context, "Error", e.toString());
                      print(e.toString());
                      spin = false;
                    }
                  },
                  title: 'Login',
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text('or')],
                ),
                RoundedButton(
                  color: Colors.greenAccent[700],
                  onPressed: () {
                    Navigator.pushNamed(context, RegistrationScreen.id);
                  },
                  title: 'Create New Account',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
