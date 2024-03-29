import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:timecapturesystem/components/dialog_boxes.dart';
import 'package:timecapturesystem/components/home_button.dart';
import 'package:timecapturesystem/components/rounded_button.dart';
import 'package:timecapturesystem/services/auth/auth_service.dart';

import '../constants.dart';

class ChangePasswordScreen extends StatefulWidget {
  static const String id = "change_password_screen";

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  static const double spaceBetweenFields = 15.0;
  bool spin = false;

  TextEditingController _oldPasswordController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  Color _oldPasswordInitColor = Colors.lightBlueAccent;
  Color _passwordInitColor = Colors.lightBlueAccent;
  Color _confirmPasswordInitColor = Colors.lightBlueAccent;

  bool passwordInvisible = true;
  IconData visibilityIcon = Icons.visibility;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black87,
        ),
        actions: [
          HomeButton(color: Colors.black87),
        ],
      ),
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
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  controller: _oldPasswordController,
                  onChanged: (value) {
                    //Do something with the user input.
                  },
                  onTap: () {
                    setState(() {
                      _oldPasswordInitColor = Colors.lightBlueAccent;
                    });
                  },
                  decoration:
                      inputDeco(_oldPasswordInitColor, _oldPasswordController)
                          .copyWith(
                    hintText: 'Current Password',
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          passwordInvisible = !passwordInvisible;
                          visibilityIcon = visibilityIcon == Icons.visibility
                              ? Icons.visibility_off
                              : Icons.visibility;
                        });
                      },
                      icon: Icon(
                        visibilityIcon,
                        color: Colors.black38,
                        size: 20,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: spaceBetweenFields,
                ),
                TextField(
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
                      .copyWith(
                    hintText: 'New Password',
                  ),
                ),
                SizedBox(
                  height: spaceBetweenFields,
                ),
                TextField(
                  obscureText: passwordInvisible,
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
                  height: 10.0,
                ),
                RoundedButton(
                  color: Colors.lightBlueAccent,
                  onPressed: () async {
                    var flag = 0;
                    if (_passwordController.text.trim().isEmpty) {
                      setState(() {
                        _passwordInitColor = Colors.redAccent;
                      });
                      flag++;
                    }
                    if (_confirmPasswordController.text.trim().isEmpty) {
                      setState(() {
                        _confirmPasswordInitColor = Colors.redAccent;
                      });
                      flag++;
                    }
                    if (_oldPasswordController.text.trim().isEmpty) {
                      setState(() {
                        _oldPasswordInitColor = Colors.redAccent;
                      });
                      flag++;
                    }

                    if (flag > 0) {
                      return;
                    }

                    if (!passwordsMatch()) {
                      return;
                    }
                    setState(() {
                      spin = true;
                    });
                    //implement login
                    try {
                      int code = await AuthService.changePassword(
                          _oldPasswordController.text,
                          _passwordController.text);
                      if (code == 1) {
                        displayPWDChangedSuccessDialog(context);
                        setState(() {
                          spin = true;
                        });
                      } else {
                        if (code == 404) {
                          displayDialog(
                              context, "Invalid User", "User not found");
                        } else if (code == 401) {
                          displayDialog(context, "Bad Credentials",
                              "Invalid old password");
                          setState(() {
                            _oldPasswordInitColor = Colors.lightBlueAccent;
                            spin = false;
                          });
                        } else {
                          displayDialog(
                              context, "Error", "An Unknown Error Occurred");
                        }
                        setState(() {
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

  passwordsMatch() {
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
