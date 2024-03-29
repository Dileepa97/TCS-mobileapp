import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:timecapturesystem/components/dialog_boxes.dart';
import 'package:timecapturesystem/components/rounded_button.dart';
import 'package:timecapturesystem/services/auth/auth_service.dart';

import '../constants.dart';

class ForgotPasswordChangeScreen extends StatefulWidget {
  static const String id = "forgot_password_change_screen";

  @override
  _ForgotPasswordChangeScreenState createState() =>
      _ForgotPasswordChangeScreenState();
}

class _ForgotPasswordChangeScreenState
    extends State<ForgotPasswordChangeScreen> {
  static const double spaceBetweenFields = 15.0;
  bool spin = false;

  TextEditingController _codeController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  Color codeInitColor = Colors.lightBlueAccent;
  Color _passwordInitColor = Colors.lightBlueAccent;
  Color _confirmPasswordInitColor = Colors.lightBlueAccent;

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
                  height: 80.0,
                ),
                TextField(
                  controller: _codeController,
                  onChanged: (value) {
                    //Do something with the user input.
                  },
                  onTap: () {
                    setState(() {
                      codeInitColor = Colors.lightBlueAccent;
                    });
                  },
                  decoration: inputDeco(codeInitColor, _codeController)
                      .copyWith(hintText: 'Code'),
                ),
                SizedBox(
                  height: spaceBetweenFields,
                ),
                TextField(
                  enableInteractiveSelection: false,
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  controller: _passwordController,
                  onChanged: (value) {
                    //Do something with the user input.
                  },
                  onTap: () {
                    setState(() {
                      _passwordInitColor = Colors.lightBlueAccent;
                    });
                  },
                  decoration: inputDeco(_passwordInitColor, _passwordController)
                      .copyWith(hintText: 'Password'),
                ),
                SizedBox(
                  height: spaceBetweenFields,
                ),
                TextField(
                  enableInteractiveSelection: false,
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  controller: _confirmPasswordController,
                  onChanged: (value) {
                    //Do something with the user input.
                  },
                  onTap: () {
                    setState(() {
                      _confirmPasswordInitColor = Colors.lightBlueAccent;
                    });
                  },
                  decoration: inputDeco(
                          _confirmPasswordInitColor, _confirmPasswordController)
                      .copyWith(hintText: 'Confirm password'),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  'Please check your email for the reset code',
                  style: TextStyle(
                    color: Colors.redAccent,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10.0,
                ),
                RoundedButton(
                  color: Colors.lightBlueAccent,
                  onPressed: () async {
                    if (_codeController.text.trim().isEmpty) {
                      setState(() {
                        codeInitColor = Colors.redAccent;
                      });
                      return;
                    }

                    if (!PasswordsMatch()) {
                      return;
                    }

                    setState(() {
                      spin = true;
                    });
                    //implement login
                    try {
                      int code = await AuthService.forgotPasswordChange(
                          _passwordController.text.trim(),
                          _codeController.text.trim());
                      if (code == 1) {
                        displayPWDResetSuccessDialog(context);
                        setState(() {
                          spin = true;
                        });
                      } else {
                        if (code == 404) {
                          displayDialog(context, "Invalid Code",
                              "The code you entered is invalid");
                        } else if (code == 401) {
                          displayDialog(
                              context, "Bad Credentials", "Invalid code");
                        } else {
                          displayDialog(
                              context, "Error", "An Unknown Error Occurred");
                        }
                        setState(() {
                          codeInitColor = Colors.redAccent;
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
                  title: 'Submit',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  PasswordsMatch() {
    if (_passwordController.text.trim() !=
        _confirmPasswordController.text.trim()) {
      setState(() {
        _confirmPasswordInitColor = Colors.redAccent.shade700;
        _passwordInitColor = Colors.redAccent.shade700;
      });
      displayDialog(context, "Password Mismatch",
          "Confirmation password did not match with your password");
      return false;
    } else {
      _confirmPasswordInitColor = Colors.blueAccent;
      _passwordInitColor = Colors.blueAccent;
      return true;
    }
  }
}

bool isEmail(String em) {
  String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = new RegExp(p);
  return regExp.hasMatch(em);
}
