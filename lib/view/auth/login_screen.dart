import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:timecapturesystem/components/dialog_boxes.dart';
import 'package:timecapturesystem/components/rounded_button.dart';
import 'package:timecapturesystem/main.dart' as app;
import 'package:timecapturesystem/services/auth/auth_service.dart';
import 'package:timecapturesystem/view/auth/registration_screen.dart';

import '../constants.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key, this.username}) : super(key: key);
  static const String id = "login_screen";
  final String username;

  @override
  _LoginScreenState createState() => _LoginScreenState(this.username);
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _usernameController;
  final TextEditingController _passwordController = TextEditingController();

  _LoginScreenState(String username) {
    if (username != null) {
      this._usernameController = TextEditingController(text: username);
    } else
      _usernameController = TextEditingController();
  }

  bool spin = false;

  Color usernameInitColor = Colors.lightBlueAccent;
  Color passwordInitColor = Colors.lightBlueAccent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Capture System'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
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
                  height: 30.0,
                ),
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset(
                      'images/logo.png',
                    ),
                    height: 120,
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                // Center(
                //     child: Text(
                //   'Time Capture System',
                //   style: TextStyle(
                //       fontSize: 30,
                //       fontFamily: 'Roboto',
                //       fontWeight: FontWeight.w800),
                // )),
                SizedBox(
                  height: 50.0,
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
                  decoration: inputDeco(usernameInitColor, _usernameController)
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
                  decoration: inputDeco(passwordInitColor, _passwordController)
                      .copyWith(hintText: 'Password'),
                ),
                SizedBox(
                  height: 20.0,
                ),
                RoundedButton(
                  color: Colors.lightBlueAccent,
                  onPressed: () async {
                    if (_usernameController.text.trim().isEmpty ||
                        _passwordController.text.trim().isEmpty) {
                      if (_usernameController.text.trim().isEmpty) {
                        setState(() {
                          usernameInitColor = Colors.redAccent;
                        });
                      }
                      if (_passwordController.text.trim().isEmpty) {
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
                          _usernameController.text.trim(),
                          _passwordController.text.trim());
                      if (code == 1) {
                        //login success
                        app.main();
                        Navigator.popAndPushNamed(context, '/');
                      } else {
                        if (code == 404) {
                          displayDialog(
                              context, "Invalid", "Check your credentials");
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
                      setState(() {
                        spin = false;
                      });
                    }
                  },
                  title: 'Log In',
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      child: Text(
                        'Forgotten Password?',
                        style: TextStyle(
                            color: Colors.blue[900],
                            fontWeight: FontWeight.w600),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, ForgotPasswordScreen.id);
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Divider(
                      height: 1.0,
                      color: Colors.black,
                    )),
                    Text("  OR  "),
                    Expanded(
                        child: Divider(
                      height: 1.0,
                      color: Colors.black,
                    )),
                  ],
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
