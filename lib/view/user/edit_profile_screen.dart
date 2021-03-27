import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:timecapturesystem/components/dialog_boxes.dart';
import 'package:timecapturesystem/models/user/user.dart';
import 'package:timecapturesystem/services/other/storage_service.dart';
import 'package:timecapturesystem/services/user/user_service.dart';
import 'package:timecapturesystem/view/auth/change_password_screen.dart';
import 'package:timecapturesystem/view/auth/login_screen.dart';

import '../constants.dart';
import 'pick_image_screen.dart';

var apiEndpoint = DotEnv().env['API_URL'].toString();

var fileAPI = apiEndpoint + 'files/';

class EditProfile extends StatefulWidget {
  static const String id = "edit_profile";
  final User user;

  const EditProfile({Key key, this.user}) : super(key: key);
  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<EditProfile>
    with SingleTickerProviderStateMixin {
  bool _status = true;

  final FocusNode myFocusNode = FocusNode();

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _telephoneNumberController = TextEditingController();

  Color _usernameInitColor = Colors.lightBlueAccent;
  Color _fullNameInitColor = Colors.lightBlueAccent;
  Color _emailInitColor = Colors.lightBlueAccent;
  Color _telephoneNumberInitColor = Colors.lightBlueAccent;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var user = widget.user;
    String _usernameHintText = user.username;
    String _fullNameHintText = user.fullName;
    String _emailHintText = user.email;
    String _telephoneNumberHintText = user.telephoneNumber;
    setState(() {});
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    height: 250.0,
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(left: 20.0, top: 20.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 110.0, right: 110, bottom: 20),
                                  child: Text('Edit Profile',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0,
                                          fontFamily: 'sans-serif-light',
                                          color: Colors.black)),
                                )
                              ],
                            )),
                        Padding(
                          padding: EdgeInsets.only(top: 2.0),
                          child: Stack(fit: StackFit.loose, children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                    width: 140.0,
                                    height: 140.0,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: user == null
                                            ? ExactAssetImage('images/as.png')
                                            : NetworkImage(
                                                fileAPI + user.profileImageURL),
                                        fit: BoxFit.cover,
                                      ),
                                    )),
                              ],
                            ),
                            Padding(
                                padding:
                                    EdgeInsets.only(top: 90.0, right: 100.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, PickImageScreen.id);
                                      },
                                      child: CircleAvatar(
                                        backgroundColor: Colors.redAccent,
                                        radius: 25.0,
                                        child: Icon(
                                          Icons.camera_alt,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  ],
                                )),
                          ]),
                        )
                      ],
                    ),
                  ),
                  Container(
                    color: Color(0xffFFFFFF),
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 2.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 18.0, right: 25.0, top: 2.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text(
                                        'Personal Information',
                                        style: TextStyle(
                                            fontSize: 19.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      _status ? (_getEditIcon()) : Container(),
                                    ],
                                  )
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text(
                                        'Username',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Flexible(
                                    child: TextField(
                                      controller: _usernameController,
                                      decoration: inputDecoForEdit(
                                          _usernameInitColor,
                                          _usernameController,
                                          _usernameHintText,
                                          _status),
                                      onChanged: (value) {
                                        checkUsername(value);
                                      },
                                    ),
                                  )
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text(
                                        'Full Name',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Flexible(
                                    child: TextField(
                                      controller: _fullNameController,
                                      decoration: inputDecoForEdit(
                                          _fullNameInitColor,
                                          _fullNameController,
                                          _fullNameHintText,
                                          _status),
                                    ),
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text(
                                        'Email',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Flexible(
                                    child: TextField(
                                        controller: _emailController,
                                        decoration: inputDecoForEdit(
                                            _emailInitColor,
                                            _emailController,
                                            _emailHintText,
                                            _status)),
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text(
                                        'Telephone Number',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Flexible(
                                    child: TextField(
                                      controller: _telephoneNumberController,
                                      decoration: inputDecoForEdit(
                                          _telephoneNumberInitColor,
                                          _telephoneNumberController,
                                          _telephoneNumberHintText,
                                          _status),
                                    ),
                                  ),
                                ],
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          !_status ? _getActionButtons() : Container()
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ));
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }

  Widget _getActionButtons() {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Container(
                  child: RaisedButton(
                child: Text("Update"),
                textColor: Colors.white,
                color: Colors.lightBlue.shade700,
                onPressed: () async {
                  if ((_usernameController.text.trim() != null &&
                          _usernameController.text.trim() != '') ||
                      (_fullNameController.text.trim() != null &&
                          _fullNameController.text.trim() != '') ||
                      (_emailController.text.trim() != null &&
                          _emailController.text.trim() != '') ||
                      (_telephoneNumberController.text.trim() != null &&
                          _telephoneNumberController.text.trim() != '')) {
                    displayUpdateDialog(context);

                    //send request
                  } else {
                    displayDialog(context, "Form Empty",
                        "You must fill at least one value to update");
                  }
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
              )),
            ),
            flex: 2,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Container(
                  child: RaisedButton(
                child: Text("Cancel"),
                textColor: Colors.white,
                color: Colors.red,
                onPressed: () {
                  setState(() {
                    _status = true;

                    FocusScope.of(context).requestFocus(FocusNode());
                  });
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
              )),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }

  Widget _getEditIcon() {
    return Row(
      children: [
        GestureDetector(
          child: CircleAvatar(
            backgroundColor: Colors.redAccent,
            radius: 14.0,
            child: Icon(
              Icons.lock,
              color: Colors.white,
              size: 16.0,
            ),
          ),
          onTap: () {
            Navigator.pushNamed(context, ChangePasswordScreen.id);
          },
        ),
        SizedBox(
          width: 20,
        ),
        GestureDetector(
          child: CircleAvatar(
            backgroundColor: Colors.lightBlue.shade600,
            radius: 14.0,
            child: Icon(
              Icons.edit,
              color: Colors.white,
              size: 16.0,
            ),
          ),
          onTap: () async {
            setState(() {
              _status = false;
            });
          },
        ),
      ],
    );
  }

  void displayUpdateDialog(context) => showDialog(
        barrierColor: Colors.white70,
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Confirm Update"),
          content: Text(
              "Since your're updating profile you'll get UNVERIFIED\n\nHence an admin must verify your account for you to log back into the system again"),
          actions: [
            FlatButton(
              child: Text(
                "Confirm",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.green,
              onPressed: () async {
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pop(context);

                bool success = await UserService.updateUser(
                    context,
                    _usernameController.text.trim(),
                    _fullNameController.text.trim(),
                    _emailController.text.trim(),
                    _telephoneNumberController.text.trim());

                if (success) {
                  await TokenStorageService.clearStorage();
                  Navigator.pushReplacementNamed(context, LoginScreen.id);
                } else {
                  Navigator.pop(context);
                }
              },
            ),
            FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                color: Colors.redAccent,
                child: Text("Cancel"))
          ],
        ),
      );

  checkUsername(username) {
    if (username.length < 5 ||
        username.length > 20 ||
        !validateMyInput(username, r'^(?!\s*$)[a-zA-Z0-9]{5,20}$')) {
      setState(() {
        _usernameInitColor = Colors.redAccent.shade700;
      });
    } else {
      setState(() {
        _usernameInitColor = Colors.green.shade700;
      });
    }
  }

  checkFullName(fullName) {
    if (fullName.length < 5 ||
        fullName.length > 100 ||
        !validateMyInput(fullName, r'^(?!\s*$)[a-zA-Z ]{5,100}$')) {
      setState(() {
        _fullNameInitColor = Colors.redAccent.shade700;
      });
    } else {
      setState(() {
        _usernameInitColor = Colors.green.shade700;
      });
    }
  }

  checkEmail(email) {
    if (!validateMyInput(email,
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")) {
      setState(() {
        _emailInitColor = Colors.redAccent.shade700;
      });
      return;
    } else {
      setState(() {
        _usernameInitColor = Colors.green.shade700;
      });
    }
  }

  checkTelephone(telephoneNumber) {
    if (telephoneNumber.length < 9 ||
        telephoneNumber.length > 14 ||
        !validateMyInput(telephoneNumber, r'^(?!\s*$)[0-9+]{9,14}$')) {
      setState(() {
        _telephoneNumberInitColor = Colors.redAccent.shade700;
      });
      return;
    } else {
      setState(() {
        _usernameInitColor = Colors.green.shade700;
      });
    }
  }

  bool validateMyInput(String value, String pattern) {
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value))
      return false;
    else
      return true;
  }

  checkUsernameValidity() {
    String username = _usernameController.text.trim();
    if (username.length < 5 || username.length > 20) {
      setState(() {
        _usernameInitColor = Colors.redAccent.shade700;
      });
      displayDialog(context, "Invalid Username",
          "username must contain at least 5 characters or a maximum 20 character");
      return false;
    }
    if (!validateMyInput(username, r'^(?!\s*$)[a-zA-Z0-9]{5,20}$')) {
      setState(() {
        _usernameInitColor = Colors.redAccent.shade700;
      });
      displayDialog(context, "Invalid Username Format",
          "username can contain only alphanumeric characters");
      return false;
    }
    return true;
  }

  checkFullNameValidity() {
    String fullName = _fullNameController.text.trim();

    if (fullName.length < 5 || fullName.length > 100) {
      setState(() {
        _fullNameInitColor = Colors.redAccent.shade700;
      });
      displayDialog(context, "Invalid Full Name",
          "Full Name must contain at least 5 characters or a maximum of 100 characters");
      return false;
    }
    if (!validateMyInput(fullName, r'^(?!\s*$)[a-zA-Z ]{5,100}$')) {
      setState(() {
        _fullNameInitColor = Colors.redAccent.shade700;
      });
      displayDialog(context, "Invalid Full Name Format",
          "Full Name can only contain letters");
      return false;
    }

    return true;
  }

  checkEmailValidity() {
    String email = _emailController.text.trim();
    if (!validateMyInput(email,
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")) {
      setState(() {
        _emailInitColor = Colors.redAccent.shade700;
      });
      displayDialog(context, "Invalid Email", "Please enter a valid email");
      return false;
    }

    return true;
  }

  checkTelephoneValidity() {
    String telephoneNumber = _telephoneNumberController.text.trim();
    if (telephoneNumber.length < 9 || telephoneNumber.length > 14) {
      setState(() {
        _telephoneNumberInitColor = Colors.redAccent.shade700;
      });
      displayDialog(context, "Invalid telephone number",
          "telephone number must contain at least 9 characters or a maximum of 14 characters");
      return false;
    }
    if (!validateMyInput(telephoneNumber, r'^(?!\s*$)[0-9+]{9,14}$')) {
      setState(() {
        _telephoneNumberInitColor = Colors.redAccent.shade700;
      });
      displayDialog(context, "Invalid telephone number Format",
          "Telephone Number can only contain '+' and numbers");
      return false;
    }

    return true;
  }

  isValid() {
    int flag = 0;
    if (_usernameController.text.trim() != null ||
        _usernameController.text.trim() != '') {
      if (checkUsernameValidity()) {
        flag++;
      }
    }

    if (_emailController.text.trim() != null ||
        _emailController.text.trim() != '') {
      if (checkEmailValidity()) {
        flag++;
      }
    }

    if (_fullNameController.text.trim() != null ||
        _fullNameController.text.trim() != '') {
      if (checkFullNameValidity()) {
        flag++;
      }
    }

    if (_telephoneNumberController.text.trim() != null ||
        _telephoneNumberController.text.trim() != '') {
      if (checkTelephoneValidity()) {
        flag++;
      }
    }
    return flag == 0;
  }
}
