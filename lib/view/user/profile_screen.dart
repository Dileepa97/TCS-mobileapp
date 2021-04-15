import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:timecapturesystem/components/home_button.dart';
import 'package:timecapturesystem/models/user/user.dart';
import 'package:timecapturesystem/services/user/user_service.dart';
import 'package:timecapturesystem/view/user/edit_profile_screen.dart';

var apiEndpoint = DotEnv().env['API_URL'].toString();
var fileAPI = apiEndpoint + 'files/';

class Profile extends StatefulWidget {
  static const String id = "profile_screen";

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade800,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.lightBlue.shade800,
        actions: [HomeButton()],
      ),
      body: SafeArea(
        child: FutureBuilder<User>(
          future: UserService.getLoggedInUser(),
          builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
            List<Widget> children;
            if (snapshot.hasData) {
              User _user = snapshot.data;
              var vIcon = _user.verified ? Icons.verified : Icons.cancel;
              var vIconColor =
                  _user.verified ? Colors.lightGreenAccent : Colors.redAccent;

              children = <Widget>[
                Center(
                  child: Text(
                    _user.fullName,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 40.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Center(
                  child: CircleAvatar(
                    radius: 100.0,
                    backgroundImage: _user.profileImageURL == 'default.png'
                        ? AssetImage('images/default.png')
                        : NetworkImage(fileAPI + _user.profileImageURL),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Center(
                  child: Text(
                    _user.username,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      color: Colors.black87,
                      fontSize: 20.0,
                      letterSpacing: 2.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text(
                          _user.title != null ? _user.title.name : '',
                          style: TextStyle(
                            fontFamily: 'Source Sans Pro',
                            color: Colors.white70,
                            fontSize: 20.0,
                            letterSpacing: 2.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Icon(
                          vIcon,
                          color: vIconColor,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                  width: 350.0,
                  child: Divider(
                    color: Colors.lightBlueAccent.shade100,
                  ),
                ),
                Card(
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                    child: ListTile(
                      leading: Icon(
                        Icons.phone,
                        color: Colors.green.shade900,
                      ),
                      title: Text(
                        _user.telephoneNumber,
                        style: TextStyle(
                          color: Colors.blueGrey.shade900,
                          fontFamily: 'Source Sans Pro',
                          fontSize: 20.0,
                        ),
                      ),
                    )),
                Card(
                  margin:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.email,
                      color: Colors.blue.shade900,
                    ),
                    title: Text(
                      _user.email,
                      style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.blueGrey.shade900,
                          fontFamily: 'Source Sans Pro'),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.all(15),
                      child: FlatButton(
                        child: Text(
                          'Edit Details',
                          style: TextStyle(fontSize: 20.0),
                        ),
                        color: Colors.white,
                        textColor: Colors.black87,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditProfile(user: _user)),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ];
            } else if (snapshot.hasError) {
              children = <Widget>[
                Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 60,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text('Error: ${snapshot.error}'),
                )
              ];
            } else {
              children = <Widget>[
                SizedBox(
                  child: ModalProgressHUD(
                    inAsyncCall: false,
                    child: Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text('loading'),
                    ),
                  ),
                ),
              ];
            }
            return Center(
              child: ListView(
                shrinkWrap: true,
                children: children,
              ),
            );
          },
        ),
      ),
    );
  }
}
