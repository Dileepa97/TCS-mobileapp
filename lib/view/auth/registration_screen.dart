import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:timecapturesystem/components/dialog_box.dart';
import 'package:timecapturesystem/components/rounded_button.dart';
import 'package:timecapturesystem/services/AuthService.dart';

import '../constants.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = "registration_screen";

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  static const double spaceBetweenFields = 16.0;

  //form controllers

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _telephoneNumberController =
      TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool spin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: spin,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              SizedBox(
                height: 35.0,
              ),
              Hero(
                tag: 'logo',
                child: Container(
                  height: 200.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: _usernameController,
                onChanged: (value) {
                  //Do something with the user input.
                },
                decoration: inputDeco(Colors.lightBlueAccent)
                    .copyWith(hintText: 'Username'),
              ),
              SizedBox(
                height: spaceBetweenFields,
              ),
              TextField(
                controller: _fullNameController,
                onChanged: (value) {
                  //Do something with the user input.
                },
                decoration: inputDeco(Colors.lightBlueAccent)
                    .copyWith(hintText: 'Full Name'),
              ),
              SizedBox(
                height: spaceBetweenFields,
              ),
              TextField(
                controller: _emailController,
                onChanged: (value) {
                  //Do something with the user input.
                },
                decoration: inputDeco(Colors.lightBlueAccent)
                    .copyWith(hintText: 'Email'),
              ),
              SizedBox(
                height: spaceBetweenFields,
              ),
              TextField(
                controller: _telephoneNumberController,
                onChanged: (value) {
                  //Do something with the user input.
                },
                decoration: inputDeco(Colors.lightBlueAccent)
                    .copyWith(hintText: 'Telephone Number'),
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
                decoration: inputDeco(Colors.lightBlueAccent)
                    .copyWith(hintText: 'Password'),
              ),
              SizedBox(
                height: spaceBetweenFields,
              ),
              TextField(
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                controller: _confirmPasswordController,
                onChanged: (value) {
                  //Do something with the user input.
                },
                decoration: inputDeco(Colors.lightBlueAccent)
                    .copyWith(hintText: 'Confirm password'),
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                color: Colors.blue,
                onPressed: () async {
                  setState(() {
                    spin = true;
                  });
                  //implement registration
                  if (_passwordController.text ==
                      _confirmPasswordController.text) {
                    try {
                      bool registered = await AuthService.register(
                          context,
                          _usernameController.text,
                          _fullNameController.text,
                          _telephoneNumberController.text,
                          _emailController.text,
                          _passwordController.text);

                      if (registered) {
                        setState(() {
                          _usernameController.clear();
                          _fullNameController.clear();
                          _telephoneNumberController.clear();
                          _emailController.clear();
                          _passwordController.clear();
                          _confirmPasswordController.clear();
                        });

                        displayRegSuccessDialog(context);
                      }
                    } catch (e) {
                      displayDialog(
                          context, "Error", "An Unknown Error Occurred");
                    }
                  } else {
                    displayDialog(context, "Password Mismatch",
                        "Confirmation password did not match with your password");
                  }
                  setState(() {
                    spin = false;
                  });
                },
                title: 'Register',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
