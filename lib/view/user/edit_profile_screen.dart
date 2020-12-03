import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:timecapturesystem/components/dialog_boxes.dart';
import 'package:timecapturesystem/models/user/user.dart';
import 'package:timecapturesystem/services/user_service.dart';
import 'package:timecapturesystem/view/auth/change_password_screen.dart';

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
          child: new ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  new Container(
                    height: 250.0,
                    color: Colors.white,
                    child: new Column(
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(left: 20.0, top: 20.0),
                            child: new Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(left: 0.0),
                                  child: new Text('Edit Profile',
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
                          child:
                              new Stack(fit: StackFit.loose, children: <Widget>[
                            new Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Container(
                                    width: 140.0,
                                    height: 140.0,
                                    decoration: new BoxDecoration(
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
                  new Container(
                    color: Color(0xffFFFFFF),
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 2.0),
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 18.0, right: 25.0, top: 2.0),
                              child: new Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        'Personal Information',
                                        style: TextStyle(
                                            fontSize: 19.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  new Column(
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
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
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
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Flexible(
                                    child: new TextField(
                                      decoration: const InputDecoration()
                                          .copyWith(
                                              hintText: _usernameHintText),
                                      enabled: !_status,
                                      autofocus: !_status,
                                      controller: _usernameController,
                                    ),
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
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
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Flexible(
                                    child: new TextField(
                                      decoration: const InputDecoration()
                                          .copyWith(
                                              hintText: _fullNameHintText),
                                      enabled: !_status,
                                      autofocus: !_status,
                                      controller: _fullNameController,
                                    ),
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
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
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Flexible(
                                    child: new TextField(
                                      decoration: const InputDecoration()
                                          .copyWith(hintText: _emailHintText),
                                      enabled: !_status,
                                      controller: _emailController,
                                    ),
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
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
                                      decoration: InputDecoration().copyWith(
                                          hintText: _telephoneNumberHintText),
                                      enabled: !_status,
                                      controller: _telephoneNumberController,
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
      child: new Row(
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
                  if (_usernameController.text.isNotEmpty ||
                      _fullNameController.text.isNotEmpty ||
                      _emailController.text.isNotEmpty ||
                      _telephoneNumberController.text.isNotEmpty) {
                    //send request
                    displayUpdateDialog(context);
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
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
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
                    _usernameController.text,
                    _fullNameController.text,
                    _emailController.text,
                    _telephoneNumberController.text);

                if (success) {
                  //if success login page
                  updateSuccessDialog(context);
                } else {
                  Navigator.pop(context);
                }
              },
            ),
            FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                color: Colors.redAccent,
                child: Text("Cancel"))
          ],
        ),
      );
}
