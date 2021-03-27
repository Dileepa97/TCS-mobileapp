import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:timecapturesystem/components/dialog_boxes.dart';
import 'package:timecapturesystem/components/rounded_button.dart';
import 'package:timecapturesystem/services/auth/auth_service.dart';
import 'package:timecapturesystem/view/auth/forgot_password_change.dart';

import '../constants.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const String id = "forgot_password_screen";

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();

  bool spin = false;

  Color emailInitColor = Colors.lightBlueAccent;

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
                  height: 100.0,
                ),
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    //Do something with the user input.
                  },
                  onTap: () {
                    setState(() {
                      emailInitColor = Colors.lightBlueAccent;
                    });
                  },
                  decoration: inputDeco(emailInitColor, _emailController)
                      .copyWith(hintText: 'Email'),
                ),
                SizedBox(
                  height: 20.0,
                ),
                RoundedButton(
                  color: Colors.lightBlueAccent,
                  onPressed: () async {
                    if (_emailController.text.trim().isEmpty) {
                      setState(() {
                        emailInitColor = Colors.redAccent;
                      });

                      return;
                    } else {
                      if (!isEmail(_emailController.text.trim())) {
                        setState(() {
                          emailInitColor = Colors.redAccent;
                        });

                        return;
                      }
                    }

                    setState(() {
                      spin = true;
                    });
                    //implement login
                    try {
                      int code = await AuthService.forgotPassword(
                        _emailController.text.trim(),
                      );
                      if (code == 200) {
                        Navigator.popAndPushNamed(
                            context, ForgotPasswordChangeScreen.id);
                      } else {
                        if (code == 404) {
                          displayDialog(
                              context, "Invalid Email", "Email not found");
                        } else if (code == 401) {
                          displayDialog(
                              context, "Bad Credentials", "Invalid email");
                        } else {
                          displayDialog(
                              context, "Error", "An Unknown Error Occurred");
                        }
                        setState(() {
                          emailInitColor = Colors.redAccent;
                          spin = false;
                        });
                      }
                    } catch (e) {
                      displayDialog(context, "Error", e.toString());
                      print(e.toString());
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
}

bool isEmail(String em) {
  String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  RegExp regExp = new RegExp(p);

  return regExp.hasMatch(em);
}
