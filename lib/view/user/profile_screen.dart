import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:timecapturesystem/mixins/orientation.dart';
import 'package:timecapturesystem/models/user/user.dart';
import 'package:timecapturesystem/services/user_service.dart';
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
      body: SafeArea(
        child: FutureBuilder<User>(
          future: UserService.getLoggedInUser(),
          builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
            List<Widget> children;
            if (snapshot.hasData) {
              var _user = snapshot.data;
              var vIcon = _user.verified ? Icons.verified : Icons.cancel;
              var vIconColor =
                  _user.verified ? Colors.lightGreenAccent : Colors.redAccent;

              children = <Widget>[
                Text(
                  _user.fullName,
                  style: TextStyle(
                    fontFamily: 'Maven Pro',
                    fontSize: 40.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CircleAvatar(
                  radius: 90.0,
                  backgroundImage:
                      NetworkImage(fileAPI + _user.profileImageURL),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  _user.username,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    color: Colors.black87,
                    fontSize: 20.0,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text(
                          _user.title != null ? _user.title : '',
                          style: TextStyle(
                            fontFamily: 'Source Sans Pro',
                            color: Colors.white70,
                            fontSize: 20.0,
                            letterSpacing: 2.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 5.0,
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
                  width: 150.0,
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
                          fontSize: 17.0,
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
                  child: CircularProgressIndicator(),
                  width: 60,
                  height: 60,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text('loading'),
                )
              ];
            }
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: children,
              ),
            );
          },
        ),
      ),
    );
  }
}
