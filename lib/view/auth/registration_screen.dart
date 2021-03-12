import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:timecapturesystem/components/dialog_boxes.dart';
import 'package:timecapturesystem/components/rounded_button.dart';
import 'package:timecapturesystem/models/auth/title.dart' as titleModel;
import 'package:timecapturesystem/services/auth/auth_service.dart';
import 'package:timecapturesystem/services/auth/title_service.dart';

import '../constants.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = "registration_screen";

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  static const double spaceBetweenFields = 15.0;

  //form controllers

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _telephoneNumberController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  Color _usernameInitColor = Colors.lightBlueAccent;
  Color _fullNameInitColor = Colors.lightBlueAccent;
  Color _emailInitColor = Colors.lightBlueAccent;
  Color _telephoneNumberInitColor = Colors.lightBlueAccent;
  Color _passwordInitColor = Colors.lightBlueAccent;
  Color _confirmPasswordInitColor = Colors.lightBlueAccent;

  bool spin = false;
  var gender;

  var _titleName;
  var titleNames = ['None'];
  var titles;
  titleModel.Title _title;

  var onProbationary = false;

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
                  height: 30.0,
                ),
                Hero(
                  tag: 'logo',
                  child: Container(
                    height: 100.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
                SizedBox(
                  height: 17.0,
                ),
                TextField(
                  controller: _usernameController,
                  onChanged: (value) {
                    //Do something with the user input.
                  },
                  onTap: () {
                    setState(() {
                      _usernameInitColor = Colors.lightBlueAccent;
                    });
                  },
                  decoration: inputDeco(_usernameInitColor)
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
                  onTap: () {
                    setState(() {
                      _fullNameInitColor = Colors.lightBlueAccent;
                    });
                  },
                  decoration: inputDeco(_fullNameInitColor)
                      .copyWith(hintText: 'Full Name'),
                ),
                SizedBox(
                  height: spaceBetweenFields,
                ),
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    //Do something with the user input.
                  },
                  onTap: () {
                    setState(() {
                      _emailInitColor = Colors.lightBlueAccent;
                    });
                  },
                  decoration:
                      inputDeco(_emailInitColor).copyWith(hintText: 'Email'),
                ),
                SizedBox(
                  height: spaceBetweenFields,
                ),
                TextField(
                  controller: _telephoneNumberController,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    //Do something with the user input.
                  },
                  onTap: () {
                    setState(() {
                      _telephoneNumberInitColor = Colors.lightBlueAccent;
                    });
                  },
                  decoration: inputDeco(_telephoneNumberInitColor)
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
                  onTap: () {
                    setState(() {
                      _passwordInitColor = Colors.lightBlueAccent;
                    });
                  },
                  decoration: inputDeco(_passwordInitColor)
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
                  onTap: () {
                    setState(() {
                      _confirmPasswordInitColor = Colors.lightBlueAccent;
                    });
                  },
                  decoration: inputDeco(_confirmPasswordInitColor)
                      .copyWith(hintText: 'Confirm password'),
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Gender : ",
                      style: TextStyle(fontSize: 17),
                    ),
                    Text(
                      "Male",
                      style: TextStyle(fontSize: 17),
                    ),
                    Radio(
                      value: 'Male',
                      groupValue: gender,
                      onChanged: (value) {
                        setState(() {
                          gender = value;
                          print(gender);
                        });
                      },
                    ),
                    Text(
                      "Female",
                      style: TextStyle(fontSize: 17),
                    ),
                    Radio(
                      value: 'Female',
                      groupValue: gender,
                      onChanged: (value) {
                        setState(() {
                          gender = value;
                        });
                      },
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Row(
                    children: [
                      Text(
                        'On Probationary ?',
                        style: TextStyle(fontSize: 17.0),
                      ),
                      Checkbox(
                        checkColor: Colors.greenAccent,
                        activeColor: Colors.red,
                        value: this.onProbationary,
                        onChanged: (bool value) {
                          setState(() {
                            this.onProbationary = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: FutureBuilder<dynamic>(
                    future: TitleService.getTitles(),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.hasData) {
                        titles = Map.fromIterable(snapshot.data,
                            key: (e) => e.name, value: (e) => e.id);
                        titleNames = [];
                        for (titleModel.Title title in snapshot.data) {
                          titleNames.add(title.name);
                        }
                      }
                      return dropDownList(titleNames);
                    },
                  ),
                ),
                RoundedButton(
                  color: Colors.blue,
                  onPressed: () async {
                    setState(() {
                      spin = true;
                    });
                    //implement registration
                    if (checkValidity()) {
                      await registerUser();
                      setState(() {
                        spin = false;
                      });
                    } else {
                      setState(() {
                        spin = false;
                      });
                    }
                  },
                  title: 'Register',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  checkValidity() {
    int flag = 0;
    //TODO : add more validation
    if (_usernameController.text.isEmpty) {
      flag++;
      setState(() {
        _usernameInitColor = Colors.redAccent;
      });
      return false;
    }

    if (_fullNameController.text.isEmpty) {
      flag++;
      setState(() {
        _fullNameInitColor = Colors.redAccent;
      });
    }

    if (_emailController.text.isEmpty) {
      flag++;
      setState(() {
        _emailInitColor = Colors.redAccent;
      });
    }

    if (_telephoneNumberController.text.isEmpty) {
      flag++;
      setState(() {
        _telephoneNumberInitColor = Colors.redAccent;
      });
    }

    if (_passwordController.text.isEmpty) {
      flag++;
      setState(() {
        _passwordInitColor = Colors.redAccent;
      });
    }

    if (_confirmPasswordController.text.isEmpty) {
      flag++;
      setState(() {
        _confirmPasswordInitColor = Colors.redAccent;
      });
    }

    checkPasswordMatch();

    if (gender == null) {
      flag++;
      displayDialog(context, "Select Gender", "Please select a gender");
    }

    return flag == 0;
  }

  checkPasswordMatch() {
    if (_passwordController.text != _confirmPasswordController.text) {
      setState(() {
        _confirmPasswordInitColor = Colors.redAccent.shade700;
        _passwordInitColor = Colors.redAccent.shade700;
      });
      displayDialog(context, "Password Mismatch",
          "Confirmation password did not match with your password");
    } else {
      _confirmPasswordInitColor = Colors.blueAccent;
      _passwordInitColor = Colors.blueAccent;
    }
  }

  registerUser() async {
    try {
      bool registered = await AuthService.register(
          context,
          _usernameController.text,
          _fullNameController.text,
          _telephoneNumberController.text,
          _emailController.text,
          _passwordController.text,
          gender,
          _title,
          onProbationary);
      if (registered) {
        displayRegSuccessDialog(context);
      }
    } catch (e) {
      displayDialog(context, "Error", e.toString());
    }
  }

  dropDownList(inputTitles) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: _titleName,
        hint: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Title'),
          ],
        ),
        items: inputTitles.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onTap: () async {},
        onChanged: (String value) {
          setState(() {
            _titleName = value;
            _title = titleModel.Title(titles[value], value);
          });
        },
      ),
    );
  }
}
